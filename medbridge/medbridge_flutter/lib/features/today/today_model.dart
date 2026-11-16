import 'dart:convert';

import 'package:med_core/med_core.dart' as core;
import 'package:medbridge_client/medbridge_client.dart';

import '../../core/providers.dart';

/// One due dose on today's schedule.
class DueDose {
  const DueDose({
    required this.schedule,
    required this.item,
    required this.slot,
    required this.dueUtc,
    this.state,
  });

  final DoseSchedule schedule;
  final PlanItemRow item;
  final core.DoseSlot slot;
  final DateTime dueUtc;
  final DoseState? state;

  String get key => '${schedule.id}@${dueUtc.toIso8601String()}';
}

/// Pure derivation of today's doses from schedules + logged events, with
/// optimistic [pending] states overlaid.
List<DueDose> todaysDoses(
  List<ScheduleView> views,
  Map<String, DoseState> pending, {
  DateTime? nowLocal,
}) {
  final today = nowLocal ?? DateTime.now();
  final offset = deviceUtcOffsetMin();
  final out = <DueDose>[];
  for (final v in views) {
    if (!v.schedule.active || v.schedule.prn) continue;
    final slots = [
      for (final n in (jsonDecode(v.schedule.slotsJson) as List))
        core.DoseSlot.values.firstWhere((s) => s.name == n),
    ];
    final due = core.dueTimesUtc(slots, today, offset);
    for (var i = 0; i < slots.length; i++) {
      final logged = v.events.where((e) => e.dueAt.isAtSameMomentAs(due[i])).firstOrNull;
      final d = DueDose(schedule: v.schedule, item: v.item, slot: slots[i], dueUtc: due[i]);
      out.add(DueDose(
        schedule: d.schedule,
        item: d.item,
        slot: d.slot,
        dueUtc: d.dueUtc,
        state: pending[d.key] ?? logged?.state,
      ));
    }
  }
  return out..sort((a, b) => a.dueUtc.compareTo(b.dueUtc));
}
