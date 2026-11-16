import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/rules.dart';

OcrFrame frame(List<String> lines) =>
    OcrFrame([for (final l in lines) OcrLine(l)]);

void main() {
  group('voteFrames', () {
    test('noise in one frame is outvoted', () {
      final v = voteFrames([
        frame(['LISINOPRIL 10 MG']),
        frame(['LISINOPRlL 10 MG']),
        frame(['LISINOPRIL 10 MG']),
      ]);
      expect(v.lines, ['lisinopril 10 mg']);
      expect(v.frames, 3);
    });

    test('position-independent: line order across frames does not matter', () {
      final v = voteFrames([
        frame(['TAKE 1 TABLET', 'ATORVASTATIN 40 MG']),
        frame(['ATORVASTATIN 40 MG', 'TAKE 1 TABLET']),
        frame(['ATORVASTATIN 40 MG']),
      ]);
      expect(v.lines, containsAll(['atorvastatin 40 mg', 'take 1 tablet']));
    });

    test('a token seen in only one of 4 frames is dropped', () {
      final v = voteFrames([
        frame(['METFORMIN 500 MG GLARE']),
        frame(['METFORMIN 500 MG']),
        frame(['METFORMIN 500 MG']),
        frame(['METFORMIN 500 MG']),
      ]);
      expect(v.lines, ['metformin 500 mg']);
    });

    test('numbers are never merged by edit distance (10 vs 100)', () {
      final v = voteFrames([
        frame(['10 MG']),
        frame(['100 MG']),
        frame(['10 MG']),
      ]);
      expect(v.lines.first, '10 mg');
      expect(v.lines.any((l) => l.contains('100')), isFalse);
    });

    test('single frame keeps everything; empty input is empty', () {
      expect(
        voteFrames([
          frame(['A B']),
        ]).lines,
        ['a b'],
      );
      expect(voteFrames(const []).lines, isEmpty);
    });

    test('deterministic', () {
      final fs = [
        frame(['ABCDEF']),
        frame(['ABCDEG']),
      ];
      expect(voteFrames(fs).lines, voteFrames(fs).lines);
    });
  });

  group('confidence (A7.3)', () {
    final c = testRules.config;
    test('min of scores minus penalties', () {
      expect(
        readConfidence(nameScore: 0.95, strengthScore: 0.9, config: c),
        0.9,
      );
      expect(readConfidence(nameScore: 1, zeroRisk: true, config: c), 0.8);
      expect(
        readConfidence(nameScore: 1, missingStrength: true, config: c),
        0.7,
      );
      expect(readConfidence(nameScore: 1, singleFrame: true, config: c), 0.9);
    });
    test('bands', () {
      expect(confBand(0.95, c), ConfBand.prefill);
      expect(confBand(0.8, c), ConfBand.highlight);
      expect(confBand(0.69, c), ConfBand.unknown);
    });
  });
}
