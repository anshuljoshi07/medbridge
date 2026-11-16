import 'package:med_core/src/domain/dose_form.dart';
import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/parsed_sig.dart';
import 'package:med_core/src/domain/strength.dart';
import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

/// One medicine line on the discharge plan.
@immutable
final class PlanItem {
  /// Creates a plan item.
  const PlanItem({
    required this.id,
    required this.action,
    required this.name,
    required this.ings,
    required this.form,
    required this.sigRaw,
    required this.src,
    required this.conf,
    this.rxcui,
    this.scd,
    this.strength,
    this.route,
    this.sig,
    this.holdUntil,
    this.holdNote,
    this.classIds = const {},
  });

  /// Stable id within the plan.
  final String id;

  /// What the plan says to do.
  final PlanAction action;

  /// Display name as written on the plan.
  final String name;

  /// RxNorm concept id, when resolved.
  final String? rxcui;

  /// Lower-case ingredient names (RxNorm IN/MIN): the primary match key.
  final Set<String> ings;

  /// RxNorm SCD id: the exact match key, when resolved.
  final String? scd;

  /// Strength, or `null` when the plan line has none.
  final Strength? strength;

  /// Dose form and release.
  final DoseForm form;

  /// Route of administration.
  final DoseRoute? route;

  /// Directions as written.
  final String sigRaw;

  /// Parsed directions.
  final ParsedSig? sig;

  /// Hold end date, for `hold` items.
  final DateTime? holdUntil;

  /// Hold condition in plain words ("until follow-up"), for `hold` items.
  final String? holdNote;

  /// The exact source line from the discharge papers.
  final String src;

  /// Extraction confidence in 0..1.
  final double conf;

  /// ATC level-4 class ids, prefetched (used for duplicate-class checks).
  final Set<String> classIds;

  /// Whether this item is still active on the plan (keep / change / start).
  bool get isActive =>
      action == PlanAction.keep ||
      action == PlanAction.change ||
      action == PlanAction.start;

  @override
  bool operator ==(Object other) =>
      other is PlanItem &&
      other.id == id &&
      other.action == action &&
      other.name == name &&
      other.rxcui == rxcui &&
      setEquals(other.ings, ings) &&
      other.scd == scd &&
      other.strength == strength &&
      other.form == form &&
      other.route == route &&
      other.sigRaw == sigRaw &&
      other.sig == sig &&
      other.holdUntil == holdUntil &&
      other.holdNote == holdNote &&
      other.src == src &&
      other.conf == conf &&
      setEquals(other.classIds, classIds);

  @override
  int get hashCode => Object.hash(
    id,
    action,
    name,
    rxcui,
    setHash(ings),
    scd,
    strength,
    form,
    route,
    sigRaw,
    sig,
    holdUntil,
    holdNote,
    src,
    conf,
    setHash(classIds),
  );

  @override
  String toString() => 'PlanItem($id ${action.name} $name $strength)';
}
