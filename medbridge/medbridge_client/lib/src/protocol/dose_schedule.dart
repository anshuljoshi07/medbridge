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

abstract class DoseSchedule
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DoseSchedule._({
    this.id,
    required this.planItemId,
    required this.slotsJson,
    required this.prn,
    bool? active,
    this.suspendedUntil,
  }) : active = active ?? true;

  factory DoseSchedule({
    int? id,
    required int planItemId,
    required String slotsJson,
    required bool prn,
    bool? active,
    DateTime? suspendedUntil,
  }) = _DoseScheduleImpl;

  factory DoseSchedule.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoseSchedule(
      id: jsonSerialization['id'] as int?,
      planItemId: jsonSerialization['planItemId'] as int,
      slotsJson: jsonSerialization['slotsJson'] as String,
      prn: _isc.BoolJsonExtension.fromJson(jsonSerialization['prn']),
      active: jsonSerialization['active'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['active']),
      suspendedUntil: jsonSerialization['suspendedUntil'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedUntil'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int planItemId;

  String slotsJson;

  bool prn;

  bool active;

  DateTime? suspendedUntil;

  /// Returns a shallow copy of this [DoseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DoseSchedule copyWith({
    int? id,
    int? planItemId,
    String? slotsJson,
    bool? prn,
    bool? active,
    DateTime? suspendedUntil = const _isc.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoseSchedule',
      if (id != null) 'id': id,
      'planItemId': planItemId,
      'slotsJson': slotsJson,
      'prn': prn,
      'active': active,
      if (suspendedUntil != null) 'suspendedUntil': suspendedUntil?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoseSchedule',
      if (id != null) 'id': id,
      'planItemId': planItemId,
      'slotsJson': slotsJson,
      'prn': prn,
      'active': active,
      if (suspendedUntil != null) 'suspendedUntil': suspendedUntil?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoseScheduleImpl extends DoseSchedule {
  _DoseScheduleImpl({
    int? id,
    required int planItemId,
    required String slotsJson,
    required bool prn,
    bool? active,
    DateTime? suspendedUntil,
  }) : super._(
         id: id,
         planItemId: planItemId,
         slotsJson: slotsJson,
         prn: prn,
         active: active,
         suspendedUntil: suspendedUntil,
       );

  /// Returns a shallow copy of this [DoseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DoseSchedule copyWith({
    Object? id = _Undefined,
    int? planItemId,
    String? slotsJson,
    bool? prn,
    bool? active,
    DateTime? suspendedUntil = const _isc.$UndefinedDateTime(),
  }) {
    return DoseSchedule(
      id: id is int? ? id : this.id,
      planItemId: planItemId ?? this.planItemId,
      slotsJson: slotsJson ?? this.slotsJson,
      prn: prn ?? this.prn,
      active: active ?? this.active,
      suspendedUntil: suspendedUntil is _isc.UndefinedSentinel
          ? this.suspendedUntil
          : suspendedUntil,
    );
  }
}
