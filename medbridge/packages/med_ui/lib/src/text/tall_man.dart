import 'package:med_core/med_core.dart';

/// A run of a name: `text` and whether it is a differing (Tall Man) part.
typedef TallManPart = ({String text, bool emphasized});

/// Splits [name] into parts, capitalizing the letters that differ from its
/// LASA partner in `rules` (A13.4: hydrOXYzine / hydrALAZINE).
///
/// The common prefix and suffix stay lower-case; the middle that differs is
/// upper-case and emphasized. Names with no partner come back unchanged.
List<TallManPart> tallMan(String name, RuleSet rules) {
  final lower = name.toLowerCase();
  for (final p in rules.lasa) {
    final (partner, curated) = p.a == lower
        ? (p.b, p.tallA)
        : p.b == lower
        ? (p.a, p.tallB)
        : (null, null);
    if (curated != null) return _fromCurated(curated);
    if (partner != null) return tallManAgainst(lower, partner);
  }
  return [(text: name, emphasized: false)];
}

/// Splits a curated spelling into lower / UPPER runs.
List<TallManPart> _fromCurated(String s) {
  final parts = <TallManPart>[];
  for (final m in RegExp('[A-Z]+|[^A-Z]+').allMatches(s)) {
    final t = m.group(0)!;
    parts.add((
      text: t,
      emphasized: t == t.toUpperCase() && t != t.toLowerCase(),
    ));
  }
  return parts;
}

/// Tall Man parts of [name] relative to [other] (fallback when no curated
/// spelling exists).
List<TallManPart> tallManAgainst(String name, String other) {
  var start = 0;
  while (start < name.length &&
      start < other.length &&
      name[start] == other[start]) {
    start++;
  }
  var end = 0;
  while (end < name.length - start &&
      end < other.length - start &&
      name[name.length - 1 - end] == other[other.length - 1 - end]) {
    end++;
  }
  final mid = name.substring(start, name.length - end);
  if (mid.isEmpty) return [(text: name, emphasized: false)];
  return [
    if (start > 0) (text: name.substring(0, start), emphasized: false),
    (text: mid.toUpperCase(), emphasized: true),
    if (end > 0) (text: name.substring(name.length - end), emphasized: false),
  ];
}
