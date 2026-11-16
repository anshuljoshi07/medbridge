/// NDC normalization (A6.2). Every function is total: bad input yields an
/// empty list, never an exception. Outputs are 11 digits, no hyphens
/// (`5-4-2`).
library;

final _nonDigit = RegExp(r'\D');

/// Candidate 11-digit NDCs for [raw] text as printed on a label.
///
/// - Hyphenated `4-4-2`, `5-3-2`, `5-4-1` or `5-4-2` → exactly one.
/// - 10 digits without hyphens → three (one per segment shape); keep those
///   that resolve via RxNorm, and treat more than one hit as Unknown.
/// - 11 digits → that one.
/// - 12 digits → treated as UPC-A ([fromUpcA]).
List<String> ndc11Candidates(String raw) {
  final text = raw.trim();
  final segments = text.split(RegExp(r'\s*-\s*'));
  if (segments.length == 3 && segments.every(_isDigits)) {
    final one = _fromSegments(segments[0], segments[1], segments[2]);
    return one == null ? const [] : [one];
  }
  final digits = text.replaceAll(_nonDigit, '');
  if (digits.length != text.replaceAll(RegExp(r'[\s-]'), '').length) {
    return const [];
  }
  return switch (digits.length) {
    10 => _tenDigitCandidates(digits),
    11 => [digits],
    12 => fromUpcA(digits),
    _ => const [],
  };
}

/// Candidates from a 12-digit UPC-A barcode: `3` + 10-digit NDC + check
/// digit. Returns empty when the prefix or check digit is wrong.
List<String> fromUpcA(String upc) {
  final d = upc.replaceAll(_nonDigit, '');
  if (d.length != 12 || !d.startsWith('3') || !_upcCheckOk(d)) {
    return const [];
  }
  return _tenDigitCandidates(d.substring(1, 11));
}

/// Candidates from a GS1 DataMatrix payload. The GTIN-14 after application
/// identifier `01` embeds the NDC as `003` + 10 digits + check digit.
List<String> fromGs1(String payload) {
  final cleaned = payload.replaceAll(RegExp(r'[()\x1d]'), '');
  final m = RegExp(r'^01(\d{14})').firstMatch(cleaned);
  if (m == null) return const [];
  final gtin = m.group(1)!;
  if (!gtin.startsWith('003') || !_gtinCheckOk(gtin)) return const [];
  return _tenDigitCandidates(gtin.substring(3, 13));
}

/// Formats an 11-digit NDC as `5-4-2` for display.
String formatNdc11(String ndc11) => ndc11.length == 11
    ? '${ndc11.substring(0, 5)}-${ndc11.substring(5, 9)}-${ndc11.substring(9)}'
    : ndc11;

bool _isDigits(String s) => s.isNotEmpty && !s.contains(_nonDigit);

String? _fromSegments(String a, String b, String c) {
  final shape = '${a.length}-${b.length}-${c.length}';
  return switch (shape) {
    '4-4-2' => '0$a$b$c',
    '5-3-2' => '${a}0$b$c',
    '5-4-1' => '$a${b}0$c',
    '5-4-2' => '$a$b$c',
    _ => null,
  };
}

List<String> _tenDigitCandidates(String d) => [
  '0$d',
  '${d.substring(0, 5)}0${d.substring(5)}',
  '${d.substring(0, 9)}0${d.substring(9)}',
];

bool _upcCheckOk(String d) {
  var sum = 0;
  for (var i = 0; i < 11; i++) {
    final n = d.codeUnitAt(i) - 48;
    sum += i.isEven ? n * 3 : n;
  }
  return (10 - sum % 10) % 10 == d.codeUnitAt(11) - 48;
}

bool _gtinCheckOk(String g) {
  var sum = 0;
  for (var i = 0; i < 13; i++) {
    final n = g.codeUnitAt(i) - 48;
    sum += i.isEven ? n * 3 : n;
  }
  return (10 - sum % 10) % 10 == g.codeUnitAt(13) - 48;
}
