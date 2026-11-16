import 'package:med_core/src/domain/enums.dart';

RegExp _re(String p) => RegExp(p, caseSensitive: false);

const _weekdays =
    'monday|tuesday|wednesday|thursday|friday|saturday|sunday|'
    'mon|tue|tues|wed|thu|thur|thurs|fri|sat|sun';

final Map<SigFlag, List<RegExp>> _detectors = {
  SigFlag.taper: [
    _re(r'\bthen\b'),
    _re(r'\bdecrease'),
    _re(r'\bincrease'),
    _re(r'\btaper'),
    _re(r'\breduce\b'),
  ],
  SigFlag.nonDaily: [
    _re(r'\bweekly\b'),
    _re(r'\b(once|twice|\d+ times?) (a|per|each) week\b'),
    _re(r'\bevery (week|other day|\d+ days|\d+(st|nd|rd|th)? day)\b'),
    _re(r'\bq\s?od\b'),
    _re(r'\bq\s?wk\b|\bq\s?week\b|\bq\s?\d+\s?d(ays)?\b'),
    _re(r'\bx\s?\d+\s?/\s?w(ee)?k\b'),
    _re('\\b($_weekdays)s?\\b'),
    _re(r'\b(monthly|every month|once a month)\b'),
  ],
  SigFlag.slidingScale: [
    _re('sliding scale'),
    _re(r'\bper scale\b'),
    _re('units based on'),
    _re(r'\bper (blood )?sugar\b'),
  ],
  SigFlag.halfTab: [
    _re(r'(^|[^\d])1\s?/\s?2([^\d]|$)'),
    _re('½'),
    _re(r'\bhalf\b'),
    _re(r'(^|[^\d])0?\.5\s?(tab|cap)'),
  ],
  SigFlag.liquidVolume: [
    _re(r'(^|[^/\d.])\d+(\.\d+)?\s?(ml|cc)\b'),
    _re(r'\b(tsp|tbsp|teaspoons?|tablespoons?|teaspoonfuls?)\b'),
  ],
  SigFlag.rangeDose: [
    _re(r'\b\d+\s?(-|–|—|to|or)\s?\d+\b'),
  ],
  SigFlag.zeroRisk: [
    _re(r'\b\d+\.\d*0\b'),
    _re(r'(^|[^\d])\.\d+'),
  ],
};

/// Detects A6.5 unsupported features and A6.5 error-prone notation in a sig.
///
/// Detection, never interpretation: a flagged sig is routed to "Ask your
/// pharmacist", not guessed. Total: never throws.
Set<SigFlag> detectSigFlags(String raw) {
  final text = raw.toLowerCase();
  return {
    for (final e in _detectors.entries)
      if (e.value.any((r) => r.hasMatch(text))) e.key,
  };
}
