import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/parsed_sig.dart';
import 'package:med_core/src/domain/rule_set.dart';
import 'package:med_core/src/sig/sig_flags.dart';
import 'package:med_core/src/sig/sig_slots.dart';

const _verbs = {
  'take', 'inhale', 'apply', 'instill', 'inject', 'place', 'use', 'put', //
  'give', 'chew', 'dissolve', 'insert', 'spray',
};
const _stopwords = {'a', 'an', 'the', 'and', 'of', 'to', 'by', 'in', 'at'};
const _wordNumbers = {
  'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, //
};

final _timesPerDay = RegExp(
  r'\b(\d+|one|two|three|four|five|six)\s?(?:times|x)\s?(?:a|per|each)?\s?(?:day|daily)\b',
);
final _everyHours = RegExp(r'\b(?:every|q)\s?(\d+)\s?(?:hours?|hrs?|h)\b');
final _prnMax = RegExp(
  r'\b(?:max(?:imum)?|no more than|not to exceed|do not exceed)\s?(?:of\s)?(\d+)\s?(?:\w+\s)?(?:/|per|a|in)\s?(?:day|24\s?h(?:ours|rs)?)\b',
);
final _days = RegExp(r'\b(?:for|x)\s?(\d+)\s?(?:days?|d)\b');

/// Parses a sig written in standard notation (A6.4) into a [ParsedSig].
///
/// Total and deterministic: never throws, and returns detected unsupported
/// features in `flags` with a lowered `conf` instead of guessing.
ParsedSig parseSig(String raw, SigRules rules) {
  final b = _SigBuilder(raw, detectSigFlags(raw));
  var text = raw
      .toLowerCase()
      .replaceAll('(s)', '')
      .replaceAll(RegExp('[–—]'), '-');
  text = b.extract(text, _prnMax, (m) => b.prnMax = _num(m.group(1)!));
  text = b.extract(text, _timesPerDay, (m) => b.setPerDay(_num(m.group(1)!)));
  text = b.extract(text, _everyHours, (m) => b.setEveryH(_num(m.group(1)!)));
  text = b.extract(text, _days, (m) => b.days = _num(m.group(1)!));
  final tokens = text
      .replaceAll(RegExp(r'[,;:()\[\].]'), ' ')
      .split(RegExp(r'\s+'))
      .where((t) => t.isNotEmpty)
      .toList();
  _consumeTokens(tokens, rules, b);
  return b.build();
}

void _consumeTokens(List<String> tokens, SigRules rules, _SigBuilder b) {
  final maxWords = rules.maxPhraseWords;
  var i = 0;
  while (i < tokens.length) {
    var matched = 0;
    for (var n = maxWords; n >= 1 && matched == 0; n--) {
      if (i + n > tokens.length) continue;
      final phrase = tokens.sublist(i, i + n).join(' ');
      final tok = rules.tokens[phrase];
      if (tok != null) {
        b.apply(tok);
        matched = n;
      }
    }
    if (matched == 0) {
      b.word(tokens[i]);
      matched = 1;
    }
    i += matched;
  }
}

int _num(String s) => _wordNumbers[s] ?? int.tryParse(s) ?? 0;

class _SigBuilder {
  _SigBuilder(this.raw, this.flags);

  final String raw;
  final Set<SigFlag> flags;
  int? qty;
  String? unit;
  DoseRoute? route;
  EyeSide? eye;
  int? perDay;
  int? everyH;
  final List<DoseSlot> explicitSlots = [];
  bool prn = false;
  int? prnMax;
  FoodTiming? food;
  int? days;
  int unknownWords = 0;
  int conflicts = 0;

  String extract(String text, RegExp re, void Function(Match) onMatch) {
    final m = re.firstMatch(text);
    if (m == null) return text;
    onMatch(m);
    return text.replaceRange(m.start, m.end, ' ');
  }

  void setPerDay(int n) {
    if (perDay != null && perDay != n) conflicts++;
    perDay = n;
  }

  void setEveryH(int h) {
    if (everyH != null && everyH != h) conflicts++;
    everyH = h;
  }

  void apply(SigToken t) {
    final v = t.value;
    switch (t.field) {
      case 'route':
        route = _byName(DoseRoute.values, v);
      case 'eye':
        eye = _byName(EyeSide.values, v);
        route = DoseRoute.ophthalmic;
      case 'perDay':
        if (v is int) setPerDay(v);
      case 'everyH':
        if (v is int) setEveryH(v);
      case 'slot':
        final s = _byName(DoseSlot.values, v);
        if (s != null && !explicitSlots.contains(s)) explicitSlots.add(s);
      case 'prn':
        prn = v == true;
      case 'food':
        food = v == 'with'
            ? FoodTiming.withFood
            : _byName(FoodTiming.values, v);
      case 'unit':
        unit = v.toString();
      default:
        unknownWords++;
    }
  }

  void word(String w) {
    final n = _wordNumbers[w] ?? int.tryParse(w);
    if (n != null && qty == null) {
      qty = n;
    } else if (!_verbs.contains(w) && !_stopwords.contains(w)) {
      unknownWords++;
    }
  }

  ParsedSig build() {
    final plan = planSlots(
      perDay: perDay,
      everyH: everyH,
      explicit: explicitSlots,
      prn: prn,
    );
    var conf = 1.0 - (unknownWords * 0.1).clamp(0, 0.5);
    if (qty == null && route != DoseRoute.topical) conf -= 0.2;
    final hasFreq =
        perDay != null || everyH != null || explicitSlots.isNotEmpty || prn;
    if (!hasFreq) conf -= 0.4;
    if (flags.contains(SigFlag.zeroRisk)) conf -= 0.2;
    if (conflicts > 0 || plan.ambiguous) conf -= 0.3;
    return ParsedSig(
      raw: raw,
      qty: qty,
      unit: unit,
      route: route,
      eye: eye,
      perDay: plan.perDay,
      everyH: everyH,
      slots: plan.slots,
      prn: prn,
      prnMax: prnMax,
      food: food,
      days: days,
      flags: flags,
      conf: (conf.clamp(0.0, 1.0) * 100).round() / 100,
    );
  }
}

T? _byName<T extends Enum>(List<T> values, Object v) {
  for (final e in values) {
    if (e.name == v) return e;
  }
  return null;
}
