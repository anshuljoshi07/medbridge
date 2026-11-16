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

abstract class Patient
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Patient._({
    this.id,
    required this.userId,
    String? firstName,
    String? lang,
    this.birthYear,
    int? utcOffsetMin,
    String? allergiesJson,
    DateTime? createdAt,
  }) : firstName = firstName ?? 'Patient',
       lang = lang ?? 'en',
       utcOffsetMin = utcOffsetMin ?? 0,
       allergiesJson = allergiesJson ?? '[]',
       createdAt = createdAt ?? DateTime.now();

  factory Patient({
    int? id,
    required _isc.UuidValue userId,
    String? firstName,
    String? lang,
    int? birthYear,
    int? utcOffsetMin,
    String? allergiesJson,
    DateTime? createdAt,
  }) = _PatientImpl;

  factory Patient.fromJson(Map<String, dynamic> jsonSerialization) {
    return Patient(
      id: jsonSerialization['id'] as int?,
      userId: _isc.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      firstName: jsonSerialization['firstName'] as String?,
      lang: jsonSerialization['lang'] as String?,
      birthYear: jsonSerialization['birthYear'] as int?,
      utcOffsetMin: jsonSerialization['utcOffsetMin'] as int?,
      allergiesJson: jsonSerialization['allergiesJson'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue userId;

  String firstName;

  String lang;

  int? birthYear;

  int utcOffsetMin;

  String allergiesJson;

  DateTime createdAt;

  /// Returns a shallow copy of this [Patient]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Patient copyWith({
    int? id,
    _isc.UuidValue? userId,
    String? firstName,
    String? lang,
    int? birthYear,
    int? utcOffsetMin,
    String? allergiesJson,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Patient',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'firstName': firstName,
      'lang': lang,
      if (birthYear != null) 'birthYear': birthYear,
      'utcOffsetMin': utcOffsetMin,
      'allergiesJson': allergiesJson,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Patient',
      if (id != null) 'id': id,
      'userId': userId.toJson(),
      'firstName': firstName,
      'lang': lang,
      if (birthYear != null) 'birthYear': birthYear,
      'utcOffsetMin': utcOffsetMin,
      'allergiesJson': allergiesJson,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PatientImpl extends Patient {
  _PatientImpl({
    int? id,
    required _isc.UuidValue userId,
    String? firstName,
    String? lang,
    int? birthYear,
    int? utcOffsetMin,
    String? allergiesJson,
    DateTime? createdAt,
  }) : super._(
         id: id,
         userId: userId,
         firstName: firstName,
         lang: lang,
         birthYear: birthYear,
         utcOffsetMin: utcOffsetMin,
         allergiesJson: allergiesJson,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Patient]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Patient copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? userId,
    String? firstName,
    String? lang,
    Object? birthYear = _Undefined,
    int? utcOffsetMin,
    String? allergiesJson,
    DateTime? createdAt,
  }) {
    return Patient(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lang: lang ?? this.lang,
      birthYear: birthYear is int? ? birthYear : this.birthYear,
      utcOffsetMin: utcOffsetMin ?? this.utcOffsetMin,
      allergiesJson: allergiesJson ?? this.allergiesJson,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
