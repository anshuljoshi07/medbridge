import 'package:medbridge_server/src/core/adapters.dart';
import 'package:medbridge_server/src/generated/protocol.dart';
import 'package:medbridge_server/src/services/dose_monitor.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'support/scenario.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod(
    'Given synthetic patient R. Doe (B10)',
    (sb, endpoints) {
      final session = sb.build();
      late UuidValue patientId, caregiverId, pharmacistId, outsiderId;
      late TestSessionBuilder patient, caregiver, pharmacist, outsider;
      late PlanView plan;
      final outcomes = <String, ReconOutcome>{};

      setUpAll(() async {
        patientId = await createUser(session, {});
        caregiverId = await createUser(session, {});
        pharmacistId = await createUser(session, {'pharmacist'});
        outsiderId = await createUser(session, {'clinician'});
        patient = as(sb, patientId);
        caregiver = as(sb, caregiverId);
        pharmacist = as(sb, pharmacistId);
        outsider = as(sb, outsiderId);

        await endpoints.patient.register(patient, 'patient', 'R.', 'en', -360);
        await endpoints.patient.register(
          caregiver,
          'caregiver',
          'Sam',
          'en',
          -360,
        );
        final draft = await endpoints.plan.uploadDraft(
          patient,
          toInput(rDoeDraft()),
        );
        plan = await endpoints.plan.confirm(patient, draft.plan.id!);

        final cg = await endpoints.care.createInvite(
          patient,
          CareRole.caregiver,
        );
        await endpoints.care.acceptInvite(caregiver, cg.inviteCode);
        final ph = await endpoints.care.createInvite(
          patient,
          CareRole.pharmacist,
        );
        await endpoints.care.acceptInvite(
          pharmacist,
          ph.inviteCode.toLowerCase(),
        );

        final ctx = planToCore(plan.plan, plan.items);
        for (final label in [
          'lisinopril_10',
          'losartan_50',
          'metoprolol_er_50',
          'atorvastatin_40',
          'metformin_500',
          'benazepril_20',
          'omeprazole_20',
        ]) {
          outcomes[label] = await endpoints.scan.submit(
            patient,
            scanFromLabel(label, ctx),
          );
        }
      });

      test('then the plan has the 5 AVS items, confirmed and unverified', () {
        expect(plan.plan.status, PlanStatus.unverified);
        expect(plan.items.map((i) => '${i.action}:${i.itemKey}'), [
          'start:losartan',
          'change:metoprolol',
          'keep:atorvastatin',
          'hold:metformin',
          'stop:lisinopril',
        ]);
      });

      const expected = {
        'lisinopril_10': ('stop', 'PLAN_STOP', 'red'),
        'losartan_50': ('newMed', 'NEW_MED', 'info'),
        'metoprolol_er_50': ('changed', 'OLD_STRENGTH_BOTTLE', 'red'),
        'atorvastatin_40': ('keep', 'MATCH', 'ok'),
        'metformin_500': ('hold', 'PLAN_HOLD', 'amber'),
        'benazepril_20': ('duplicate', 'SAME_CLASS_AS:losartan', 'red'),
        'omeprazole_20': ('unknown', 'NOT_ON_PLAN', 'amber'),
      };
      for (final e in expected.entries) {
        test(
          'then ${e.key} → ${e.value.$1} / ${e.value.$2} / ${e.value.$3}',
          () {
            final o = outcomes[e.key]!;
            expect((o.status, o.reason, o.sev), e.value);
          },
        );
      }

      test(
        'then 4 auto Questions exist: stop, changed-red, duplicate, unknown',
        () async {
          final qs = await endpoints.questions.list(patient);
          expect(qs.where((q) => q.source == 'auto'), hasLength(4));
          expect(qs.every((q) => q.linkedReconId != null), isTrue);
        },
      );

      test('then each red result alerted the caregiver, with no PHI', () async {
        final alerts = await endpoints.alerts.list(
          caregiver,
          patientId: plan.plan.patientId,
        );
        final red = alerts.where((a) => a.type == 'red_result').toList();
        expect(red, hasLength(3));
        expect(red.first.recipientsJson, contains(caregiverId.toString()));
      });

      test(
        'then reminders exist for losartan, metoprolol, atorvastatin only',
        () async {
          final s = await endpoints.schedule.get(patient);
          final active = [
            for (final v in s)
              if (v.schedule.active) v.item.itemKey,
          ];
          expect(active, ['losartan', 'metoprolol', 'atorvastatin']);
        },
      );

      test('then a caregiver cannot edit the plan', () async {
        final item = plan.items.first;
        await expectLater(
          endpoints.plan.editItem(caregiver, item.id!, _inputOf(item)),
          throwsA(isA<AccessDeniedException>()),
        );
      });

      test('then an unlinked clinician is denied (403)', () async {
        await expectLater(
          endpoints.dashboard.summary(outsider, plan.plan.patientId),
          throwsA(isA<AccessDeniedException>()),
        );
        await expectLater(
          endpoints.plan.get(outsider, patientId: plan.plan.patientId),
          throwsA(isA<AccessDeniedException>()),
        );
        expect(await endpoints.dashboard.patients(outsider), isEmpty);
      });

      test(
        'then the pharmacist sees 3 red flags, verifies, and answers',
        () async {
          final pts = await endpoints.dashboard.patients(pharmacist);
          expect(pts.single.redCount, 3);
          final verified = await endpoints.plan.verify(
            pharmacist,
            plan.plan.id!,
          );
          expect(verified.plan.status, PlanStatus.verified);
          final q = (await endpoints.questions.list(
            pharmacist,
            patientId: plan.plan.patientId,
          )).first;
          await endpoints.questions.answer(
            pharmacist,
            q.id!,
            'Set it aside; bring it Tuesday.',
          );
          final mine = await endpoints.questions.list(patient);
          expect(
            mine.firstWhere((x) => x.id == q.id).answer,
            'Set it aside; bring it Tuesday.',
          );
        },
      );

      test('then every PHI view was audit-logged', () async {
        await endpoints.plan.get(caregiver, patientId: plan.plan.patientId);
        final rows = await AuditLog.db.find(session);
        final actions = rows.map((r) => '${r.action}:${r.entity}').toSet();
        expect(
          actions,
          containsAll(['read:plan', 'write:scan', 'read:dashboard.patients']),
        );
      });

      test(
        'then 2 consecutive missed doses alert the caregiver once',
        () async {
          final created = plan.plan.createdAt;
          // Each pass looks at yesterday and today; two daily passes give two
          // consecutive missed doses. Re-running a pass must not duplicate.
          await DoseMonitor.runDispatch(
            session,
            created.add(const Duration(days: 2)),
          );
          await DoseMonitor.runDispatch(
            session,
            created.add(const Duration(days: 3)),
          );
          await DoseMonitor.runDispatch(
            session,
            created.add(const Duration(days: 3)),
          );
          final alerts = await Alert.db.find(
            session,
            where: (t) => t.type.equals('missed_doses'),
          );
          expect(alerts, isNotEmpty);
          final keys = alerts.map((a) => a.dedupeKey).toList();
          expect(keys.toSet().length, keys.length);
        },
      );
    },
    rollbackDatabase: RollbackDatabase.disabled,
  );
}

PlanItemInput _inputOf(PlanItemRow r) => PlanItemInput(
  itemKey: r.itemKey,
  action: 'stop',
  name: r.name,
  ings: decodeList(r.ingsJson),
  strength: r.strength,
  form: r.form,
  sigRaw: r.sigRaw,
  src: r.src,
  conf: r.conf,
  classIds: decodeList(r.classIdsJson),
);
