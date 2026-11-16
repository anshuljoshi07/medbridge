import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/rules.dart';

String? render(String raw, [Lang lang = Lang.en]) =>
    renderSig(parseSig(raw, testSigRules), lang, testTemplates);

void main() {
  group('English (A6.6)', () {
    test('spec example', () {
      expect(
        render('Take 1 tab PO BID PC'),
        'Take 1 tablet by mouth 2 times a day, after meals.',
      );
    });
    test('daily reads "once a day"', () {
      expect(render('1 tab PO daily'), 'Take 1 tablet by mouth once a day.');
    });
    test('explicit slot wins', () {
      expect(render('1 tab PO QHS'), 'Take 1 tablet by mouth at bedtime.');
      expect(render('1 tab PO QAM'), 'Take 1 tablet by mouth every morning.');
    });
    test('PRN with max', () {
      expect(
        render('Take 1 tab PO q6h PRN max 4/day'),
        'Take 1 tablet by mouth every 6 hours, only if needed, '
        'no more than 4 a day.',
      );
    });
    test('plural units and eyes', () {
      expect(
        render('Instill 2 gtts OU BID'),
        'Put 2 drops in both eyes 2 times a day.',
      );
    });
    test('never shows an abbreviation', () {
      final out = render('Take 1 tab PO QD AC')!;
      for (final abbrev in ['PO', 'QD', 'AC', 'tab ']) {
        expect(out.contains(abbrev), isFalse, reason: abbrev);
      }
    });
  });

  group('Spanish (draft)', () {
    test('spec example', () {
      expect(
        render('Take 1 tab PO BID PC', Lang.es),
        'Tome 1 tableta por la boca 2 veces al día, después de las comidas.',
      );
    });
    test('flagged pending translator review', () {
      expect(testTemplates.isPendingReview(Lang.es), isTrue);
      expect(testTemplates.isPendingReview(Lang.en), isFalse);
    });
  });

  test('unsupported sig renders null ("Ask your pharmacist")', () {
    expect(render('Take 1 tab weekly'), isNull);
    expect(render('Take 2 tabs daily then 1 tab daily'), isNull);
  });
}
