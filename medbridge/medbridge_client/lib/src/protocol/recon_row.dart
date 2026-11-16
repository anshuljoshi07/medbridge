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

abstract class ReconRow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReconRow._({
    this.id,
    required this.scanId,
    this.planItemId,
    this.itemKey,
    required this.status,
    required this.reason,
    required this.sev,
    String? flagsJson,
    String? paramsJson,
    required this.ruleVersion,
    this.resolvedNote,
    this.resolvedBy,
    DateTime? createdAt,
  }) : flagsJson = flagsJson ?? '[]',
       paramsJson = paramsJson ?? '{}',
       createdAt = createdAt ?? DateTime.now();

  factory ReconRow({
    int? id,
    required int scanId,
    int? planItemId,
    String? itemKey,
    required String status,
    required String reason,
    required String sev,
    String? flagsJson,
    String? paramsJson,
    required String ruleVersion,
    String? resolvedNote,
    _isc.UuidValue? resolvedBy,
    DateTime? createdAt,
  }) = _ReconRowImpl;

  factory ReconRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReconRow(
      id: jsonSerialization['id'] as int?,
      scanId: jsonSerialization['scanId'] as int,
      planItemId: jsonSerialization['planItemId'] as int?,
      itemKey: jsonSerialization['itemKey'] as String?,
      status: jsonSerialization['status'] as String,
      reason: jsonSerialization['reason'] as String,
      sev: jsonSerialization['sev'] as String,
      flagsJson: jsonSerialization['flagsJson'] as String?,
      paramsJson: jsonSerialization['paramsJson'] as String?,
      ruleVersion: jsonSerialization['ruleVersion'] as String,
      resolvedNote: jsonSerialization['resolvedNote'] as String?,
      resolvedBy: jsonSerialization['resolvedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['resolvedBy'],
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

  int scanId;

  int? planItemId;

  String? itemKey;

  String status;

  String reason;

  String sev;

  String flagsJson;

  String paramsJson;

  String ruleVersion;

  String? resolvedNote;

  _isc.UuidValue? resolvedBy;

  DateTime createdAt;

  /// Returns a shallow copy of this [ReconRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReconRow copyWith({
    int? id,
    int? scanId,
    int? planItemId,
    String? itemKey,
    String? status,
    String? reason,
    String? sev,
    String? flagsJson,
    String? paramsJson,
    String? ruleVersion,
    String? resolvedNote,
    _isc.UuidValue? resolvedBy = const _isc.$UndefinedUuidValue(),
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReconRow',
      if (id != null) 'id': id,
      'scanId': scanId,
      if (planItemId != null) 'planItemId': planItemId,
      if (itemKey != null) 'itemKey': itemKey,
      'status': status,
      'reason': reason,
      'sev': sev,
      'flagsJson': flagsJson,
      'paramsJson': paramsJson,
      'ruleVersion': ruleVersion,
      if (resolvedNote != null) 'resolvedNote': resolvedNote,
      if (resolvedBy != null) 'resolvedBy': resolvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReconRow',
      if (id != null) 'id': id,
      'scanId': scanId,
      if (planItemId != null) 'planItemId': planItemId,
      if (itemKey != null) 'itemKey': itemKey,
      'status': status,
      'reason': reason,
      'sev': sev,
      'flagsJson': flagsJson,
      'paramsJson': paramsJson,
      'ruleVersion': ruleVersion,
      if (resolvedNote != null) 'resolvedNote': resolvedNote,
      if (resolvedBy != null) 'resolvedBy': resolvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReconRowImpl extends ReconRow {
  _ReconRowImpl({
    int? id,
    required int scanId,
    int? planItemId,
    String? itemKey,
    required String status,
    required String reason,
    required String sev,
    String? flagsJson,
    String? paramsJson,
    required String ruleVersion,
    String? resolvedNote,
    _isc.UuidValue? resolvedBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         scanId: scanId,
         planItemId: planItemId,
         itemKey: itemKey,
         status: status,
         reason: reason,
         sev: sev,
         flagsJson: flagsJson,
         paramsJson: paramsJson,
         ruleVersion: ruleVersion,
         resolvedNote: resolvedNote,
         resolvedBy: resolvedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReconRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReconRow copyWith({
    Object? id = _Undefined,
    int? scanId,
    Object? planItemId = _Undefined,
    Object? itemKey = _Undefined,
    String? status,
    String? reason,
    String? sev,
    String? flagsJson,
    String? paramsJson,
    String? ruleVersion,
    Object? resolvedNote = _Undefined,
    _isc.UuidValue? resolvedBy = const _isc.$UndefinedUuidValue(),
    DateTime? createdAt,
  }) {
    return ReconRow(
      id: id is int? ? id : this.id,
      scanId: scanId ?? this.scanId,
      planItemId: planItemId is int? ? planItemId : this.planItemId,
      itemKey: itemKey is String? ? itemKey : this.itemKey,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      sev: sev ?? this.sev,
      flagsJson: flagsJson ?? this.flagsJson,
      paramsJson: paramsJson ?? this.paramsJson,
      ruleVersion: ruleVersion ?? this.ruleVersion,
      resolvedNote: resolvedNote is String? ? resolvedNote : this.resolvedNote,
      resolvedBy: resolvedBy is _isc.UndefinedSentinel
          ? this.resolvedBy
          : resolvedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
