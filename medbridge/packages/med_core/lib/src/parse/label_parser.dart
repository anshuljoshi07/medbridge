import 'package:med_core/src/domain/dose_form.dart';
import 'package:med_core/src/domain/plan.dart';
import 'package:med_core/src/domain/rule_set.dart';
import 'package:med_core/src/domain/strength.dart';
import 'package:med_core/src/parse/confidence.dart';
import 'package:med_core/src/parse/lexicon.dart';
import 'package:med_core/src/parse/ocr_types.dart';
import 'package:med_core/src/parse/scan_draft.dart';
import 'package:med_core/src/parse/text_similarity.dart';
import 'package:med_core/src/parse/vote.dart';
import 'package:med_core/src/sig/sig_parser.dart';

final _verbStart = RegExp(
  r'^(take|inhale|apply|instill|inject|place|use|put|chew|dissolve)\b',
);
final _qty = RegExp(r'\b(?:qty|quantity|#)\s*:?\s*(\d+)');
final _refills = RegExp(r'\brefills?\s*:?\s*(\d+|none|no)');
final _fillDate = RegExp(r'\b(?:filled|fill date|date)\s*:?\s*([\d/.-]{6,10})');
final _prescriber = RegExp(
  r'\b(?:dr|prescriber|presc)\.?\s*:?\s+([a-z .,-]+)$',
);
final _anchor = RegExp(
  r'\b(qty|quantity|refill|filled|date|dr|prescriber|rx|pharmacy|ndc)\b',
);

/// Closed-set candidates beat open-lexicon ones by this much (A7.2 step 4).
const double closedSetBoost = 0.05;

/// Parses multi-frame bottle OCR into a [ScanDraft] (A7.2).
///
/// Never stores images; works on recognized text only. Total.
ScanDraft parseLabel(
  List<OcrFrame> frames,
  Lexicon lx,
  Plan? ctx,
  RuleSet rules,
  SigRules sigRules,
) {
  final vote = voteFrames(frames);
  final lines = vote.lines;
  final candidates = _rankCandidates(lines, lx, ctx);
  if (candidates.isEmpty) {
    return ScanDraft.empty(frames: vote.frames, lines: lines);
  }
  final top = candidates.first;
  final second = _secondDistinct(candidates, top, rules);
  final needsChoice =
      second != null &&
      (rules.isLasaPair(top.entry.name, second.entry.name) ||
          top.score - second.score < rules.config.lasaDelta);
  final drugLine = lines.firstWhere(
    (l) => lx.findInLine(l, limit: 1).isNotEmpty,
    orElse: () => lines.first,
  );
  final strength =
      Strength.tryParse(drugLine) ?? _firstStrength(lines.join(' \n '));
  final sigRaw = _sigText(lines);
  final sig = sigRaw.isEmpty ? null : parseSig(sigRaw, sigRules);
  final all = lines.join('\n');
  return ScanDraft(
    name: top.entry.name,
    rxcui: top.entry.tty == 'PLAN' ? null : top.entry.rxcui,
    ings: top.entry.ings,
    classIds: top.entry.atc4,
    strength: strength,
    form: DoseForm.parse('$drugLine $all'),
    sigRaw: sigRaw,
    sig: sig,
    conf: readConfidence(
      nameScore: top.score.clamp(0, 1).toDouble(),
      zeroRisk: strength?.zeroRisk ?? false,
      missingStrength: strength == null,
      singleFrame: vote.frames < 2,
      config: rules.config,
    ),
    needsChoice: needsChoice,
    candidates: [top, ?second],
    qty: _int(_qty.firstMatch(all)),
    refills: _int(_refills.firstMatch(all)),
    fillDate: _fillDate.firstMatch(all)?.group(1),
    prescriber: _prescriber.firstMatch(all)?.group(1)?.trim(),
    frames: vote.frames,
    lines: lines,
  );
}

/// Plan meds first (closed set), then the open lexicon; one hit per name.
List<LexMatch> _rankCandidates(List<String> lines, Lexicon lx, Plan? ctx) {
  final byName = <String, LexMatch>{};
  void offer(LexMatch m) {
    final prev = byName[m.entry.name];
    if (prev == null || prev.score < m.score) byName[m.entry.name] = m;
  }

  final closed = ctx == null ? null : Lexicon(_planEntries(ctx, lx));
  for (final line in lines) {
    lx.findInLine(line).forEach(offer);
    if (closed == null) continue;
    for (final m in closed.findInLine(line)) {
      offer((entry: m.entry, score: m.score + closedSetBoost));
    }
  }
  final out = byName.values.toList()
    ..sort((a, b) {
      final c = b.score.compareTo(a.score);
      return c != 0 ? c : a.entry.name.compareTo(b.entry.name);
    });
  return out;
}

/// Plan items as lexicon entries, keyed by ingredient so a label that
/// prints the ingredient name matches the plan line.
List<LexEntry> _planEntries(Plan p, Lexicon lx) => [
  for (final item in p.items)
    for (final ing in item.ings)
      LexEntry(
        rxcui: item.rxcui ?? '',
        tty: 'PLAN',
        name: ing,
        ings: item.ings,
        atc4: item.classIds,
      ),
];

/// The runner-up with different ingredients. If the top name is half of a
/// LASA pair, its partner is forced in as the runner-up.
LexMatch? _secondDistinct(List<LexMatch> c, LexMatch top, RuleSet rules) {
  for (final p in rules.lasa) {
    final partner = p.a == top.entry.name
        ? p.b
        : p.b == top.entry.name
        ? p.a
        : null;
    if (partner == null) continue;
    for (final m in c) {
      if (m.entry.name == partner) return m;
    }
    final score = nameSimilarity(top.entry.name, partner);
    return (
      entry: LexEntry(rxcui: '', tty: 'LASA', name: partner, ings: {partner}),
      score: score,
    );
  }
  for (final m in c.skip(1)) {
    if (!m.entry.ings.containsAll(top.entry.ings)) return m;
  }
  return null;
}

Strength? _firstStrength(String text) => Strength.tryParse(text);

String _sigText(List<String> lines) {
  for (var i = 0; i < lines.length; i++) {
    if (!_verbStart.hasMatch(lines[i])) continue;
    final next = i + 1 < lines.length ? lines[i + 1] : '';
    final joinNext =
        next.isNotEmpty &&
        !_anchor.hasMatch(next) &&
        !_verbStart.hasMatch(next) &&
        Strength.tryParse(next) == null;
    return joinNext ? '${lines[i]} $next' : lines[i];
  }
  return '';
}

int? _int(Match? m) {
  final s = m?.group(1);
  if (s == null) return null;
  return s == 'none' || s == 'no' ? 0 : int.tryParse(s);
}
