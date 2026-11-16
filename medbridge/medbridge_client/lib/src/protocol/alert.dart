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

abstract class Alert
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Alert._({
    this.id,
    required this.patientId,
    required this.type,
    required this.sev,
    required this.dedupeKey,
    required this.recipientsJson,
    DateTime? sentAt,
    this.ackAt,
  }) : sentAt = sentAt ?? DateTime.now();

  factory Alert({
    int? id,
    required int patientId,
    required String type,
    required String sev,
    required String dedupeKey,
    required String recipientsJson,
    DateTime? sentAt,
    DateTime? ackAt,
  }) = _AlertImpl;

  factory Alert.fromJson(Map<String, dynamic> jsonSerialization) {
    return Alert(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      type: jsonSerialization['type'] as String,
      sev: jsonSerialization['sev'] as String,
      dedupeKey: jsonSerialization['dedupeKey'] as String,
      recipientsJson: jsonSerialization['recipientsJson'] as String,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      ackAt: jsonSerialization['ackAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['ackAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int patientId;

  String type;

  String sev;

  String dedupeKey;

  String recipientsJson;

  DateTime sentAt;

  DateTime? ackAt;

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Alert copyWith({
    int? id,
    int? patientId,
    String? type,
    String? sev,
    String? dedupeKey,
    String? recipientsJson,
    DateTime? sentAt,
    DateTime? ackAt = const _isc.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'patientId': patientId,
      'type': type,
      'sev': sev,
      'dedupeKey': dedupeKey,
      'recipientsJson': recipientsJson,
      'sentAt': sentAt.toJson(),
      if (ackAt != null) 'ackAt': ackAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Alert',
      if (id != null) 'id': id,
      'patientId': patientId,
      'type': type,
      'sev': sev,
      'dedupeKey': dedupeKey,
      'recipientsJson': recipientsJson,
      'sentAt': sentAt.toJson(),
      if (ackAt != null) 'ackAt': ackAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AlertImpl extends Alert {
  _AlertImpl({
    int? id,
    required int patientId,
    required String type,
    required String sev,
    required String dedupeKey,
    required String recipientsJson,
    DateTime? sentAt,
    DateTime? ackAt,
  }) : super._(
         id: id,
         patientId: patientId,
         type: type,
         sev: sev,
         dedupeKey: dedupeKey,
         recipientsJson: recipientsJson,
         sentAt: sentAt,
         ackAt: ackAt,
       );

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Alert copyWith({
    Object? id = _Undefined,
    int? patientId,
    String? type,
    String? sev,
    String? dedupeKey,
    String? recipientsJson,
    DateTime? sentAt,
    DateTime? ackAt = const _isc.$UndefinedDateTime(),
  }) {
    return Alert(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      type: type ?? this.type,
      sev: sev ?? this.sev,
      dedupeKey: dedupeKey ?? this.dedupeKey,
      recipientsJson: recipientsJson ?? this.recipientsJson,
      sentAt: sentAt ?? this.sentAt,
      ackAt: ackAt is _isc.UndefinedSentinel ? this.ackAt : ackAt,
    );
  }
}
