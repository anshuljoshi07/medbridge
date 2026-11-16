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
import 'dart:async' as _ida;
import 'package:serverpod/serverpod.dart' as _is;
import 'question_status.dart' as _ixi4rbc4;

abstract class Question
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    _is.UuidValue? askedBy,
    _ixi4rbc4.QuestionStatus? status,
    String? answer,
    _is.UuidValue? answeredBy,
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
          : _is.UuidValueJsonExtension.fromJson(jsonSerialization['askedBy']),
      status: jsonSerialization['status'] == null
          ? null
          : _ixi4rbc4.QuestionStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      answer: jsonSerialization['answer'] as String?,
      answeredBy: jsonSerialization['answeredBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['answeredBy'],
            ),
      answeredAt: jsonSerialization['answeredAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['answeredAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = QuestionTable();

  static const db = QuestionRepository._();

  @override
  int? id;

  int patientId;

  String text;

  String source;

  int? linkedReconId;

  _is.UuidValue? askedBy;

  _ixi4rbc4.QuestionStatus status;

  String? answer;

  _is.UuidValue? answeredBy;

  DateTime? answeredAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Question copyWith({
    int? id,
    int? patientId,
    String? text,
    String? source,
    int? linkedReconId,
    _is.UuidValue? askedBy = const _is.$UndefinedUuidValue(),
    _ixi4rbc4.QuestionStatus? status,
    String? answer,
    _is.UuidValue? answeredBy = const _is.$UndefinedUuidValue(),
    DateTime? answeredAt = const _is.$UndefinedDateTime(),
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

  static QuestionInclude include() {
    return QuestionInclude._();
  }

  static QuestionIncludeList includeList({
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    QuestionInclude? include,
  }) {
    return QuestionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
    _is.UuidValue? askedBy,
    _ixi4rbc4.QuestionStatus? status,
    String? answer,
    _is.UuidValue? answeredBy,
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
  @_is.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? patientId,
    String? text,
    String? source,
    Object? linkedReconId = _Undefined,
    _is.UuidValue? askedBy = const _is.$UndefinedUuidValue(),
    _ixi4rbc4.QuestionStatus? status,
    Object? answer = _Undefined,
    _is.UuidValue? answeredBy = const _is.$UndefinedUuidValue(),
    DateTime? answeredAt = const _is.$UndefinedDateTime(),
    DateTime? createdAt,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      text: text ?? this.text,
      source: source ?? this.source,
      linkedReconId: linkedReconId is int? ? linkedReconId : this.linkedReconId,
      askedBy: askedBy is _is.UndefinedSentinel ? this.askedBy : askedBy,
      status: status ?? this.status,
      answer: answer is String? ? answer : this.answer,
      answeredBy: answeredBy is _is.UndefinedSentinel
          ? this.answeredBy
          : answeredBy,
      answeredAt: answeredAt is _is.UndefinedSentinel
          ? this.answeredAt
          : answeredAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class QuestionUpdateTable extends _is.UpdateTable<QuestionTable> {
  QuestionUpdateTable(super.table);

  _is.ColumnValue<int, int> patientId(int value) => _is.ColumnValue(
    table.patientId,
    value,
  );

  _is.ColumnValue<String, String> text(String value) => _is.ColumnValue(
    table.text,
    value,
  );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<int, int> linkedReconId(int? value) => _is.ColumnValue(
    table.linkedReconId,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> askedBy(_is.UuidValue? value) =>
      _is.ColumnValue(
        table.askedBy,
        value,
      );

  _is.ColumnValue<_ixi4rbc4.QuestionStatus, _ixi4rbc4.QuestionStatus> status(
    _ixi4rbc4.QuestionStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> answer(String? value) => _is.ColumnValue(
    table.answer,
    value,
  );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> answeredBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.answeredBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> answeredAt(DateTime? value) =>
      _is.ColumnValue(
        table.answeredAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class QuestionTable extends _is.Table<int?> {
  QuestionTable({super.tableRelation}) : super(tableName: 'question') {
    updateTable = QuestionUpdateTable(this);
    patientId = _is.ColumnInt(
      'patientId',
      this,
    );
    text = _is.ColumnString(
      'text',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
    );
    linkedReconId = _is.ColumnInt(
      'linkedReconId',
      this,
    );
    askedBy = _is.ColumnUuid(
      'askedBy',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    answer = _is.ColumnString(
      'answer',
      this,
    );
    answeredBy = _is.ColumnUuid(
      'answeredBy',
      this,
    );
    answeredAt = _is.ColumnDateTime(
      'answeredAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final QuestionUpdateTable updateTable;

  late final _is.ColumnInt patientId;

  late final _is.ColumnString text;

  late final _is.ColumnString source;

  late final _is.ColumnInt linkedReconId;

  late final _is.ColumnUuid askedBy;

  late final _is.ColumnEnum<_ixi4rbc4.QuestionStatus> status;

  late final _is.ColumnString answer;

  late final _is.ColumnUuid answeredBy;

  late final _is.ColumnDateTime answeredAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    patientId,
    text,
    source,
    linkedReconId,
    askedBy,
    status,
    answer,
    answeredBy,
    answeredAt,
    createdAt,
  ];
}

class QuestionInclude extends _is.IncludeObject {
  QuestionInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Question.t;
}

class QuestionIncludeList extends _is.IncludeList {
  QuestionIncludeList._({
    _is.WhereExpressionBuilder<QuestionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Question.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Question.t;
}

class QuestionRepository {
  const QuestionRepository._();

  /// Returns a list of [Question]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Question>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Question]s matching the given query parameters every time the
  /// source tables are modified.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// Use [throttle] to specify the minimum interval between queries. It can
  /// also be set to `null`, in which case the stream will only be throttled
  /// when its subscription is paused.
  ///
  /// Source tables are collected from the queried table, [where], [orderBy],
  /// [orderByList], and the [include] graph. [alsoTriggerOnTables] is added
  /// to that set. Pass [Table] instances such as `Question.t`.
  ///
  /// Raw [Expression] SQL is not inspected. Tables referenced only in raw
  /// SQL must be passed via [alsoTriggerOnTables].
  ///
  /// The stream always reads committed state and never joins an ambient
  /// [Transaction]. Emissions for a write fire after that write commits.
  ///
  /// Currently only supported on SQLite. Calling this method on PostgreSQL
  /// throws an [UnsupportedError].
  ///
  /// ```dart
  /// var subscription = Persons.db.watch(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// ).listen((persons) {
  ///   // Handle the latest matching rows.
  /// });
  /// ```
  _ida.Stream<List<Question>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Question] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Question?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Question>(
      where: where?.call(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Question] by its [id] or null if no such row exists.
  Future<Question?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Question>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Question]s in the list and returns the inserted rows.
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> insert(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Question>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Question] and returns the inserted row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question> insertRow(
    _is.DatabaseSession session,
    Question row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Question]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Question]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> upsert(
    _is.DatabaseSession session,
    List<Question> rows, {
    required _is.ColumnSelections<QuestionTable> conflictColumns,
    _is.ColumnSelections<QuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuestionTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Question>(
      rows,
      conflictColumns: conflictColumns(Question.t),
      updateColumns: updateColumns?.call(Question.t),
      updateWhere: updateWhere?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Question] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Question] will have its `id` field set.
  Future<Question?> upsertRow(
    _is.DatabaseSession session,
    Question row, {
    required _is.ColumnSelections<QuestionTable> conflictColumns,
    _is.ColumnSelections<QuestionTable>? updateColumns,
    _is.WhereExpressionBuilder<QuestionTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Question>(
      row,
      conflictColumns: conflictColumns(Question.t),
      updateColumns: updateColumns?.call(Question.t),
      updateWhere: updateWhere?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> update(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.ColumnSelections<QuestionTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Question>(
      rows,
      columns: columns?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Question]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Question> updateRow(
    _is.DatabaseSession session,
    Question row, {
    _is.ColumnSelections<QuestionTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Question>(
      row,
      columns: columns?.call(Question.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Question] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Question?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Question>(
      id,
      columnValues: columnValues(Question.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Question]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QuestionUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QuestionTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Question>(
      columnValues: columnValues(Question.t.updateTable),
      where: where(Question.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Question]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> delete(
    _is.DatabaseSession session,
    List<Question> rows, {
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Question>(
      rows,
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Question].
  Future<Question> deleteRow(
    _is.DatabaseSession session,
    Question row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Question>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Question>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuestionTable> where,
    _is.OrderByBuilder<QuestionTable>? orderBy,
    _is.OrderByListBuilder<QuestionTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Question>(
      where: where(Question.t),
      orderBy: orderBy?.call(Question.t),
      orderByList: orderByList?.call(Question.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QuestionTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Question>(
      where: where?.call(Question.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Question] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QuestionTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Question>(
      where: where(Question.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
