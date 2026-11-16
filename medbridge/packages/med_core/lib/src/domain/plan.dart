import 'package:med_core/src/domain/plan_item.dart';
import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

/// A patient's discharge medication plan.
@immutable
final class Plan {
  /// Creates a plan.
  const Plan({
    required this.id,
    required this.items,
    this.allergies = const {},
    this.verified = false,
  });

  /// Stable plan id.
  final String id;

  /// Plan lines, in source order.
  final List<PlanItem> items;

  /// Lower-case allergy terms: ingredient names or class group keys.
  final Set<String> allergies;

  /// Whether a pharmacist verified the plan.
  final bool verified;

  /// The item with [id], or `null`.
  PlanItem? itemById(String id) {
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  bool operator ==(Object other) =>
      other is Plan &&
      other.id == id &&
      listEquals(other.items, items) &&
      setEquals(other.allergies, allergies) &&
      other.verified == verified;

  @override
  int get hashCode =>
      Object.hash(id, Object.hashAll(items), setHash(allergies), verified);
}
