import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

void main() {
  group('dueTimesUtc', () {
    test('converts local slot times using the UTC offset', () {
      // Central time (UTC-6): 8:00 local = 14:00 UTC.
      final due = dueTimesUtc(
        [DoseSlot.morning, DoseSlot.bedtime],
        DateTime(2026, 11, 16),
        -360,
      );
      expect(due, [
        DateTime.utc(2026, 11, 16, 14),
        DateTime.utc(2026, 11, 17, 3),
      ]);
    });
    test('a time-zone change only moves instants, never drops slots', () {
      final a = dueTimesUtc([DoseSlot.morning], DateTime(2026, 11, 16), -360);
      final b = dueTimesUtc([DoseSlot.morning], DateTime(2026, 11, 16), -300);
      expect(a.length, b.length);
      expect(a.single.difference(b.single), const Duration(hours: 1));
    });
  });

  test('isMissed after the window only', () {
    final due = DateTime.utc(2026, 11, 16, 14);
    expect(isMissed(due, due.add(const Duration(minutes: 119)), 120), isFalse);
    expect(isMissed(due, due.add(const Duration(minutes: 121)), 120), isTrue);
  });

  test('trailingMissed counts only the latest run', () {
    expect(trailingMissed([]), 0);
    expect(
      trailingMissed([DoseState.missed, DoseState.taken, DoseState.missed]),
      1,
    );
    expect(
      trailingMissed([DoseState.taken, DoseState.missed, DoseState.missed]),
      2,
    );
  });
}
