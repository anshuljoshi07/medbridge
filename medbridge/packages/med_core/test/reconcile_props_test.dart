import 'dart:math';

import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/builders.dart';
import 'support/rules.dart';

/// A8.4 invariants over seeded, generated (plan, scan) pairs.
void main() {
  final drugs = atc.keys.toList();
  const strengths = ['5 mg', '10 mg', '20 mg', '25 mg', '50 mg', '100 mcg'];
  const forms = ['tab', 'ER tab', 'cap', ''];
  const sigs = [
    '1 tab PO daily',
    '1 tab PO BID',
    '1 tab PO q6h PRN',
    'Take 1 tab weekly',
  ];

  String pick(Random r, List<String> xs) => xs[r.nextInt(xs.length)];

  (Plan, Scan) generate(int seed) {
    final rnd = Random(seed);
    final items = [
      for (var i = 0; i < 1 + rnd.nextInt(6); i++)
        () {
          final d = pick(rnd, drugs);
          return item(
            '$d-$i',
            PlanAction.values[rnd.nextInt(PlanAction.values.length)],
            '$d ${pick(rnd, strengths)} ${pick(rnd, forms)}',
            ings: {d},
            sig: pick(rnd, sigs),
          );
        }(),
    ];
    // A third of scans copy a plan line exactly, so matches are exercised.
    final copy = rnd.nextInt(3) == 0 ? items[rnd.nextInt(items.length)] : null;
    final ings =
        copy?.ings ??
        {pick(rnd, drugs), if (rnd.nextInt(5) == 0) pick(rnd, drugs)};
    final s = scan(
      copy?.name ??
          '${ings.join('-')} ${pick(rnd, strengths)} ${pick(rnd, forms)}',
      ings: ings,
      conf: rnd.nextDouble(),
      confirmed: rnd.nextInt(6) != 0,
    );
    final allergies = rnd.nextInt(4) == 0 ? {pick(rnd, drugs)} : <String>{};
    return (plan(items, allergies: allergies), s);
  }

  const cases = 3000;
  final inputs = [for (var i = 0; i < cases; i++) generate(i)];

  test('1. total: every input → exactly one status + reason', () {
    for (final (p, s) in inputs) {
      final r = reconcileWithSafety(p, s, testRules);
      expect(r.reason, isNotEmpty);
    }
  });

  test('2. no keep when conf < floor or unconfirmed', () {
    for (final (p, s) in inputs) {
      if (s.conf < testRules.config.confFloor || !s.confirmed) {
        expect(
          reconcileWithSafety(p, s, testRules).status,
          isNot(ReconStatus.keep),
        );
      }
    }
  });

  test('3. never outputs a computed dose', () {
    const allowed = {'planMed', 'date', 'condition'};
    for (final (p, s) in inputs) {
      final r = reconcileWithSafety(p, s, testRules);
      expect(allowed.containsAll(r.params.keys), isTrue);
    }
  });

  test('4. stop, duplicate, red changed and allergy → Question + flag', () {
    for (final (p, s) in inputs) {
      final r = reconcileWithSafety(p, s, testRules);
      final mustRaise =
          r.status == ReconStatus.stop ||
          r.status == ReconStatus.duplicate ||
          (r.status == ReconStatus.changed && r.sev == Severity.red) ||
          r.flags.any((f) => f.kind == SafetyKind.allergy);
      if (mustRaise) {
        expect(r.createsQuestion, isTrue, reason: '$r');
        expect(r.createsFlag, isTrue, reason: '$r');
      }
    }
  });

  test('5. deterministic, stamped with ruleVersion', () {
    for (var i = 0; i < cases; i++) {
      final (p, s) = generate(i);
      final a = reconcileWithSafety(p, s, testRules);
      final b = reconcileWithSafety(inputs[i].$1, inputs[i].$2, testRules);
      expect(a, b);
      expect(a.ruleVersion, testRules.version);
    }
  });

  test('6. overlays never lower severity', () {
    for (final (p, s) in inputs) {
      final base = reconcile(p, s, testRules);
      final full = reconcileWithSafety(p, s, testRules);
      expect(full.sev.index, greaterThanOrEqualTo(base.sev.index));
      expect(full.status, base.status);
      expect(full.reason, base.reason);
    }
  });

  test('generator covers every status', () {
    final seen = {
      for (final (p, s) in inputs) reconcile(p, s, testRules).status,
    };
    expect(seen, containsAll(ReconStatus.values));
  });
}
