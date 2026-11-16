import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/builders.dart';
import 'support/rules.dart';

void main() {
  ReconResult run(Plan p, Scan s) => reconcile(p, s, testRules);
  void expectRow(
    ReconResult r,
    ReconStatus status,
    String reason,
    Severity sev,
  ) {
    expect(r.status, status, reason: 'status');
    expect(r.reason, reason, reason: 'reason');
    expect(r.sev, sev, reason: 'severity');
    expect(r.ruleVersion, testRules.version);
  }

  final keepAtorva = item(
    'atorvastatin',
    PlanAction.keep,
    'atorvastatin 40 mg tab',
  );
  final atorva40 = scan('atorvastatin 40 mg tablet', ings: {'atorvastatin'});

  group('row 0: LOW_CONFIDENCE', () {
    test('not confirmed', () {
      final s = scan(
        'atorvastatin 40 mg tab',
        ings: {'atorvastatin'},
        confirmed: false,
      );
      expectRow(
        run(plan([keepAtorva]), s),
        ReconStatus.unknown,
        'LOW_CONFIDENCE',
        Severity.amber,
      );
    });
    test('conf below floor, even if confirmed and an exact match', () {
      final s = scan(
        'atorvastatin 40 mg tab',
        ings: {'atorvastatin'},
        conf: 0.69,
      );
      expectRow(
        run(plan([keepAtorva]), s),
        ReconStatus.unknown,
        'LOW_CONFIDENCE',
        Severity.amber,
      );
    });
  });

  test('row 1: PLAN_STOP', () {
    final p = plan([
      item('lisinopril', PlanAction.stop, 'lisinopril 10 mg tab'),
    ]);
    final r = run(p, scan('lisinopril 10 mg', ings: {'lisinopril'}));
    expectRow(r, ReconStatus.stop, 'PLAN_STOP', Severity.red);
    expect(r.itemId, 'lisinopril');
  });

  test('row 2: PLAN_HOLD carries the condition', () {
    final p = plan([
      item(
        'metformin',
        PlanAction.hold,
        'metformin 500 mg tab',
        sig: '1 tab PO BID',
        holdNote: 'until follow-up',
      ),
    ]);
    final r = run(p, scan('metformin 500 mg', ings: {'metformin'}));
    expectRow(r, ReconStatus.hold, 'PLAN_HOLD', Severity.amber);
    expect(r.params['condition'], 'until follow-up');
  });

  group('change', () {
    final p = plan([
      item(
        'metoprolol',
        PlanAction.change,
        'metoprolol succinate ER 25 mg tab',
      ),
    ]);
    test('row 3: same SCD → NEW_DIRECTIONS', () {
      final r = run(
        p,
        scan('metoprolol succinate ER 25 mg', ings: {'metoprolol'}),
      );
      expectRow(r, ReconStatus.changed, 'NEW_DIRECTIONS', Severity.amber);
    });
    test('row 4: different strength → OLD_STRENGTH_BOTTLE', () {
      final r = run(
        p,
        scan('metoprolol succinate ER 50 mg', ings: {'metoprolol'}),
      );
      expectRow(r, ReconStatus.changed, 'OLD_STRENGTH_BOTTLE', Severity.red);
    });
  });

  group('keep', () {
    test('row 5: equal → MATCH', () {
      expectRow(
        run(plan([keepAtorva]), atorva40),
        ReconStatus.keep,
        'MATCH',
        Severity.ok,
      );
    });
    test('row 5: 1000 mcg equals 1 mg (comparison only)', () {
      final p = plan([
        item('levothyroxine', PlanAction.keep, 'levothyroxine 0.1 mg tab'),
      ]);
      final r = run(
        p,
        scan('levothyroxine 100 mcg tab', ings: {'levothyroxine'}),
      );
      expectRow(r, ReconStatus.keep, 'MATCH', Severity.ok);
    });
    test('row 6: strength differs → STRENGTH_MISMATCH', () {
      final r = run(
        plan([keepAtorva]),
        scan('atorvastatin 20 mg tab', ings: {'atorvastatin'}),
      );
      expectRow(r, ReconStatus.changed, 'STRENGTH_MISMATCH', Severity.red);
    });
    test('row 6: release differs → FORM_MISMATCH', () {
      final p = plan([
        item('metoprolol', PlanAction.keep, 'metoprolol 25 mg tab'),
      ]);
      final r = run(
        p,
        scan('metoprolol succinate ER 25 mg tab', ings: {'metoprolol'}),
      );
      expectRow(r, ReconStatus.changed, 'FORM_MISMATCH', Severity.red);
    });
    test('row 6: missing strength is never a match', () {
      final r = run(
        plan([keepAtorva]),
        scan('atorvastatin tab', ings: {'atorvastatin'}),
      );
      expectRow(r, ReconStatus.changed, 'STRENGTH_MISMATCH', Severity.red);
    });
  });

  group('start', () {
    final p = plan([item('losartan', PlanAction.start, 'losartan 50 mg tab')]);
    test('row 7: equal → NEW_MED', () {
      final r = run(p, scan('losartan 50 mg tab', ings: {'losartan'}));
      expectRow(r, ReconStatus.newMed, 'NEW_MED', Severity.info);
    });
    test('row 8: differs → NEW_MED_MISMATCH', () {
      final r = run(p, scan('losartan 100 mg tab', ings: {'losartan'}));
      expectRow(r, ReconStatus.changed, 'NEW_MED_MISMATCH', Severity.red);
    });
  });

  group('row 9: duplicate class', () {
    test('ACE-I bottle vs ARB on plan (different ATC-4, same raas group)', () {
      final p = plan([
        item('losartan', PlanAction.start, 'losartan 50 mg tab'),
      ]);
      final r = run(p, scan('benazepril 20 mg', ings: {'benazepril'}));
      expectRow(
        r,
        ReconStatus.duplicate,
        'SAME_CLASS_AS:losartan',
        Severity.red,
      );
      expect(r.params['planMed'], 'losartan 50 mg tab');
    });
    test('same ATC-4 class', () {
      final p = plan([keepAtorva]);
      final r = run(p, scan('simvastatin 20 mg', ings: {'simvastatin'}));
      expectRow(
        r,
        ReconStatus.duplicate,
        'SAME_CLASS_AS:atorvastatin',
        Severity.red,
      );
    });
    test('fires even when the old bottle was left off the AVS', () {
      final p = plan([
        item('valsartan', PlanAction.start, 'valsartan 80 mg tab'),
      ]);
      final r = run(p, scan('lisinopril 10 mg', ings: {'lisinopril'}));
      expect(r.status, ReconStatus.duplicate);
    });
    test('ignores inactive (stopped) plan items', () {
      final p = plan([
        item('lisinopril', PlanAction.stop, 'lisinopril 10 mg tab'),
      ]);
      final r = run(p, scan('benazepril 20 mg', ings: {'benazepril'}));
      expect(r.reason, 'NOT_ON_PLAN');
    });
  });

  group('row 10: NOT_ON_PLAN', () {
    test('amber by default', () {
      final r = run(
        plan([keepAtorva]),
        scan('omeprazole 20 mg cap', ings: {'omeprazole'}),
      );
      expectRow(r, ReconStatus.unknown, 'NOT_ON_PLAN', Severity.amber);
    });
    test('red when high-risk', () {
      final r = run(
        plan([keepAtorva]),
        scan('warfarin 5 mg tab', ings: {'warfarin'}),
      );
      expectRow(r, ReconStatus.unknown, 'NOT_ON_PLAN', Severity.red);
    });
  });

  test('COMBO_PARTIAL: partial ingredient overlap', () {
    final p = plan([
      item('lisinopril', PlanAction.keep, 'lisinopril 10 mg tab'),
    ]);
    final r = run(
      p,
      scan(
        'lisinopril-hydrochlorothiazide 10-12.5 mg tab',
        ings: {'lisinopril', 'hydrochlorothiazide'},
      ),
    );
    expectRow(r, ReconStatus.changed, 'COMBO_PARTIAL', Severity.red);
  });

  test('SIG_UNSUPPORTED: matched plan item has a taper', () {
    final p = plan([
      item(
        'prednisone',
        PlanAction.start,
        'prednisone 10 mg tab',
        sig: 'Take 4 tabs daily x 3 days then 2 tabs daily',
      ),
    ]);
    final r = run(p, scan('prednisone 10 mg tab', ings: {'prednisone'}));
    expectRow(r, ReconStatus.unknown, 'SIG_UNSUPPORTED:TAPER', Severity.amber);
  });

  test('first match wins: stop beats a same-ingredient change', () {
    final p = plan([
      item(
        'metoprolol-old',
        PlanAction.stop,
        'metoprolol tartrate 25 mg tab',
        ings: {'metoprolol'},
      ),
      item(
        'metoprolol',
        PlanAction.change,
        'metoprolol succinate ER 25 mg tab',
      ),
    ]);
    final oldBottle = run(
      p,
      scan('metoprolol tartrate 25 mg tab', ings: {'metoprolol'}),
    );
    expect(oldBottle.status, ReconStatus.stop);
    final newBottle = run(
      p,
      scan('metoprolol succinate ER 25 mg tab', ings: {'metoprolol'}),
    );
    expect(newBottle.reason, 'NEW_DIRECTIONS');
  });
}
