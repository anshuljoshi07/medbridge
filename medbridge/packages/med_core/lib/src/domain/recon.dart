import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/util/value_equality.dart';
import 'package:meta/meta.dart';

/// A safety overlay hit (A8.3).
@immutable
final class SafetyFlag {
  /// Creates a safety flag.
  const SafetyFlag(this.kind, this.sev, this.code, {this.detail = ''});

  /// Which check fired.
  final SafetyKind kind;

  /// The severity this check raises the result to.
  final Severity sev;

  /// Stable code, e.g. `DDI:ibuprofen+warfarin`, `ALLERGY:penicillin`.
  final String code;

  /// Short plain-language detail, e.g. "bleeding risk".
  final String detail;

  @override
  bool operator ==(Object other) =>
      other is SafetyFlag &&
      other.kind == kind &&
      other.sev == sev &&
      other.code == code &&
      other.detail == detail;

  @override
  int get hashCode => Object.hash(kind, sev, code, detail);

  @override
  String toString() => 'SafetyFlag($code, ${sev.name})';
}

/// The result of reconciling one bottle against the plan (A8.2).
@immutable
final class ReconResult {
  /// Creates a result.
  const ReconResult({
    required this.status,
    required this.reason,
    required this.sev,
    required this.ruleVersion,
    this.itemId,
    this.flags = const [],
    this.params = const {},
  });

  /// The status shown to the patient.
  final ReconStatus status;

  /// Stable reason code, e.g. `PLAN_STOP`, `SAME_CLASS_AS:{itemId}`.
  final String reason;

  /// Final severity after overlays.
  final Severity sev;

  /// The matched plan item, if any.
  final String? itemId;

  /// Safety overlay hits.
  final List<SafetyFlag> flags;

  /// The rule-set version that produced this result (A8.4 #5).
  final String ruleVersion;

  /// Template parameters for the patient message: `sig`, `date`, `planMed`.
  /// Plain-language strings only; never a computed dose.
  final Map<String, String> params;

  /// Whether this result raises a dashboard flag: every red result.
  bool get createsFlag => sev == Severity.red;

  /// Whether this result auto-creates a Question (A8.4 #4, F6).
  bool get createsQuestion =>
      createsFlag ||
      status == ReconStatus.unknown ||
      flags.any((f) => f.kind == SafetyKind.interaction);

  /// Whether the patient must tap an explicit acknowledgment (A13.2 #5).
  bool get needsAcknowledgment =>
      status == ReconStatus.stop || status == ReconStatus.duplicate;

  /// The reason code without its `:{detail}` suffix.
  String get reasonCode => reason.split(':').first;

  /// A copy with overlay [extra] flags merged and severity raised (never
  /// lowered) to the highest flag.
  ReconResult withFlags(List<SafetyFlag> extra) {
    var s = sev;
    for (final f in extra) {
      s = s.atLeast(f.sev);
    }
    return ReconResult(
      status: status,
      reason: reason,
      sev: s,
      ruleVersion: ruleVersion,
      itemId: itemId,
      flags: [...flags, ...extra],
      params: params,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ReconResult &&
      other.status == status &&
      other.reason == reason &&
      other.sev == sev &&
      other.itemId == itemId &&
      listEquals(other.flags, flags) &&
      other.ruleVersion == ruleVersion &&
      mapEquals(other.params, params);

  @override
  int get hashCode => Object.hash(
    status,
    reason,
    sev,
    itemId,
    Object.hashAll(flags),
    ruleVersion,
    Object.hashAll(params.entries.map((e) => Object.hash(e.key, e.value))),
  );

  @override
  String toString() =>
      'ReconResult(${status.name}, $reason, ${sev.name}, item: $itemId)';
}
