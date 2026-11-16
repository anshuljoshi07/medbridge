import 'package:med_core/src/domain/dose_form.dart';
import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/plan_item.dart';
import 'package:med_core/src/domain/rule_set.dart';
import 'package:med_core/src/domain/strength.dart';
import 'package:med_core/src/parse/confidence.dart';
import 'package:med_core/src/parse/lexicon.dart';
import 'package:med_core/src/parse/ocr_types.dart';
import 'package:med_core/src/parse/plan_draft.dart';
import 'package:med_core/src/parse/text_similarity.dart';
import 'package:med_core/src/sig/sig_parser.dart';

final _bullet = RegExp(r'^\s*([•\-\*·]|\d+[.)])\s*');
final _verbStart = RegExp(
  r'\b(take|inhale|apply|instill|inject|place|use|put|chew|dissolve)\b',
  caseSensitive: false,
);
final _brand = RegExp(r'commonly known as:?\s*(.+)$', caseSensitive: false);
final _until = RegExp(r'^(hold\s+)?(until|resume)\b', caseSensitive: false);
final _date = RegExp(r'(\d{1,2})/(\d{1,2})/(\d{4})');

/// Minimum lexicon score for a line to count as a drug line.
const double drugLineMinScore = 0.8;

/// Parses discharge-summary OCR lines into a [PlanDraft] (A7.1).
///
/// Section headers set each item's action. Lines inside a medication section
/// that cannot be parsed go to `unrecognized` and are never dropped. Total.
PlanDraft parseAvs(
  List<OcrLine> lines,
  Lexicon lx,
  AvsRules avs,
  SigRules sig,
  RuleConfig config,
) {
  final b = _AvsBuilder(lx, sig, config);
  _Section? section;
  for (final line in lines) {
    final text = line.text.replaceFirst(_bullet, '').trim();
    if (text.isEmpty) continue;
    final colon = text.indexOf(':');
    final head = colon < 0 ? text : text.substring(0, colon);
    final header = _until.hasMatch(text) ? null : _headerOf(head, avs);
    var body = text;
    if (header != null) {
      b.flush();
      section = header;
      // "Allergies: Penicillin" — content after the colon still counts.
      body = colon < 0 ? '' : text.substring(colon + 1).trim();
      if (body.isEmpty) continue;
    }
    switch (section) {
      case null || _EndSection():
        if (b.looksLikeDrug(body)) b.unrecognized.add(line);
      case _AllergySection():
        b.allergies.addAll(_allergyTerms(body, avs));
      case _ActionSection(:final action):
        b.medLine(line, body, action);
    }
  }
  b.flush();
  return PlanDraft(
    items: b.items,
    unrecognized: b.unrecognized,
    allergies: b.allergies,
  );
}

sealed class _Section {
  const _Section();
}

final class _ActionSection extends _Section {
  const _ActionSection(this.action);
  final PlanAction action;
}

final class _AllergySection extends _Section {
  const _AllergySection();
}

final class _EndSection extends _Section {
  const _EndSection();
}

_Section? _headerOf(String text, AvsRules avs) {
  final t = normalizeName(text);
  bool starts(List<String> heads) => heads.any((h) => _fuzzyStarts(t, h));
  if (t.split(' ').length > 8) return null;
  for (final e in avs.actions.entries) {
    if (starts(e.value)) return _ActionSection(e.key);
  }
  if (starts(avs.allergies)) return const _AllergySection();
  if (starts(avs.endSection)) return const _EndSection();
  return null;
}

/// Exact prefix, or — for headers of 6+ characters — the same number of
/// leading words at ≥ 0.8 similarity, so OCR noise ("CHANG how you take")
/// cannot silently move items into the wrong section.
bool _fuzzyStarts(String line, String header) {
  if (line.startsWith(header)) return true;
  if (header.length < 6) return false;
  final words = header.split(' ').length;
  final lineWords = line.split(' ');
  if (lineWords.length < words) return false;
  final prefix = lineWords.take(words).join(' ');
  return nameSimilarity(prefix, header) >= 0.8;
}

