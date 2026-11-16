/// The single source of "now" for code that needs time. Inject it; never call
/// `DateTime.now()` in domain code.
abstract interface class Clock {
  /// The current instant.
  DateTime now();
}

/// A [Clock] that always returns [instant]. For tests and replays.
final class FixedClock implements Clock {
  /// Creates a clock frozen at [instant].
  const FixedClock(this.instant);

  /// The frozen instant.
  final DateTime instant;

  @override
  DateTime now() => instant;
}
