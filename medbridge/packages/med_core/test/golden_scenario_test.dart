import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/builders.dart';
import 'support/rules.dart';

/// B10 end-to-end scenario at the core level: synthetic patient "R. Doe, 78".
void main() {
  final rDoe = plan(
    [
      item('losartan', PlanAction.start, 'losartan 50 mg tab'),
      item('lisinopril', PlanAction.stop, 'lisinopril 10 mg tab', sig: ''),
      item(
        'metoprolol',
        PlanAction.change,
        'metoprolol succinate ER 25 mg tab',
      ),
      item(
        'atorvastatin',
        PlanAction.keep,
        'atorvastatin 40 mg tab',
        sig: '1 tab PO QHS',
      ),
      item(
        'metformin',
        PlanAction.hold,
        'metformin 500 mg tab',
        sig: '1 tab PO BID',
        holdNote: 'until follow-up',
      ),
    ],
    allergies: {'penicillins'},
  );

  final bottles = <(Scan, ReconStatus, String, Severity)>[
    (
      scan('lisinopril 10 mg tab', ings: {'lisinopril'}),
      ReconStatus.stop,
      'PLAN_STOP',
      Severity.red,
    ),
    (
      scan('losartan 50 mg tab', ings: {'losartan'}),
      ReconStatus.newMed,
      'NEW_MED',
      Severity.info,
    ),
    (
      scan('metoprolol succinate ER 50 mg tab', ings: {'metoprolol'}),
      ReconStatus.changed,
      'OLD_STRENGTH_BOTTLE',
      Severity.red,
    ),
    (
      scan('atorvastatin 40 mg tab', ings: {'atorvastatin'}),
      ReconStatus.keep,
      'MATCH',
      Severity.ok,
    ),
    (
      scan('metformin 500 mg tab', ings: {'metformin'}),
      ReconStatus.hold,
      'PLAN_HOLD',
      Severity.amber,
    ),
    (
      scan('benazepril 20 mg tab', ings: {'benazepril'}),
      ReconStatus.duplicate,
      'SAME_CLASS_AS:losartan',
      Severity.red,
    ),
    (
      scan('omeprazole 20 mg cap', ings: {'omeprazole'}),
      ReconStatus.unknown,
      'NOT_ON_PLAN',
      Severity.amber,
    ),
  ];

  final results = [
    for (final (s, _, _, _) in bottles) reconcileWithSafety(rDoe, s, testRules),
  ];

  for (var i = 0; i < bottles.length; i++) {
    final (s, status, reason, sev) = bottles[i];
    test('${s.name} → ${status.name} / $reason / ${sev.name}', () {
      expect(results[i].status, status);
      expect(results[i].reason, reason);
      expect(results[i].sev, sev);
    });
  }

  test('4 auto Questions: stop, changed-red, duplicate, unknown', () {
    final q = results.where((r) => r.createsQuestion).map((r) => r.status);
    expect(q, [
      ReconStatus.stop,
      ReconStatus.changed,
      ReconStatus.duplicate,
      ReconStatus.unknown,
    ]);
  });

  test('3 red dashboard flags (also the caregiver alert triggers)', () {
    expect(results.where((r) => r.createsFlag), hasLength(3));
  });

  test('reminders for losartan, metoprolol, atorvastatin only', () {
    expect(reminderItems(rDoe).map((r) => r.itemId), [
      'losartan',
      'metoprolol',
      'atorvastatin',
    ]);
    final atorva = reminderItems(rDoe).last;
    expect(atorva.slots, [DoseSlot.bedtime]);
  });
}
