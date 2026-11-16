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
import 'question_status.dart' as _ixi4rbc4;

abstract class Question
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Question._({
    this.id,
    required this.patientId,
    required this.text,
    required this.source,
    this.linkedReconId,
    this.askedBy,
    _ixi4rbc4.QuestionStatus? status,
    this.answer,
    this.answeredBy,
    this.answeredAt,
    DateTime? createdAt,
  }) : status = status ?? _ixi4rbc4.QuestionStatus.open,
       createdAt = createdAt ?? DateTime.now();

  factory Question({
    int? id,
    required int patientId,
    required String text,
    required String source,
    int? linkedReconId,
    _isc.UuidValue? askedBy,
    _ixi4rbc4.QuestionStatus? status,
    String? answer,
    _isc.UuidValue? answeredBy,
    DateTime? answeredAt,
    DateTime? createdAt,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      text: jsonSerialization['text'] as String,
      source: jsonSerialization['source'] as String,
      linkedReconId: jsonSerialization['linkedReconId'] as int?,
      askedBy: jsonSerialization['askedBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(jsonSerialization['askedBy']),
      status: jsonSerialization['status'] == null
          ? null
          : _ixi4rbc4.QuestionStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      answer: jsonSerialization['answer'] as String?,
      answeredBy: jsonSerialization['answeredBy'] == null
          ? null
          : _isc.UuidValueJsonExtension.fromJson(
              jsonSerialization['answeredBy'],
            ),
      answeredAt: jsonSerialization['answeredAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['answeredAt'],
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

  String text;

  String source;

  int? linkedReconId;

  _isc.UuidValue? askedBy;

  _ixi4rbc4.QuestionStatus status;

  String? answer;

  _isc.UuidValue? answeredBy;

  DateTime? answeredAt;

  DateTime createdAt;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Question copyWith({
    int? id,
    int? patientId,
    String? text,
    String? source,
    int? linkedReconId,
    _isc.UuidValue? askedBy = const _isc.$UndefinedUuidValue(),
    _ixi4rbc4.QuestionStatus? status,
    String? answer,
    _isc.UuidValue? answeredBy = const _isc.$UndefinedUuidValue(),
    DateTime? answeredAt = const _isc.$UndefinedDateTime(),
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'patientId': patientId,
      'text': text,
      'source': source,
      if (linkedReconId != null) 'linkedReconId': linkedReconId,
      if (askedBy != null) 'askedBy': askedBy?.toJson(),
      'status': status.toJson(),
      if (answer != null) 'answer': answer,
      if (answeredBy != null) 'answeredBy': answeredBy?.toJson(),
      if (answeredAt != null) 'answeredAt': answeredAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'patientId': patientId,
      'text': text,
      'source': source,
      if (linkedReconId != null) 'linkedReconId': linkedReconId,
      if (askedBy != null) 'askedBy': askedBy?.toJson(),
      'status': status.toJson(),
      if (answer != null) 'answer': answer,
      if (answeredBy != null) 'answeredBy': answeredBy?.toJson(),
      if (answeredAt != null) 'answeredAt': answeredAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int patientId,
    required String text,
    required String source,
    int? linkedReconId,
    _isc.UuidValue? askedBy,
    _ixi4rbc4.QuestionStatus? status,
    String? answer,
    _isc.UuidValue? answeredBy,
    DateTime? answeredAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         patientId: patientId,
         text: text,
         source: source,
         linkedReconId: linkedReconId,
         askedBy: askedBy,
         status: status,
         answer: answer,
         answeredBy: answeredBy,
         answeredAt: answeredAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? patientId,
    String? text,
    String? source,
    Object? linkedReconId = _Undefined,
    _isc.UuidValue? askedBy = const _isc.$UndefinedUuidValue(),
    _ixi4rbc4.QuestionStatus? status,
    Object? answer = _Undefined,
    _isc.UuidValue? answeredBy = const _isc.$UndefinedUuidValue(),
    DateTime? answeredAt = const _isc.$UndefinedDateTime(),
    DateTime? createdAt,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      text: text ?? this.text,
      source: source ?? this.source,
      linkedReconId: linkedReconId is int? ? linkedReconId : this.linkedReconId,
      askedBy: askedBy is _isc.UndefinedSentinel ? this.askedBy : askedBy,
      status: status ?? this.status,
      answer: answer is String? ? answer : this.answer,
      answeredBy: answeredBy is _isc.UndefinedSentinel
          ? this.answeredBy
          : answeredBy,
      answeredAt: answeredAt is _isc.UndefinedSentinel
          ? this.answeredAt
          : answeredAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
