import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../core/adapters.dart';
import '../generated/protocol.dart';
import '../services/plan_repository.dart';

/// Discharge plans (A10 `plan`, F2).
class PlanEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Stores a parsed AVS as a new `draft` plan for the caller.
  Future<PlanView> uploadDraft(Session session, PlanDraftInput draft) async {
    final patient = await requireLink(session);
    return session.db.transaction((tx) async {
      final plan = await DischargePlan.db.insertRow(
        session,
        DischargePlan(
          patientId: patient.id!,
          dischargeDate: draft.dischargeDate,
          allergiesJson: encodeList({
            ...draft.allergies.map((a) => a.toLowerCase()),
            ...decodeList(patient.allergiesJson),
          }),
          unrecognizedJson: jsonEncode(draft.unrecognized),
        ),
        transaction: tx,
      );
      final rows = await PlanItemRow.db.insert(session, [
        for (final i in draft.items) planItemRowFromInput(i, plan.id!),
      ], transaction: tx);
      await audit(session, 'write', 'plan', plan.id!);
      return PlanView(plan: plan, items: rows);
    });
  }

  /// The patient confirms the reviewed plan: `draft` → `unverified`, and
  /// reminders are scheduled.
  Future<PlanView> confirm(Session session, int planId) async {
    final patient = await requireLink(session);
    final plan = await DischargePlan.db.findById(session, planId);
    if (plan == null || plan.patientId != patient.id) {
      throw AccessDeniedException(message: 'Not your plan.');
    }
    final updated = await DischargePlan.db.updateRow(
      session,
      plan.copyWith(status: PlanStatus.unverified),
    );
    final view = PlanView(
      plan: updated,
      items: await PlanRepository.items(session, planId),
    );
    await PlanRepository.syncSchedules(session, view);
    await audit(session, 'write', 'plan.confirm', planId);
    return view;
  }

  /// The newest plan for the caller or a linked patient.
  Future<PlanView?> get(Session session, {int? patientId}) async {
    final patient = await requireLink(
      session,
      patientId: patientId,
      roles: anyCareRole,
    );
    final view = await PlanRepository.latest(session, patient.id!);
    await audit(session, 'read', 'plan', view?.plan.id ?? 'none');
    return view;
  }

  /// Pharmacist verifies the plan (badge in the app).
  Future<PlanView> verify(Session session, int planId) async {
    await requireRole(session, {Roles.pharmacist});
    final plan = await DischargePlan.db.findById(session, planId);
    if (plan == null) throw AccessDeniedException(message: 'Not found.');
    await requireLink(
      session,
      patientId: plan.patientId,
      roles: {CareRole.pharmacist},
    );
    final updated = await DischargePlan.db.updateRow(
      session,
      plan.copyWith(
        status: PlanStatus.verified,
        verifiedBy: callerId(session),
        verifiedAt: DateTime.now().toUtc(),
      ),
    );
    await audit(session, 'write', 'plan.verify', planId);
    return PlanView(
      plan: updated,
      items: await PlanRepository.items(session, planId),
    );
  }

  /// Pharmacist edits one extracted item; schedules follow the edit.
  Future<PlanItemRow> editItem(
    Session session,
    int itemId,
    PlanItemInput input,
  ) async {
    await requireRole(session, {Roles.pharmacist});
    final row = await PlanItemRow.db.findById(session, itemId);
    if (row == null) throw AccessDeniedException(message: 'Not found.');
    final plan = (await DischargePlan.db.findById(session, row.planId))!;
    await requireLink(
      session,
      patientId: plan.patientId,
      roles: {CareRole.pharmacist},
    );
    final updated = await PlanItemRow.db.updateRow(
      session,
      planItemRowFromInput(input, row.planId).copyWith(id: row.id),
    );
    if (plan.status != PlanStatus.draft) {
      await PlanRepository.syncSchedules(
        session,
        PlanView(
          plan: plan,
          items: await PlanRepository.items(session, plan.id!),
        ),
      );
    }
    await audit(session, 'write', 'plan_item', itemId);
    return updated;
  }
}
