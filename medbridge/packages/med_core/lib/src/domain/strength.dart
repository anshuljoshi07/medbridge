import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

final _strengthPattern = RegExp(
  r'(\d*\.?\d+)(?:\s*[/-]\s*(\d*\.?\d+))?\s?(mg|mcg|µg|ug|g|ml|units?|iu|u|meq|%)(?![a-z])',
  caseSensitive: false,
);

/// A medicine strength such as `10 mg`, or `10 mg / 12.5 mg` for a
/// combination product (A6.3).
///
/// Unit conversion is for comparison only; never for dosing output.
@immutable
final class Strength {
  /// Creates a strength with canonical [unit] (`mg`, `mcg`, `g`, `mL`,
  /// `units`, `mEq`, `%`).
  const Strength(this.values, this.unit, {this.zeroRisk = false});

  /// One value per ingredient, in label order.
  final List<double> values;

  /// The canonical display unit.
  final String unit;

  /// Whether the source text had a trailing zero (`1.0 mg`) or a missing
  /// leading zero (`.5 mg`). Raises `ZERO_RISK` and forces confirmation.
  final bool zeroRisk;

  /// Finds the first strength in [text], or `null` if there is none. Total:
  /// never throws.
  static Strength? tryParse(String text) {
    final m = _strengthPattern.firstMatch(text);
    if (m == null) return null;
    final raw = [m.group(1)!, ?m.group(2)];
    final values = raw.map(double.tryParse).nonNulls.toList();
    if (values.isEmpty) return null;
    return Strength(
      values,
      _canonicalUnit(m.group(3)!),
      zeroRisk: raw.any(_isZeroRisk),
    );
  }

  static bool _isZeroRisk(String n) =>
      n.startsWith('.') || (n.contains('.') && n.endsWith('0'));

  static String _canonicalUnit(String u) => switch (u.toLowerCase()) {
    'mcg' || 'µg' || 'ug' => 'mcg',
    'ml' => 'mL',
    'unit' || 'units' || 'u' || 'iu' => 'units',
    'meq' => 'mEq',
    final other => other,
  };

  /// Mass units in micrograms, for comparison only.
  static const _mcgPerUnit = {'mcg': 1.0, 'mg': 1000.0, 'g': 1000000.0};

  /// Whether this and [other] are the same strength after unit conversion
  /// (1000 mcg == 1 mg).
  bool sameAs(Strength other) {
    if (values.length != other.values.length) return false;
    final a = _mcgPerUnit[unit];
    final b = _mcgPerUnit[other.unit];
    if ((a == null || b == null) && unit != other.unit) return false;
    for (var i = 0; i < values.length; i++) {
      final x = values[i] * (a ?? 1);
      final y = other.values[i] * (b ?? 1);
      if ((x - y).abs() > 1e-9 * (x.abs() + y.abs() + 1)) return false;
    }
    return true;
  }

  /// Safe display text: digits with a leading zero and no trailing zero, and
  /// `mcg` / `units` spelled out (never `µg` / `U`).
  String get display => values.map((v) => '${_num(v)} $unit').join(' / ');

  static String _num(double v) {
    if (v == v.roundToDouble()) return v.toInt().toString();
    var s = v.toString();
    if (s.startsWith('.')) s = '0$s';
    return s;
  }

  @override
  bool operator ==(Object other) =>
      other is Strength &&
      listEquals(other.values, values) &&
      other.unit == unit &&
      other.zeroRisk == zeroRisk;

  @override
  int get hashCode => Object.hash(Object.hashAll(values), unit, zeroRisk);

  @override
  String toString() => display;
}
