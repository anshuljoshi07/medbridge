import 'dart:convert';
import 'dart:io';

import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/rules.dart';

/// Minimal CSV reader for the two-column fixture (quoted JSON column).
List<(String, Map<String, Object?>)> _readFixture() {
  final lines = File('test/fixtures/sigs.csv').readAsLinesSync().skip(1);
  return [
    for (final line in lines)
      if (line.isNotEmpty) _row(line),
  ];
}

(String, Map<String, Object?>) _row(String line) {
  final comma = line.indexOf(',"');
  final raw = line.substring(0, comma);
  final json = line.substring(comma + 2, line.length - 1).replaceAll('""', '"');
  return (raw, (jsonDecode(json) as Map).cast<String, Object?>());
}

void main() {
  final rows = _readFixture();

  test('fixture has at least 300 rows', () {
    expect(rows.length, greaterThanOrEqualTo(300));
  });

  group('sigs.csv', () {
    for (final (raw, expected) in rows) {
      test(raw, () {
        final parsed = parseSig(raw, testSigRules);
        final actual = parsed.toJson();
        for (final key in expected.keys) {
          expect(actual[key], expected[key], reason: 'field "$key"');
        }
        if ((expected['flags']! as List).isEmpty) {
          expect(parsed.isSupported, isTrue);
          expect(parsed.conf, greaterThanOrEqualTo(0.9));
        } else {
          expect(parsed.flags, isNotEmpty);
        }
      });
    }
  });

  group('B2 required flags', () {
    SigFlag? first(String s) => parseSig(s, testSigRules).firstUnsupported;
    test('QOD → NON_DAILY', () {
      expect(first('Take 1 tab PO QOD'), SigFlag.nonDaily);
    });
    test('weekly → NON_DAILY', () {
      expect(first('Take 70 mg weekly'), SigFlag.nonDaily);
    });
    test('1/2 → HALF_TAB', () {
      expect(first('Take 1/2 tab daily'), SigFlag.halfTab);
    });
    test('1-2 → RANGE_DOSE', () {
      expect(first('Take 1-2 tabs PRN'), SigFlag.rangeDose);
    });
  });

  group('robustness', () {
    test('never throws on junk and scores it low', () {
      for (final s in ['', '   ', '!!!', 'lorem ipsum dolor', '9' * 50]) {
        final p = parseSig(s, testSigRules);
        expect(p.conf, lessThan(0.7), reason: s);
      }
    });
    test('missing frequency lowers confidence below the floor', () {
      expect(parseSig('Take 1 tab PO', testSigRules).conf, lessThan(0.7));
    });
    test('ZERO_RISK is supported but drops out of the pre-fill band', () {
      final p = parseSig('Take 1.0 tab PO daily', testSigRules);
      expect(p.isSupported, isTrue);
      expect(p.flags, contains(SigFlag.zeroRisk));
      expect(p.conf, lessThan(0.9));
    });
    test('deterministic: same input → equal output', () {
      const s = 'Take 1 tab PO BID PC';
      expect(parseSig(s, testSigRules), parseSig(s, testSigRules));
    });
    test('never outputs a computed dose (qty is copied as written)', () {
      final p = parseSig('Take 2 tabs PO TID', testSigRules);
      expect(p.qty, 2);
      expect(p.toJson().keys, isNot(contains('dailyTotal')));
    });
  });
}
