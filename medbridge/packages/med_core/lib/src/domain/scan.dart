import 'package:med_core/src/domain/dose_form.dart';
import 'package:med_core/src/domain/parsed_sig.dart';
import 'package:med_core/src/domain/strength.dart';
import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

/// A confirmed (or not) bottle scan, with class data prefetched so that
/// reconciliation stays pure.
@immutable
final class Scan {
  /// Creates a scan.
  const Scan({
    required this.name,
    required this.ings,
    required this.form,
    required this.conf,
    required this.confirmed,
    this.ndc11,
    this.rxcui,
    this.scd,
    this.strength,
    this.sigRaw = '',
    this.sig,
    this.classIds = const {},
    this.groupIds = const {},
  });

  /// Normalized 11-digit NDC, when read from a barcode.
  final String? ndc11;

  /// RxNorm concept id, when resolved.
  final String? rxcui;

  /// Display name as read.
  final String name;

  /// Lower-case ingredient names.
  final Set<String> ings;

  /// RxNorm SCD id, when resolved.
  final String? scd;

  /// Strength, or `null` when not read.
  final Strength? strength;

  /// Dose form and release.
  final DoseForm form;

  /// Directions as read from the label.
  final String sigRaw;

  /// Parsed label directions.
  final ParsedSig? sig;

  /// Read confidence in 0..1 (A7.3).
  final double conf;

  /// Whether the patient tapped "Yes, this is my medicine".
  final bool confirmed;

  /// ATC level-4 class ids from RxClass.
  final Set<String> classIds;

  /// Extra curated group keys beyond those derived from [classIds].
  final Set<String> groupIds;

  @override
  bool operator ==(Object other) =>
      other is Scan &&
      other.ndc11 == ndc11 &&
      other.rxcui == rxcui &&
      other.name == name &&
      setEquals(other.ings, ings) &&
      other.scd == scd &&
      other.strength == strength &&
      other.form == form &&
      other.sigRaw == sigRaw &&
      other.sig == sig &&
      other.conf == conf &&
      other.confirmed == confirmed &&
      setEquals(other.classIds, classIds) &&
      setEquals(other.groupIds, groupIds);

  @override
  int get hashCode => Object.hash(
    ndc11,
    rxcui,
    name,
    setHash(ings),
    scd,
    strength,
    form,
    sigRaw,
    sig,
    conf,
    confirmed,
    setHash(classIds),
    setHash(groupIds),
  );

  @override
  String toString() => 'Scan($name $strength conf=$conf)';
}
