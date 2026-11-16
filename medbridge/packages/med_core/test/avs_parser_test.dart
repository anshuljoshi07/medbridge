import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/fixtures.dart';
import 'support/rules.dart';

PlanDraft parse(List<String> lines) => parseAvs(
  [for (final l in lines) OcrLine(l)],
  testLexicon,
  testAvsRules,
  testSigRules,
  testRules.config,
);

void main() {
  for (final name in fixtureNames('avs')) {
    group('fixture $name', () {
      final fx = readFixture('avs/$name');
      final lines = (fx['lines']! as List).cast<String>();
      final expected = (fx['expected']! as Map).cast<String, Object?>();
      final draft = parse(lines);
      final want = (expected['items']! as List).cast<Map<String, Object?>>();

      test('item count', () {
        expect(draft.items, hasLength(want.length), reason: '${draft.items}');
      });
      for (var i = 0; i < want.length; i++) {
        final w = want[i];
        test('item ${i + 1}: ${w['action']} ${w['ing']}', () {
          final got = draft.items[i];
          expect(got.action.name, w['action']);
          expect(got.ings, contains(w['ing']));
          expect(got.strength?.display, w['strength']);
          expect(got.sigRaw.toLowerCase(), (w['sig']! as String).toLowerCase());
          expect(got.src, isNotEmpty);
          // The source quote stays verbatim, OCR noise included.
          expect(got.src.toLowerCase(), contains(w['strength']));
          final flags = (w['flags'] as List?)?.cast<String>() ?? const [];
          for (final f in flags) {
            expect(got.sig?.firstUnsupported?.code, f);
          }
        });
      }
      test('allergies', () {
        expect(draft.allergies, (expected['allergies']! as List).toSet());
      });
      test('unrecognized lines are kept, never dropped', () {
        expect(draft.unrecognized, hasLength(expected['unrecognized']));
      });
    });
  }

  test('hold note and date are captured', () {
    final d = parse([
      'HOLD these medications',
      'metformin 500 mg tablet',
      'Take 1 tab PO BID',
      'Hold until 12/01/2026',
    ]);
    expect(d.items.single.holdNote, 'until 12/01/2026');
    expect(d.items.single.holdUntil, DateTime.utc(2026, 12));
  });

  test('a drug line outside any section is surfaced, not dropped', () {
    final d = parse([
      'warfarin 5 mg tablet',
      'START taking',
      'losartan 50 mg tab',
    ]);
    expect(d.unrecognized.single.text, 'warfarin 5 mg tablet');
    expect(d.items.single.action, PlanAction.start);
  });

  test('missing strength drops out of the pre-fill band (must confirm)', () {
    final d = parse([
      'CONTINUE taking',
      'atorvastatin tablet',
      'Take 1 tab PO QHS',
    ]);
    expect(d.items.single.conf, lessThan(testRules.config.confHigh));
  });

  test('never throws on junk', () {
    expect(parse(['', '???', 'START taking', '%%%%']).items, isEmpty);
  });
}
