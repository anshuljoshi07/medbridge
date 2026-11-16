import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/parsed_sig.dart';
import 'package:med_core/src/domain/rule_set.dart';

/// Renders [s] as plain language in [lang] from templates only (A6.6).
///
/// Never machine translation, never abbreviations, never a computed dose.
/// Returns `null` for an unsupported sig: the caller shows "Ask your
/// pharmacist" instead.
///
/// Example: `Take 1 tab PO BID PC` → "Take 1 tablet by mouth 2 times a day,
/// after meals."
String? renderSig(ParsedSig s, Lang lang, SigTemplates t) {
  if (!s.isSupported) return null;
  String tpl(String key, [Map<String, Object> args = const {}]) {
    var out = t.get(lang, key);
    args.forEach((k, v) => out = out.replaceAll('{$k}', '$v'));
    return out;
  }

  final head = <String>[
    tpl('verb.${_verbKey(s)}'),
    if (s.qty != null) '${s.qty}',
    if (s.unit != null) tpl('unit.${s.unit}.${s.qty == 1 ? 'one' : 'other'}'),
    if (s.eye != null)
      tpl('eye.${s.eye!.name}')
    else if (s.route != null)
      tpl('route.${s.route!.name}'),
  ];
  final freq = _frequency(s, tpl);
  if (freq.isNotEmpty) head.add(freq);
  final tail = <String>[
    if (s.prn) tpl('prn'),
    if (s.prn && s.prnMax != null) tpl('prn.max', {'n': s.prnMax!}),
    if (s.food != null) tpl('food.${_foodKey(s.food!)}'),
    if (s.days != null) tpl('days', {'n': s.days!}),
  ];
  final sentence = [
    head.where((p) => p.isNotEmpty).join(' '),
    ...tail.where((p) => p.isNotEmpty),
  ].join(', ');
  return '$sentence.';
}

String _frequency(
  ParsedSig s,
  String Function(String, [Map<String, Object>]) tpl,
) {
  final singleSlot = s.slots.length == 1 && (s.perDay ?? 1) == 1;
  if (singleSlot && !_isDefaultSingle(s)) {
    return tpl('slot.${s.slots.single.name}');
  }
  if (s.everyH != null) return tpl('every.h', {'h': s.everyH!});
  if (s.perDay == 1) return tpl('freq.1');
  if (s.perDay != null) return tpl('freq.n', {'n': s.perDay!});
  return '';
}

/// "daily" defaults to the morning slot but should read "once a day".
bool _isDefaultSingle(ParsedSig s) =>
    s.perDay == 1 &&
    s.slots.single == DoseSlot.morning &&
    s.everyH == null &&
    !RegExp(r'\b(qam|morning)\b', caseSensitive: false).hasMatch(s.raw);

String _verbKey(ParsedSig s) => switch (s.route) {
  DoseRoute.inhalation => 'inhale',
  DoseRoute.topical || DoseRoute.transdermal => 'apply',
  DoseRoute.ophthalmic => 'put',
  DoseRoute.subcutaneous => 'inject',
  DoseRoute.sublingual => 'place',
  DoseRoute.oral || null => _unitVerb(s.unit),
};

String _unitVerb(String? unit) => switch (unit) {
  'puff' => 'inhale',
  'patch' => 'apply',
  'drop' => 'put',
  _ => 'take',
};

String _foodKey(FoodTiming f) => switch (f) {
  FoodTiming.before => 'before',
  FoodTiming.after => 'after',
  FoodTiming.withFood => 'with',
};
