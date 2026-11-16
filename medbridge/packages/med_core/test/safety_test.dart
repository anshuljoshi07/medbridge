import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/builders.dart';
import 'support/rules.dart';

void main() {
  ReconResult run(Plan p, Scan s) => reconcileWithSafety(p, s, testRules);
  Iterable<String> codes(ReconResult r) => r.flags.map((f) => f.code);

  test(
    'rule files still carry placeholder rows (must be replaced before pilot)',
    () {
      expect(testRules.hasTestRows, isTrue);
    },
  );

  group('allergy', () {
    test('ingredient hit → red block', () {
      final p = plan([], allergies: {'ibuprofen'});
      final r = run(p, scan('ibuprofen 200 mg tab', ings: {'ibuprofen'}));
      expect(codes(r), contains('ALLERGY:ibuprofen'));
      expect(r.sev, Severity.red);
      expect(r.createsQuestion, isTrue);
    });
    test('class hit: penicillin allergy vs amoxicillin', () {
      final p = plan([], allergies: {'penicillins'});
      final r = run(p, scan('amoxicillin 500 mg cap', ings: {'amoxicillin'}));
      expect(codes(r), contains('ALLERGY:penicillins'));
      expect(r.sev, Severity.red);
    });
    test('raises a keep MATCH to red without changing its status', () {
      final p = plan(
        [
          item('atorvastatin', PlanAction.keep, 'atorvastatin 40 mg tab'),
        ],
        allergies: {'atorvastatin'},
      );
      final r = run(p, scan('atorvastatin 40 mg tab', ings: {'atorvastatin'}));
      expect(r.status, ReconStatus.keep);
      expect(r.sev, Severity.red);
    });
  });

  group('drug–drug interaction', () {
    final p = plan([item('warfarin', PlanAction.keep, 'warfarin 5 mg tab')]);
    test('banner + auto question, never stop advice', () {
      final r = run(p, scan('ibuprofen 200 mg tab', ings: {'ibuprofen'}));
      final ddi = r.flags.singleWhere((f) => f.kind == SafetyKind.interaction);
      expect(ddi.code, 'DDI:ibuprofen+warfarin');
      expect(ddi.detail, 'bleeding risk');
      expect(r.createsQuestion, isTrue);
      expect(r.status, isNot(ReconStatus.stop));
    });
    test('not raised for a bottle the plan stopped', () {
      final stopped = plan([
        item('warfarin', PlanAction.keep, 'warfarin 5 mg tab'),
        item('ibuprofen', PlanAction.stop, 'ibuprofen 200 mg tab'),
      ]);
      final r = run(stopped, scan('ibuprofen 200 mg tab', ings: {'ibuprofen'}));
      expect(r.flags.where((f) => f.kind == SafetyKind.interaction), isEmpty);
    });
  });

  group('high-risk', () {
    test('badge (info) on a matched high-risk med', () {
      final p = plan([item('warfarin', PlanAction.keep, 'warfarin 5 mg tab')]);
      final r = run(p, scan('warfarin 5 mg tab', ings: {'warfarin'}));
      expect(codes(r), contains('HIGH_RISK'));
      expect(r.status, ReconStatus.keep);
    });
    test('unknown high-risk → red', () {
      final r = run(plan([]), scan('warfarin 5 mg tab', ings: {'warfarin'}));
      expect(r.sev, Severity.red);
    });
  });

  test('LASA badge when a confusable name is on the plan', () {
    final p = plan([
      item('hydralazine', PlanAction.keep, 'hydralazine 25 mg tab'),
    ]);
    final r = run(p, scan('hydroxyzine 25 mg tab', ings: {'hydroxyzine'}));
    expect(codes(r), contains('LASA:hydroxyzine|hydralazine'));
  });
}