Set<String> _allergyTerms(String text, AvsRules avs) {
  final out = <String>{};
  for (final raw in text.toLowerCase().split(RegExp('[,;/]| and '))) {
    final term = raw.replaceAll(RegExp(r'\(.*?\)'), '').trim();
    if (term.isEmpty || RegExp('^(none|nkda|no known)').hasMatch(term)) {
      continue;
    }
    out.add(term);
    final group = avs.allergySynonyms[term];
    if (group != null) out.add(group);
  }
  return out;
}

class _AvsBuilder {
  _AvsBuilder(this.lx, this.sigRules, this.config);

  final Lexicon lx;
  final SigRules sigRules;
  final RuleConfig config;
  final List<PlanItem> items = [];
  final List<OcrLine> unrecognized = [];
  final Set<String> allergies = {};
  _Pending? _cur;

  bool looksLikeDrug(String text) => _bestDrug(text) != null;

  LexMatch? _bestDrug(String text) {
    final hits = lx.findInLine(text, limit: 1);
    if (hits.isEmpty || hits.first.score < drugLineMinScore) return null;
    final hasDetail =
        Strength.tryParse(text) != null ||
        DoseForm.parse(text).base != FormBase.unknown;
    return hasDetail ? hits.first : null;
  }

  void medLine(OcrLine line, String text, PlanAction action) {
    final brand = _brand.firstMatch(text);
    final cur = _cur;
    if (brand != null && cur != null) {
      cur.srcLines.add(text);
      return;
    }
    if (cur != null && action == PlanAction.hold && _until.hasMatch(text)) {
      cur
        ..holdNote = text.toLowerCase().replaceFirst(RegExp(r'^hold\s+'), '')
        ..srcLines.add(text);
      return;
    }
    final verb = _verbStart.firstMatch(text);
    final drugPart = verb == null ? text : text.substring(0, verb.start);
    final drug = drugPart.trim().isEmpty ? null : _bestDrug(drugPart);
    if (drug != null) {
      flush();
      _cur = _Pending(
        action,
        drugPart.trim().replaceAll(RegExp(r'[,;]$'), ''),
        drug,
      )..srcLines.add(text);
      if (verb != null) _cur!.sigRaw = text.substring(verb.start).trim();
      return;
    }
    if (cur != null && cur.sigRaw == null && verb != null && verb.start == 0) {
      cur
        ..sigRaw = text
        ..srcLines.add(text);
      return;
    }
    unrecognized.add(line);
  }

  void flush() {
    final p = _cur;
    _cur = null;
    if (p == null) return;
    final strength = Strength.tryParse(p.drugText);
    final sig = p.sigRaw == null ? null : parseSig(p.sigRaw!, sigRules);
    final nameScore = p.drug.score;
    final conf = readConfidence(
      nameScore: nameScore,
      strengthScore: sig != null && sig.conf < nameScore ? sig.conf : 1,
      zeroRisk: strength?.zeroRisk ?? false,
      missingStrength: strength == null,
      config: config,
    );
    items.add(
      PlanItem(
        id: 'item-${items.length + 1}',
        action: p.action,
        name: p.drugText,
        rxcui: p.drug.entry.rxcui,
        ings: p.drug.entry.ings,
        strength: strength,
        form: DoseForm.parse(p.drugText),
        route: sig?.route,
        sigRaw: p.sigRaw ?? '',
        sig: sig,
        holdUntil: _holdDate(p.holdNote),
        holdNote: p.holdNote,
        src: p.srcLines.join('\n'),
        conf: conf,
        classIds: p.drug.entry.atc4,
      ),
    );
  }
}

DateTime? _holdDate(String? note) {
  final m = note == null ? null : _date.firstMatch(note);
  if (m == null) return null;
  final month = int.parse(m.group(1)!);
  final day = int.parse(m.group(2)!);
  if (month < 1 || month > 12 || day < 1 || day > 31) return null;
  return DateTime.utc(int.parse(m.group(3)!), month, day);
}

class _Pending {
  _Pending(this.action, this.drugText, this.drug);

  final PlanAction action;
  final String drugText;
  final LexMatch drug;
  final List<String> srcLines = [];
  String? sigRaw;
  String? holdNote;
}
