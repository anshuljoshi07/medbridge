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
import 'care_role.dart' as _ipgwqulm;
import 'link_status.dart' as _i1hij6nc;

abstract class CareLink
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CareLink._({
    this.id,
    required this.patientId,
    this.userId,
    required this.role,
    _i1hij6nc.LinkStatus? status,
    required this.inviteCode,
    DateTime? createdAt,
  }) : status = status ?? _i1hij6nc.LinkStatus.pending,
       createdAt = createdAt ?? DateTime.now();

  factory CareLink({
    int? id,
    required int patientId,
    _isc.UuidValue? userId,
    required _ipgwqulm.CareRole role,
    _i1hij6nc.LinkStatus? status,
    required String inviteCode,
    DateTime? createdAt,
  }) = _CareLinkImpl;

  factory CareLink.fromJson(Map<String, dynamic> jsonSerialization) {
    return CareLink(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      userId: jsonSerialization['userId'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      role: _ipgwqulm.CareRole.fromJson((jsonSerialization['role'] as String)),
      status: jsonSerialization['status'] == null
          ? null
          : _i1hij6nc.LinkStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      inviteCode: jsonSerialization['inviteCode'] as String,
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

  _isc.UuidValue? userId;

  _ipgwqulm.CareRole role;

  _i1hij6nc.LinkStatus status;

  String inviteCode;

  DateTime createdAt;

  /// Returns a shallow copy of this [CareLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CareLink copyWith({
    int? id,
    int? patientId,
    _isc.UuidValue? userId = const _isc.$UndefinedUuidValue(),
    _ipgwqulm.CareRole? role,
    _i1hij6nc.LinkStatus? status,
    String? inviteCode,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CareLink',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (userId != null) 'userId': userId?.toJson(),
      'role': role.toJson(),
      'status': status.toJson(),
      'inviteCode': inviteCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CareLink',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (userId != null) 'userId': userId?.toJson(),
      'role': role.toJson(),
      'status': status.toJson(),
      'inviteCode': inviteCode,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CareLinkImpl extends CareLink {
  _CareLinkImpl({
    int? id,
    required int patientId,
    _isc.UuidValue? userId,
    required _ipgwqulm.CareRole role,
    _i1hij6nc.LinkStatus? status,
    required String inviteCode,
    DateTime? createdAt,
  }) : super._(
         id: id,
         patientId: patientId,
         userId: userId,
         role: role,
         status: status,
         inviteCode: inviteCode,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [CareLink]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CareLink copyWith({
    Object? id = _Undefined,
    int? patientId,
    _isc.UuidValue? userId = const _isc.$UndefinedUuidValue(),
    _ipgwqulm.CareRole? role,
    _i1hij6nc.LinkStatus? status,
    String? inviteCode,
    DateTime? createdAt,
  }) {
    return CareLink(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      userId: userId is _isc.UndefinedSentinel ? this.userId : userId,
      role: role ?? this.role,
      status: status ?? this.status,
      inviteCode: inviteCode ?? this.inviteCode,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
