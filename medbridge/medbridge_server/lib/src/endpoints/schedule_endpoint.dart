import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../services/plan_repository.dart';

/// Daily schedule and adherence log (A10 `schedule`, F5).
class ScheduleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Schedules for the newest plan, each with its last 48 h of dose events.
  Future<List<ScheduleView>> get(Session session, {int? patientId}) async {
    final patient = await requireLink(
      session,
      patientId: patientId,
      roles: anyCareRole,
    );
    await audit(session, 'read', 'schedule', patient.id!);
    final view = await PlanRepository.latest(session, patient.id!);
    if (view == null || view.items.isEmpty) return [];
    final byId = {for (final i in view.items) i.id!: i};
    final schedules = await DoseSchedule.db.find(
      session,
      where: (t) => t.planItemId.inSet(byId.keys.toSet()),
      orderBy: (t) => t.planItemId,
    );
    final since = DateTime.now().toUtc().subtract(const Duration(hours: 48));
    return [
      for (final s in schedules)
        ScheduleView(
          schedule: s,
          item: byId[s.planItemId]!,
          events: await DoseEvent.db.find(
            session,
            where: (t) => t.scheduleId.equals(s.id!) & (t.dueAt > since),
            orderBy: (t) => t.dueAt,
          ),
        ),
    ];
  }

  /// Logs Taken / Skip for one due dose (upsert by schedule + due time).
  Future<DoseEvent> logDose(
    Session session,
    int scheduleId,
    DateTime dueAt,
    DoseState state,
  ) async {
    final patient = await requireLink(session);
    final schedule = await DoseSchedule.db.findById(session, scheduleId);
    final item = schedule == null
        ? null
        : await PlanItemRow.db.findById(session, schedule.planItemId);
    final plan = item == null
        ? null
        : await DischargePlan.db.findById(session, item.planId);
    if (plan == null || plan.patientId != patient.id) {
      throw AccessDeniedException(message: 'Not your schedule.');
    }
    final due = dueAt.toUtc();
    final existing = await DoseEvent.db.findFirstRow(
      session,
      where: (t) => t.scheduleId.equals(scheduleId) & t.dueAt.equals(due),
    );
    final event = DoseEvent(
      id: existing?.id,
      scheduleId: scheduleId,
      dueAt: due,
      state: state,
      loggedAt: DateTime.now().toUtc(),
    );
    await audit(session, 'write', 'dose_event', scheduleId);
    return existing == null
        ? DoseEvent.db.insertRow(session, event)
        : DoseEvent.db.updateRow(session, event);
  }
}
