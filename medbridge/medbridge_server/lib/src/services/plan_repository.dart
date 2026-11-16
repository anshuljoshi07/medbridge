import 'package:med_core/med_core.dart' as core;
import 'package:serverpod/serverpod.dart';

import '../core/adapters.dart';
import '../generated/protocol.dart';

/// Reads plans and keeps dose schedules in step with them.
abstract final class PlanRepository {
  /// The patient's newest plan with its items, or `null`.
  static Future<PlanView?> latest(Session session, int patientId) async {
    final plan = await DischargePlan.db.findFirstRow(
      session,
      where: (t) => t.patientId.equals(patientId),
      orderBy: (t) => t.id.desc(),
    );
    if (plan == null) return null;
    return PlanView(plan: plan, items: await items(session, plan.id!));
  }

  /// Items of plan [planId] in source order.
  static Future<List<PlanItemRow>> items(Session session, int planId) =>
      PlanItemRow.db.find(
        session,
        where: (t) => t.planId.equals(planId),
        orderBy: (t) => t.id,
      );

  /// The med_core view of the patient's newest confirmed plan; an empty plan
  /// (everything becomes Unknown / NOT_ON_PLAN) if none.
  static Future<core.Plan> corePlan(Session session, int patientId) async {
    final view = await latest(session, patientId);
    if (view == null || view.plan.status == PlanStatus.draft) {
      return const core.Plan(id: 'none', items: []);
    }
    return planToCore(view.plan, view.items);
  }

  /// Rebuilds dose schedules from the plan: active, supported, non-PRN items
  /// get slots; everything else is deactivated, so Stop / Hold suspend
  /// reminders immediately (F5).
  static Future<void> syncSchedules(Session session, PlanView view) async {
    final corePlan = planToCore(view.plan, view.items);
    final reminders = {
      for (final r in core.reminderItems(corePlan)) r.itemId: r.slots,
    };
    for (final row in view.items) {
      final slots = reminders[row.itemKey];
      final sig = row.toCore().sig;
      final existing = await DoseSchedule.db.findFirstRow(
        session,
        where: (t) => t.planItemId.equals(row.id!),
      );
      final schedule = DoseSchedule(
        id: existing?.id,
        planItemId: row.id!,
        slotsJson: encodeOrdered([
          for (final s in slots ?? const <core.DoseSlot>[]) s.name,
        ]),
        prn: sig?.prn ?? false,
        active: slots != null,
        suspendedUntil: row.action == 'hold' ? row.holdUntil : null,
      );
      if (existing == null) {
        await DoseSchedule.db.insertRow(session, schedule);
      } else {
        await DoseSchedule.db.updateRow(session, schedule);
      }
    }
  }

  /// JSON list that keeps the given order (slots are in day order).
  static String encodeOrdered(List<String> values) =>
      '[${values.map((v) => '"$v"').join(',')}]';
}
