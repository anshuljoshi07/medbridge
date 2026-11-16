import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/plan.dart';

/// One plan item that gets scheduled reminders.
typedef ReminderItem = ({String itemId, List<DoseSlot> slots});

/// The plan items that get reminders (F5): active (keep / change / start),
/// a supported sig, not PRN, and at least one slot.
///
/// Stop and hold items get none, so suspending reminders is immediate. PRN
/// items show "as needed" but never remind.
List<ReminderItem> reminderItems(Plan p) => [
  for (final item in p.items)
    if (item.isActive &&
        item.sig != null &&
        item.sig!.isSupported &&
        !item.sig!.prn &&
        item.sig!.slots.isNotEmpty)
      (itemId: item.id, slots: item.sig!.slots),
];

/// Default local clock time per slot, as minutes after midnight.
const Map<DoseSlot, int> defaultSlotMinutes = {
  DoseSlot.morning: 8 * 60,
  DoseSlot.noon: 12 * 60,
  DoseSlot.afternoon: 14 * 60,
  DoseSlot.evening: 18 * 60,
  DoseSlot.bedtime: 21 * 60,
};

/// UTC due instants for [slots] on the patient's local calendar day
/// [localDay] (only year / month / day are read), given the patient's UTC
/// offset in minutes. Pure: no clock, no time-zone database.
List<DateTime> dueTimesUtc(
  List<DoseSlot> slots,
  DateTime localDay,
  int utcOffsetMin, {
  Map<DoseSlot, int> slotMinutes = defaultSlotMinutes,
}) => [
  for (final s in slots)
    DateTime.utc(
      localDay.year,
      localDay.month,
      localDay.day,
    ).add(Duration(minutes: (slotMinutes[s] ?? 0) - utcOffsetMin)),
];

/// Whether a dose due at [dueUtc] with no log counts as missed at [nowUtc]:
/// not logged within the window (default 2 h, configurable).
bool isMissed(DateTime dueUtc, DateTime nowUtc, int windowMin) =>
    nowUtc.isAfter(dueUtc.add(Duration(minutes: windowMin)));

/// The number of consecutive missed doses at the end of [statesOldestFirst].
int trailingMissed(List<DoseState> statesOldestFirst) {
  var n = 0;
  for (final s in statesOldestFirst.reversed) {
    if (s != DoseState.missed) break;
    n++;
  }
  return n;
}

/// The logged outcome of one scheduled dose.
enum DoseState {
  /// Marked as taken.
  taken,

  /// Deliberately skipped.
  skipped,

  /// Not logged within the window.
  missed,
}
