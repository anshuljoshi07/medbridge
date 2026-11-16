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

abstract class FlaggedScan
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  FlaggedScan._({
    required this.reconId,
    required this.patientId,
    required this.patientName,
    required this.scanName,
    required this.status,
    required this.reason,
    required this.sev,
    required this.createdAt,
    this.resolvedNote,
  });

  factory FlaggedScan({
    required int reconId,
    required int patientId,
    required String patientName,
    required String scanName,
    required String status,
    required String reason,
    required String sev,
    required DateTime createdAt,
    String? resolvedNote,
  }) = _FlaggedScanImpl;

  factory FlaggedScan.fromJson(Map<String, dynamic> jsonSerialization) {
    return FlaggedScan(
      reconId: jsonSerialization['reconId'] as int,
      patientId: jsonSerialization['patientId'] as int,
      patientName: jsonSerialization['patientName'] as String,
      scanName: jsonSerialization['scanName'] as String,
      status: jsonSerialization['status'] as String,
      reason: jsonSerialization['reason'] as String,
      sev: jsonSerialization['sev'] as String,
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      resolvedNote: jsonSerialization['resolvedNote'] as String?,
    );
  }

  int reconId;

  int patientId;

  String patientName;

  String scanName;

  String status;

  String reason;

  String sev;

  DateTime createdAt;

  String? resolvedNote;

  /// Returns a shallow copy of this [FlaggedScan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  FlaggedScan copyWith({
    int? reconId,
    int? patientId,
    String? patientName,
    String? scanName,
    String? status,
    String? reason,
    String? sev,
    DateTime? createdAt,
    String? resolvedNote,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FlaggedScan',
      'reconId': reconId,
      'patientId': patientId,
      'patientName': patientName,
      'scanName': scanName,
      'status': status,
      'reason': reason,
      'sev': sev,
      'createdAt': createdAt.toJson(),
      if (resolvedNote != null) 'resolvedNote': resolvedNote,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FlaggedScan',
      'reconId': reconId,
      'patientId': patientId,
      'patientName': patientName,
      'scanName': scanName,
      'status': status,
      'reason': reason,
      'sev': sev,
      'createdAt': createdAt.toJson(),
      if (resolvedNote != null) 'resolvedNote': resolvedNote,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FlaggedScanImpl extends FlaggedScan {
  _FlaggedScanImpl({
    required int reconId,
    required int patientId,
    required String patientName,
    required String scanName,
    required String status,
    required String reason,
    required String sev,
    required DateTime createdAt,
    String? resolvedNote,
  }) : super._(
         reconId: reconId,
         patientId: patientId,
         patientName: patientName,
         scanName: scanName,
         status: status,
         reason: reason,
         sev: sev,
         createdAt: createdAt,
         resolvedNote: resolvedNote,
       );

  /// Returns a shallow copy of this [FlaggedScan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  FlaggedScan copyWith({
    int? reconId,
    int? patientId,
    String? patientName,
    String? scanName,
    String? status,
    String? reason,
    String? sev,
    DateTime? createdAt,
    Object? resolvedNote = _Undefined,
  }) {
    return FlaggedScan(
      reconId: reconId ?? this.reconId,
      patientId: patientId ?? this.patientId,
      patientName: patientName ?? this.patientName,
      scanName: scanName ?? this.scanName,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      sev: sev ?? this.sev,
      createdAt: createdAt ?? this.createdAt,
      resolvedNote: resolvedNote is String? ? resolvedNote : this.resolvedNote,
    );
  }
}
