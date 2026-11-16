/// Lower-case, letters/digits/spaces only, single-spaced.
String normalizeName(String s) => s
    .toLowerCase()
    .replaceAll(RegExp('[^a-z0-9 ]'), ' ')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim();

/// Padded character trigrams of [s].
Set<String> trigrams(String s) {
  final p = '  $s ';
  return {for (var i = 0; i + 3 <= p.length; i++) p.substring(i, i + 3)};
}

/// Levenshtein edit distance.
int editDistance(String a, String b) {
  if (a == b) return 0;
  if (a.isEmpty) return b.length;
  if (b.isEmpty) return a.length;
  var prev = List<int>.generate(b.length + 1, (i) => i);
  for (var i = 1; i <= a.length; i++) {
    final cur = List<int>.filled(b.length + 1, 0)..[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      final del = prev[j] + 1;
      final ins = cur[j - 1] + 1;
      final sub = prev[j - 1] + cost;
      cur[j] = del < ins ? (del < sub ? del : sub) : (ins < sub ? ins : sub);
    }
    prev = cur;
  }
  return prev[b.length];
}

/// Similarity in 0..1 between normalized names: edit similarity blended with
/// trigram Dice. Exact match scores 1.
double nameSimilarity(String a, String b) {
  if (a == b) return 1;
  final longest = a.length > b.length ? a.length : b.length;
  final edit = 1 - editDistance(a, b) / longest;
  final ta = trigrams(a);
  final tb = trigrams(b);
  final dice = 2 * ta.intersection(tb).length / (ta.length + tb.length);
  final s = 0.6 * edit + 0.4 * dice;
  return (s.clamp(0.0, 1.0) * 1000).round() / 1000;
}

const _ocrDigitToLetter = {'0': 'o', '1': 'l', '5': 's', '8': 'b'};
final _measure = RegExp(r'^\d+(\.\d+)?(mg|mcg|g|ml|meq|units?|iu|%)?$');

/// Undoes common OCR digit-for-letter confusions inside words that are
/// mostly letters ("1osartan" → "losartan"). Numbers and strengths such as
/// `50` or `50mg` are left untouched.
String deconfuseOcr(String normalized) => normalized
    .split(' ')
    .map((w) {
      if (_measure.hasMatch(w)) return w;
      final letters = w.replaceAll(RegExp('[^a-z]'), '').length;
      if (letters < 3 || letters < w.length * 0.6) return w;
      return w.split('').map((c) => _ocrDigitToLetter[c] ?? c).join();
    })
    .join(' ');
