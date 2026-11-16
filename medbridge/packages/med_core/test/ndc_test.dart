import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

void main() {
  group('ndc11Candidates, hyphenated → exactly one', () {
    test('4-4-2 pads the labeler segment', () {
      expect(ndc11Candidates('0781-1506-10'), ['00781150610']);
    });
    test('5-3-2 pads the product segment', () {
      expect(ndc11Candidates('60505-141-01'), ['60505014101']);
    });
    test('5-4-1 pads the package segment', () {
      expect(ndc11Candidates('68180-0513-1'), ['68180051301']);
    });
    test('5-4-2 is already 11 digits', () {
      expect(ndc11Candidates('68180-0513-01'), ['68180051301']);
    });
    test('tolerates spaces around hyphens', () {
      expect(ndc11Candidates(' 0781 - 1506 - 10 '), ['00781150610']);
    });
    test('rejects an unknown segment shape', () {
      expect(ndc11Candidates('781-1506-10'), isEmpty);
      expect(ndc11Candidates('12345-12345-1'), isEmpty);
    });
  });

  group('ndc11Candidates, ambiguous 10 digits → three', () {
    test('one candidate per segment shape', () {
      expect(ndc11Candidates('0781150610'), [
        '00781150610', // 4-4-2
        '07811050610', // 5-3-2
        '07811506100', // 5-4-1
      ]);
    });
    test('candidates are distinct and all 11 digits', () {
      final c = ndc11Candidates('6050514101');
      expect(c.toSet(), hasLength(3));
      expect(c.every((n) => n.length == 11), isTrue);
    });
  });

  group('ndc11Candidates, other inputs', () {
    test('11 digits passes through', () {
      expect(ndc11Candidates('00781150610'), ['00781150610']);
    });
    test('letters or wrong lengths yield nothing (never throws)', () {
      expect(ndc11Candidates(''), isEmpty);
      expect(ndc11Candidates('RX1234567'), isEmpty);
      expect(ndc11Candidates('123'), isEmpty);
      expect(ndc11Candidates('0781-15O6-10'), isEmpty);
    });
  });

  group('fromUpcA', () {
    // UPC-A = 3 + 10-digit NDC 0781150610 + check digit.
    const upc = '307811506104';
    test('strips the leading 3 and the check digit', () {
      expect(fromUpcA(upc), ndc11Candidates('0781150610'));
    });
    test('routes 12-digit input through ndc11Candidates', () {
      expect(ndc11Candidates(upc), fromUpcA(upc));
    });
    test('rejects a bad check digit', () {
      expect(fromUpcA('307811506100'), isEmpty);
    });
    test('rejects a non-3 prefix (not a drug UPC)', () {
      expect(fromUpcA('007811506103'), isEmpty);
    });
  });

  group('fromGs1', () {
    // GTIN-14 = 003 + 0781150610 + check digit 4.
    test('extracts the embedded NDC', () {
      expect(fromGs1('0100307811506104'), ndc11Candidates('0781150610'));
    });
    test('accepts parenthesized AIs and trailing data', () {
      expect(
        fromGs1('(01)00307811506104(17)271231(10)ABC'),
        ndc11Candidates('0781150610'),
      );
    });
    test('rejects a non-NDC GTIN and a bad check digit', () {
      expect(fromGs1('0100012345678905'), isEmpty);
      expect(fromGs1('0100307811506100'), isEmpty);
      expect(fromGs1('garbage'), isEmpty);
    });
  });

  test('formatNdc11 shows 5-4-2', () {
    expect(formatNdc11('00781150610'), '00781-1506-10');
  });
}
