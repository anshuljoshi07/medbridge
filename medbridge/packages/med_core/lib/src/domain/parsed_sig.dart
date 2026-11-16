import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

/// A sig (directions) parsed from standard notation (A6.4).
///
/// Never holds a computed dose: [qty] is copied from the text, not derived.
@immutable
final class ParsedSig {
  /// Creates a parsed sig.
  const ParsedSig({
    required this.raw,
    this.qty,
    this.unit,
    this.route,
    this.eye,
    this.perDay,
    this.everyH,
    this.slots = const [],
    this.prn = false,
    this.prnMax,
    this.food,
    this.days,
    this.flags = const {},
    this.conf = 0,
  });

  /// The original text.
  final String raw;

  /// Units per dose as written (`1` in "take 1 tab").
  final int? qty;

  /// Dose unit key: `tablet`, `capsule`, `drop`, `puff`, `patch`.
  final String? unit;

  /// Route of administration.
  final DoseRoute? route;

  /// Eye side for ophthalmic sigs.
  final EyeSide? eye;

  /// Times per day.
  final int? perDay;

  /// Interval in hours (q6h → 6).
  final int? everyH;

  /// Schedule slots, in day order. Empty for PRN.
  final List<DoseSlot> slots;

  /// Whether this is "as needed".
  final bool prn;

  /// "max N/day" for PRN, as written.
  final int? prnMax;

  /// Timing relative to food.
  final FoodTiming? food;

  /// Duration in days, if stated.
  final int? days;

  /// Detected unsupported features and notation risks (A6.5).
  final Set<SigFlag> flags;

  /// Parser confidence in 0..1.
  final double conf;

  /// Whether the sig can be shown and scheduled (no unsupported flag).
  bool get isSupported => !flags.any((f) => f.isUnsupported);

  /// The first unsupported flag, used in `SIG_UNSUPPORTED:{code}` reasons.
  SigFlag? get firstUnsupported {
    for (final f in SigFlag.values) {
      if (f.isUnsupported && flags.contains(f)) return f;
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      other is ParsedSig &&
      other.raw == raw &&
      other.qty == qty &&
      other.unit == unit &&
      other.route == route &&
      other.eye == eye &&
      other.perDay == perDay &&
      other.everyH == everyH &&
      listEquals(other.slots, slots) &&
      other.prn == prn &&
      other.prnMax == prnMax &&
      other.food == food &&
      other.days == days &&
      setEquals(other.flags, flags) &&
      other.conf == conf;

  @override
  int get hashCode => Object.hash(
    raw,
    qty,
    unit,
    route,
    eye,
    perDay,
    everyH,
    Object.hashAll(slots),
    prn,
    prnMax,
    food,
    days,
    setHash(flags),
    conf,
  );

  /// A stable map form, used by fixtures and the server's `sigJson`.
  Map<String, Object?> toJson() => {
    'qty': qty,
    'unit': unit,
    'route': route?.name,
    'eye': eye?.name,
    'perDay': perDay,
    'everyH': everyH,
    'slots': [for (final s in slots) s.name],
    'prn': prn,
    'prnMax': prnMax,
    'food': food?.name,
    'days': days,
    'flags': [
      for (final f in SigFlag.values)
        if (flags.contains(f)) f.code,
    ],
  };

  @override
  String toString() => 'ParsedSig(${toJson()}, conf: $conf)';
}
