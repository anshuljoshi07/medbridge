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
import 'dose_state.dart' as _ivb9e1ub;

abstract class DoseEvent
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DoseEvent._({
    this.id,
    required this.scheduleId,
    required this.dueAt,
    required this.state,
    this.loggedAt,
  });

  factory DoseEvent({
    int? id,
    required int scheduleId,
    required DateTime dueAt,
    required _ivb9e1ub.DoseState state,
    DateTime? loggedAt,
  }) = _DoseEventImpl;

  factory DoseEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return DoseEvent(
      id: jsonSerialization['id'] as int?,
      scheduleId: jsonSerialization['scheduleId'] as int,
      dueAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      state: _ivb9e1ub.DoseState.fromJson(
        (jsonSerialization['state'] as String),
      ),
      loggedAt: jsonSerialization['loggedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['loggedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int scheduleId;

  DateTime dueAt;

  _ivb9e1ub.DoseState state;

  DateTime? loggedAt;

  /// Returns a shallow copy of this [DoseEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DoseEvent copyWith({
    int? id,
    int? scheduleId,
    DateTime? dueAt,
    _ivb9e1ub.DoseState? state,
    DateTime? loggedAt = const _isc.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DoseEvent',
      if (id != null) 'id': id,
      'scheduleId': scheduleId,
      'dueAt': dueAt.toJson(),
      'state': state.toJson(),
      if (loggedAt != null) 'loggedAt': loggedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DoseEvent',
      if (id != null) 'id': id,
      'scheduleId': scheduleId,
      'dueAt': dueAt.toJson(),
      'state': state.toJson(),
      if (loggedAt != null) 'loggedAt': loggedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DoseEventImpl extends DoseEvent {
  _DoseEventImpl({
    int? id,
    required int scheduleId,
    required DateTime dueAt,
    required _ivb9e1ub.DoseState state,
    DateTime? loggedAt,
  }) : super._(
         id: id,
         scheduleId: scheduleId,
         dueAt: dueAt,
         state: state,
         loggedAt: loggedAt,
       );

  /// Returns a shallow copy of this [DoseEvent]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DoseEvent copyWith({
    Object? id = _Undefined,
    int? scheduleId,
    DateTime? dueAt,
    _ivb9e1ub.DoseState? state,
    DateTime? loggedAt = const _isc.$UndefinedDateTime(),
  }) {
    return DoseEvent(
      id: id is int? ? id : this.id,
      scheduleId: scheduleId ?? this.scheduleId,
      dueAt: dueAt ?? this.dueAt,
      state: state ?? this.state,
      loggedAt: loggedAt is _isc.UndefinedSentinel ? this.loggedAt : loggedAt,
    );
  }
}
