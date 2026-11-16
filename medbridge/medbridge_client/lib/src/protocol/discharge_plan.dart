/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'plan_status.dart' as _iqzysob1;

abstract class DischargePlan
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DischargePlan._({
    this.id,
    required this.patientId,
    String? source,
    this.dischargeDate,
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    this.verifiedBy,
    this.verifiedAt,
    DateTime? createdAt,
  }) : source = source ?? 'avs_scan',
       status = status ?? _iqzysob1.PlanStatus.draft,
       allergiesJson = allergiesJson ?? '[]',
       unrecognizedJson = unrecognizedJson ?? '[]',
       createdAt = createdAt ?? DateTime.now();

  factory DischargePlan({
    int? id,
    required int patientId,
    String? source,
    DateTime? dischargeDate,
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _isc.UuidValue? verifiedBy,
    DateTime? verifiedAt,
    DateTime? createdAt,
  }) = _DischargePlanImpl;

  factory DischargePlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return DischargePlan(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      source: jsonSerialization['source'] as String?,
      dischargeDate: jsonSerialization['dischargeDate'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['dischargeDate'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _iqzysob1.PlanStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      allergiesJson: jsonSerialization['allergiesJson'] as String?,
      unrecognizedJson: jsonSerialization['unrecognizedJson'] as String?,
      verifiedBy: jsonSerialization['verifiedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['verifiedBy'],
            ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['verifiedAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int patientId;

  String source;

  DateTime? dischargeDate;

  _iqzysob1.PlanStatus status;

  String allergiesJson;

  String unrecognizedJson;

  _isc.UuidValue? verifiedBy;

  DateTime? verifiedAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [DischargePlan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DischargePlan copyWith({
    int? id,
    int? patientId,
    String? source,
    DateTime? dischargeDate = const _isc.$UndefinedDateTime(),
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _isc.UuidValue? verifiedBy = const _isc.$UndefinedUuidValue(),
    DateTime? verifiedAt = const _isc.$UndefinedDateTime(),
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DischargePlan',
      if (id != null) 'id': id,
      'patientId': patientId,
      'source': source,
      if (dischargeDate != null) 'dischargeDate': dischargeDate?.toJson(),
      'status': status.toJson(),
      'allergiesJson': allergiesJson,
      'unrecognizedJson': unrecognizedJson,
      if (verifiedBy != null) 'verifiedBy': verifiedBy?.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DischargePlan',
      if (id != null) 'id': id,
      'patientId': patientId,
      'source': source,
      if (dischargeDate != null) 'dischargeDate': dischargeDate?.toJson(),
      'status': status.toJson(),
      'allergiesJson': allergiesJson,
      'unrecognizedJson': unrecognizedJson,
      if (verifiedBy != null) 'verifiedBy': verifiedBy?.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DischargePlanImpl extends DischargePlan {
  _DischargePlanImpl({
    int? id,
    required int patientId,
    String? source,
    DateTime? dischargeDate,
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _isc.UuidValue? verifiedBy,
    DateTime? verifiedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         patientId: patientId,
         source: source,
         dischargeDate: dischargeDate,
         status: status,
         allergiesJson: allergiesJson,
         unrecognizedJson: unrecognizedJson,
         verifiedBy: verifiedBy,
         verifiedAt: verifiedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DischargePlan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DischargePlan copyWith({
    Object? id = _Undefined,
    int? patientId,
    String? source,
    DateTime? dischargeDate = const _isc.$UndefinedDateTime(),
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _isc.UuidValue? verifiedBy = const _isc.$UndefinedUuidValue(),
    DateTime? verifiedAt = const _isc.$UndefinedDateTime(),
    DateTime? createdAt,
  }) {
    return DischargePlan(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      source: source ?? this.source,
      dischargeDate: dischargeDate is _isc.UndefinedSentinel
          ? this.dischargeDate
          : dischargeDate,
      status: status ?? this.status,
      allergiesJson: allergiesJson ?? this.allergiesJson,
      unrecognizedJson: unrecognizedJson ?? this.unrecognizedJson,
      verifiedBy: verifiedBy is _isc.UndefinedSentinel
          ? this.verifiedBy
          : verifiedBy,
      verifiedAt: verifiedAt is _isc.UndefinedSentinel
          ? this.verifiedAt
          : verifiedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
