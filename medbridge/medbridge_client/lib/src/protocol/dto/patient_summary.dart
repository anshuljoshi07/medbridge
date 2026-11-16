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

abstract class PatientSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PatientSummary._({
    required this.patientId,
    required this.firstName,
    this.birthYear,
    this.planId,
    this.planStatus,
    required this.redCount,
    required this.amberCount,
    required this.openQuestions,
    this.lastScanAt,
  });

  factory PatientSummary({
    required int patientId,
    required String firstName,
    int? birthYear,
    int? planId,
    String? planStatus,
    required int redCount,
    required int amberCount,
    required int openQuestions,
    DateTime? lastScanAt,
  }) = _PatientSummaryImpl;

  factory PatientSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return PatientSummary(
      patientId: jsonSerialization['patientId'] as int,
      firstName: jsonSerialization['firstName'] as String,
      birthYear: jsonSerialization['birthYear'] as int?,
      planId: jsonSerialization['planId'] as int?,
      planStatus: jsonSerialization['planStatus'] as String?,
      redCount: jsonSerialization['redCount'] as int,
      amberCount: jsonSerialization['amberCount'] as int,
      openQuestions: jsonSerialization['openQuestions'] as int,
      lastScanAt: jsonSerialization['lastScanAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastScanAt'],
            ),
    );
  }

  int patientId;

  String firstName;

  int? birthYear;

  int? planId;

  String? planStatus;

  int redCount;

  int amberCount;

  int openQuestions;

  DateTime? lastScanAt;

  /// Returns a shallow copy of this [PatientSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PatientSummary copyWith({
    int? patientId,
    String? firstName,
    int? birthYear,
    int? planId,
    String? planStatus,
    int? redCount,
    int? amberCount,
    int? openQuestions,
    DateTime? lastScanAt = const _isc.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PatientSummary',
      'patientId': patientId,
      'firstName': firstName,
      if (birthYear != null) 'birthYear': birthYear,
      if (planId != null) 'planId': planId,
      if (planStatus != null) 'planStatus': planStatus,
      'redCount': redCount,
      'amberCount': amberCount,
      'openQuestions': openQuestions,
      if (lastScanAt != null) 'lastScanAt': lastScanAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PatientSummary',
      'patientId': patientId,
      'firstName': firstName,
      if (birthYear != null) 'birthYear': birthYear,
      if (planId != null) 'planId': planId,
      if (planStatus != null) 'planStatus': planStatus,
      'redCount': redCount,
      'amberCount': amberCount,
      'openQuestions': openQuestions,
      if (lastScanAt != null) 'lastScanAt': lastScanAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PatientSummaryImpl extends PatientSummary {
  _PatientSummaryImpl({
    required int patientId,
    required String firstName,
    int? birthYear,
    int? planId,
    String? planStatus,
    required int redCount,
    required int amberCount,
    required int openQuestions,
    DateTime? lastScanAt,
  }) : super._(
         patientId: patientId,
         firstName: firstName,
         birthYear: birthYear,
         planId: planId,
         planStatus: planStatus,
         redCount: redCount,
         amberCount: amberCount,
         openQuestions: openQuestions,
         lastScanAt: lastScanAt,
       );

  /// Returns a shallow copy of this [PatientSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PatientSummary copyWith({
    int? patientId,
    String? firstName,
    Object? birthYear = _Undefined,
    Object? planId = _Undefined,
    Object? planStatus = _Undefined,
    int? redCount,
    int? amberCount,
    int? openQuestions,
    DateTime? lastScanAt = const _isc.$UndefinedDateTime(),
  }) {
    return PatientSummary(
      patientId: patientId ?? this.patientId,
      firstName: firstName ?? this.firstName,
      birthYear: birthYear is int? ? birthYear : this.birthYear,
      planId: planId is int? ? planId : this.planId,
      planStatus: planStatus is String? ? planStatus : this.planStatus,
      redCount: redCount ?? this.redCount,
      amberCount: amberCount ?? this.amberCount,
      openQuestions: openQuestions ?? this.openQuestions,
      lastScanAt: lastScanAt is _isc.UndefinedSentinel
          ? this.lastScanAt
          : lastScanAt,
    );
  }
}
