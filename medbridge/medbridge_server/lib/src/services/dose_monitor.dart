import 'dart:convert';

import 'package:med_core/med_core.dart' as core;
import 'package:serverpod/serverpod.dart';

import '../core/adapters.dart';
import '../generated/protocol.dart';
import 'alert_service.dart';

/// Marks missed doses and evaluates the F7 alert triggers (N consecutive
/// missed, default 2; any missed high-risk dose). Idempotent: events are
/// unique per (schedule, due) and alerts per dedupe key.
abstract final class DoseMonitor {
  /// One pass at [nowUtc] (tests pass a fixed instant).
  static Future<void> runDispatch(Session session, DateTime nowUtc) async {
    final cfg = core.ShippedRules.ruleSet.config;
    final schedules = await DoseSchedule.db.find(
      session,
      where: (t) => t.active.equals(true) & t.prn.equals(false),
    );
    for (final s in schedules) {
      final item = await PlanItemRow.db.findById(session, s.planItemId);
      final plan = item == null
          ? null
          : await DischargePlan.db.findById(session, item.planId);
      if (plan == null || plan.status == PlanStatus.draft) continue;
      final patient = (await Patient.db.findById(session, plan.patientId))!;
      final slots = [
        for (final n in decodeList(s.slotsJson))
          core.DoseSlot.values.firstWhere((d) => d.name == n),
      ];
      final local = nowUtc.add(Duration(minutes: patient.utcOffsetMin));
      for (final day in [local.subtract(const Duration(days: 1)), local]) {
        for (final due in core.dueTimesUtc(slots, day, patient.utcOffsetMin)) {
          if (due.isBefore(plan.createdAt)) continue;
          if (!core.isMissed(due, nowUtc, cfg.missedWindowMin)) continue;
          await _markMissed(session, s.id!, due);
        }
      }
      await _evaluate(session, patient, s, item!, cfg.missedAlertN);
    }
  }

  static Future<void> _markMissed(
    Session session,
    int scheduleId,
    DateTime due,
  ) async {
    final existing = await DoseEvent.db.findFirstRow(
      session,
      where: (t) => t.scheduleId.equals(scheduleId) & t.dueAt.equals(due),
    );
    if (existing != null) return;
    await DoseEvent.db.insertRow(
      session,
      DoseEvent(scheduleId: scheduleId, dueAt: due, state: DoseState.missed),
    );
  }

  static Future<void> _evaluate(
    Session session,
    Patient patient,
    DoseSchedule s,
    PlanItemRow item,
    int alertN,
  ) async {
    final events = await DoseEvent.db.find(
      session,
      where: (t) => t.scheduleId.equals(s.id!),
      orderBy: (t) => t.dueAt,
    );
    if (events.isEmpty) return;
    final states = [
      for (final e in events) core.DoseState.values.byName(e.state.name),
    ];
    final last = events.last;
    final highRisk = core.ShippedRules.ruleSet.isHighRisk(
      decodeList(item.ingsJson).toSet(),
    );
    final dayKey = last.dueAt.toIso8601String().substring(0, 10);
    if (core.trailingMissed(states) >= alertN) {
      await AlertService.raise(
        session,
        patient,
        type: 'missed_doses',
        sev: 'amber',
        dedupeKey: 'missed:${s.id}:$dayKey',
      );
    }
    if (highRisk && last.state == DoseState.missed) {
      await AlertService.raise(
        session,
        patient,
        type: 'missed_high_risk',
        sev: 'red',
        dedupeKey:
            'missedhr:${s.id}:${jsonEncode(last.dueAt.toIso8601String())}',
      );
    }
  }
}
