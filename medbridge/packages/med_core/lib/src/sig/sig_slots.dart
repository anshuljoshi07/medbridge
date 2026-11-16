import 'package:med_core/src/domain/enums.dart';

/// The schedule derived from a sig's frequency.
typedef SlotPlan = ({int? perDay, List<DoseSlot> slots, bool ambiguous});

/// Default slot mapping (A6.4).
const Map<int, List<DoseSlot>> perDaySlots = {
  1: [DoseSlot.morning],
  2: [DoseSlot.morning, DoseSlot.evening],
  3: [DoseSlot.morning, DoseSlot.noon, DoseSlot.evening],
  4: [DoseSlot.morning, DoseSlot.noon, DoseSlot.evening, DoseSlot.bedtime],
};

/// Interval mapping (A6.4).
const Map<int, List<DoseSlot>> everyHourSlots = {
  24: [DoseSlot.morning],
  12: [DoseSlot.morning, DoseSlot.evening],
  8: [DoseSlot.morning, DoseSlot.afternoon, DoseSlot.bedtime],
  6: [DoseSlot.morning, DoseSlot.noon, DoseSlot.evening, DoseSlot.bedtime],
};

/// Maps a frequency to schedule slots. PRN gets no slots (no reminders).
///
/// Explicit slots (QAM, QHS) win when they agree with the count; anything
/// that cannot be mapped yields empty slots and `ambiguous: true`, so the
/// caller lowers confidence instead of guessing a schedule.
SlotPlan planSlots({
  required int? perDay,
  required int? everyH,
  required List<DoseSlot> explicit,
  required bool prn,
}) {
  if (prn) return (perDay: perDay, slots: const [], ambiguous: false);
  final ordered = [...explicit]..sort((a, b) => a.index.compareTo(b.index));
  if (ordered.isNotEmpty) {
    final agrees = perDay == null || perDay == ordered.length;
    return (
      perDay: perDay ?? ordered.length,
      slots: agrees ? ordered : const [],
      ambiguous: !agrees || everyH != null,
    );
  }
  if (perDay != null) {
    final slots = perDaySlots[perDay];
    return (
      perDay: perDay,
      slots: slots ?? const [],
      ambiguous: slots == null || everyH != null,
    );
  }
  if (everyH != null) {
    final slots = everyHourSlots[everyH];
    return (perDay: null, slots: slots ?? const [], ambiguous: slots == null);
  }
  return (perDay: null, slots: const [], ambiguous: false);
}
