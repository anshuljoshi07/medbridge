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
import 'package:medbridge_client/src/protocol/protocol.dart' as _iw3s9cgw;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dto/safety_flag_dto.dart' as _iuskbb01;

abstract class ReconOutcome
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReconOutcome._({
    required this.reconId,
    required this.scanId,
    required this.status,
    required this.reason,
    required this.sev,
    this.itemKey,
    required this.flags,
    required this.ruleVersion,
    required this.params,
    this.questionId,
    required this.needsAcknowledgment,
  });

  factory ReconOutcome({
    required int reconId,
    required int scanId,
    required String status,
    required String reason,
    required String sev,
    String? itemKey,
    required List<_iuskbb01.SafetyFlagDto> flags,
    required String ruleVersion,
    required Map<String, String> params,
    int? questionId,
    required bool needsAcknowledgment,
  }) = _ReconOutcomeImpl;

  factory ReconOutcome.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReconOutcome(
      reconId: jsonSerialization['reconId'] as int,
      scanId: jsonSerialization['scanId'] as int,
      status: jsonSerialization['status'] as String,
      reason: jsonSerialization['reason'] as String,
      sev: jsonSerialization['sev'] as String,
      itemKey: jsonSerialization['itemKey'] as String?,
      flags: _iw3s9cgw.Protocol().deserialize<List<_iuskbb01.SafetyFlagDto>>(
        jsonSerialization['flags'],
      ),
      ruleVersion: jsonSerialization['ruleVersion'] as String,
      params: _iw3s9cgw.Protocol().deserialize<Map<String, String>>(
        jsonSerialization['params'],
      ),
      questionId: jsonSerialization['questionId'] as int?,
      needsAcknowledgment: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['needsAcknowledgment'],
      ),
    );
  }

  int reconId;

  int scanId;

  String status;

  String reason;

  String sev;

  String? itemKey;

  List<_iuskbb01.SafetyFlagDto> flags;

  String ruleVersion;

  Map<String, String> params;

  int? questionId;

  bool needsAcknowledgment;

  /// Returns a shallow copy of this [ReconOutcome]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReconOutcome copyWith({
    int? reconId,
    int? scanId,
    String? status,
    String? reason,
    String? sev,
    String? itemKey,
    List<_iuskbb01.SafetyFlagDto>? flags,
    String? ruleVersion,
    Map<String, String>? params,
    int? questionId,
    bool? needsAcknowledgment,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReconOutcome',
      'reconId': reconId,
      'scanId': scanId,
      'status': status,
      'reason': reason,
      'sev': sev,
      if (itemKey != null) 'itemKey': itemKey,
      'flags': flags.toJson(valueToJson: (v) => v.toJson()),
      'ruleVersion': ruleVersion,
      'params': params.toJson(),
      if (questionId != null) 'questionId': questionId,
      'needsAcknowledgment': needsAcknowledgment,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReconOutcome',
      'reconId': reconId,
      'scanId': scanId,
      'status': status,
      'reason': reason,
      'sev': sev,
      if (itemKey != null) 'itemKey': itemKey,
      'flags': flags.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'ruleVersion': ruleVersion,
      'params': params.toJson(),
      if (questionId != null) 'questionId': questionId,
      'needsAcknowledgment': needsAcknowledgment,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReconOutcomeImpl extends ReconOutcome {
  _ReconOutcomeImpl({
    required int reconId,
    required int scanId,
    required String status,
    required String reason,
    required String sev,
    String? itemKey,
    required List<_iuskbb01.SafetyFlagDto> flags,
    required String ruleVersion,
    required Map<String, String> params,
    int? questionId,
    required bool needsAcknowledgment,
  }) : super._(
         reconId: reconId,
         scanId: scanId,
         status: status,
         reason: reason,
         sev: sev,
         itemKey: itemKey,
         flags: flags,
         ruleVersion: ruleVersion,
         params: params,
         questionId: questionId,
         needsAcknowledgment: needsAcknowledgment,
       );

  /// Returns a shallow copy of this [ReconOutcome]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReconOutcome copyWith({
    int? reconId,
    int? scanId,
    String? status,
    String? reason,
    String? sev,
    Object? itemKey = _Undefined,
    List<_iuskbb01.SafetyFlagDto>? flags,
    String? ruleVersion,
    Map<String, String>? params,
    Object? questionId = _Undefined,
    bool? needsAcknowledgment,
  }) {
    return ReconOutcome(
      reconId: reconId ?? this.reconId,
      scanId: scanId ?? this.scanId,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      sev: sev ?? this.sev,
      itemKey: itemKey is String? ? itemKey : this.itemKey,
      flags: flags ?? this.flags.map((e0) => e0.copyWith()).toList(),
      ruleVersion: ruleVersion ?? this.ruleVersion,
      params:
          params ??
          this.params.map(
            (
              key0,
              value0,
            ) => MapEntry(
              key0,
              value0,
            ),
          ),
      questionId: questionId is int? ? questionId : this.questionId,
      needsAcknowledgment: needsAcknowledgment ?? this.needsAcknowledgment,
    );
  }
}
