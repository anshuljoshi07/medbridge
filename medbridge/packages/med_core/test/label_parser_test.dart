import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/fixtures.dart';
import 'support/rules.dart';

List<OcrFrame> framesOf(Map<String, Object?> fx) => [
  for (final f in (fx['frames']! as List).cast<List<Object?>>())
    OcrFrame([for (final l in f) OcrLine(l! as String)]),
];

ScanDraft parse(List<OcrFrame> frames, {Plan? ctx}) =>
    parseLabel(frames, testLexicon, ctx, testRules, testSigRules);

void main() {
  for (final name in fixtureNames('labels')) {
    test('fixture $name resolves in closed-set mode', () {
      final fx = readFixture('labels/$name');
      final want = (fx['expected']! as Map).cast<String, Object?>();
      final d = parse(framesOf(fx), ctx: rDoePlan);
      expect(d.ings, contains(want['ing']), reason: d.lines.join(' | '));
      expect(d.strength?.display, want['strength']);
      expect(d.needsChoice, want['needsChoice']);
      if (want['release'] != null) {
        expect(d.form.release.name, want['release']);
      }
      if (name.endsWith('_single.json')) {
        expect(d.frames, 1);
      }
    });
  }

  test('multi-frame read scores higher than single-frame', () {
    final multi = parse(framesOf(readFixture('labels/atorvastatin_40.json')));
    final single = parse(
      framesOf(readFixture('labels/atorvastatin_40_single.json')),
    );
    expect(multi.conf, greaterThan(single.conf));
  });

  test('LASA pair forces a choice with both names', () {
    final d = parse(
      framesOf(readFixture('labels/hydroxyzine_25.json')),
      ctx: rDoePlan,
    );
    expect(d.needsChoice, isTrue);
    expect(d.candidates.map((c) => c.entry.name), [
      'hydroxyzine',
      'hydralazine',
    ]);
  });

  test('anchor fields are extracted', () {
    final d = parse(framesOf(readFixture('labels/lisinopril_10.json')));
    expect(d.qty, 30);
    expect(d.refills, 2);
    expect(d.fillDate, '11/01/2026');
    expect(d.sigRaw, startsWith('take 1 tablet'));
    expect(d.sig?.perDay, 1);
  });

  test('nothing readable → empty draft with zero confidence (Unknown)', () {
    final d = parse([
      const OcrFrame([OcrLine('|||'), OcrLine('~~')]),
    ]);
    expect(d.conf, 0);
    expect(
      d.toScan(confirmed: true).conf,
      lessThan(testRules.config.confFloor),
    );
  });

  test('draft → scan → reconcile end to end (B10 benazepril)', () {
    final d = parse(
      framesOf(readFixture('labels/benazepril_20.json')),
      ctx: rDoePlan,
    );
    final r = reconcileWithSafety(
      rDoePlan,
      d.toScan(confirmed: true),
      testRules,
    );
    expect(r.reason, 'SAME_CLASS_AS:losartan');
  });
}
