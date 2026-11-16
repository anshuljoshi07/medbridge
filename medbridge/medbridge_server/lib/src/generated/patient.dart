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

abstract class Patient
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
    required _is.UuidValue userId,
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
      userId: _is.UuidValueJsonExtension.fromJson(jsonSerialization['userId']),
      firstName: jsonSerialization['firstName'] as String?,
      lang: jsonSerialization['lang'] as String?,
      birthYear: jsonSerialization['birthYear'] as int?,
      utcOffsetMin: jsonSerialization['utcOffsetMin'] as int?,
      allergiesJson: jsonSerialization['allergiesJson'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PatientTable();

  static const db = PatientRepository._();

  @override
  int? id;

  _is.UuidValue userId;

  String firstName;

  String lang;

  int? birthYear;

  int utcOffsetMin;

  String allergiesJson;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Patient]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Patient copyWith({
    int? id,
    _is.UuidValue? userId,
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

  static PatientInclude include() {
    return PatientInclude._();
  }

  static PatientIncludeList includeList({
    _is.WhereExpressionBuilder<PatientTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    PatientInclude? include,
  }) {
    return PatientIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PatientImpl extends Patient {
  _PatientImpl({
    int? id,
    required _is.UuidValue userId,
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
  @_is.useResult
  @override
  Patient copyWith({
    Object? id = _Undefined,
    _is.UuidValue? userId,
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

class PatientUpdateTable extends _is.UpdateTable<PatientTable> {
  PatientUpdateTable(super.table);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> userId(_is.UuidValue value) =>
      _is.ColumnValue(
        table.userId,
        value,
      );

  _is.ColumnValue<String, String> firstName(String value) => _is.ColumnValue(
    table.firstName,
    value,
  );

  _is.ColumnValue<String, String> lang(String value) => _is.ColumnValue(
    table.lang,
    value,
  );

  _is.ColumnValue<int, int> birthYear(int? value) => _is.ColumnValue(
    table.birthYear,
    value,
  );

  _is.ColumnValue<int, int> utcOffsetMin(int value) => _is.ColumnValue(
    table.utcOffsetMin,
    value,
  );

  _is.ColumnValue<String, String> allergiesJson(String value) =>
      _is.ColumnValue(
        table.allergiesJson,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class PatientTable extends _is.Table<int?> {
  PatientTable({super.tableRelation}) : super(tableName: 'patient') {
    updateTable = PatientUpdateTable(this);
    userId = _is.ColumnUuid(
      'userId',
      this,
    );
    firstName = _is.ColumnString(
      'firstName',
      this,
      hasDefault: true,
    );
    lang = _is.ColumnString(
      'lang',
      this,
      hasDefault: true,
    );
    birthYear = _is.ColumnInt(
      'birthYear',
      this,
    );
    utcOffsetMin = _is.ColumnInt(
      'utcOffsetMin',
      this,
      hasDefault: true,
    );
    allergiesJson = _is.ColumnString(
      'allergiesJson',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final PatientUpdateTable updateTable;

  late final _is.ColumnUuid userId;

  late final _is.ColumnString firstName;

  late final _is.ColumnString lang;

  late final _is.ColumnInt birthYear;

  late final _is.ColumnInt utcOffsetMin;

  late final _is.ColumnString allergiesJson;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    firstName,
    lang,
    birthYear,
    utcOffsetMin,
    allergiesJson,
    createdAt,
  ];
}

class PatientInclude extends _is.IncludeObject {
  PatientInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Patient.t;
}

class PatientIncludeList extends _is.IncludeList {
  PatientIncludeList._({
    _is.WhereExpressionBuilder<PatientTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Patient.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Patient.t;
}

class PatientRepository {
  const PatientRepository._();

  /// Returns a list of [Patient]s matching the given query parameters.
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
  Future<List<Patient>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PatientTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Patient>(
      where: where?.call(Patient.t),
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Patient]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `Patient.t`.
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
  _ida.Stream<List<Patient>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PatientTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Patient>(
      where: where?.call(Patient.t),
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Patient] matching the given query parameters.
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
  Future<Patient?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PatientTable>? where,
    int? offset,
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Patient>(
      where: where?.call(Patient.t),
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Patient] by its [id] or null if no such row exists.
  Future<Patient?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Patient>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Patient]s in the list and returns the inserted rows.
  ///
  /// The returned [Patient]s will have their `id` fields set.
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
  Future<List<Patient>> insert(
    _is.DatabaseSession session,
    List<Patient> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Patient>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Patient] and returns the inserted row.
  ///
  /// The returned [Patient] will have its `id` field set.
  Future<Patient> insertRow(
    _is.DatabaseSession session,
    Patient row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Patient>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Patient]s in the list and returns the resulting rows.
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
  /// The returned [Patient]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Patient>> upsert(
    _is.DatabaseSession session,
    List<Patient> rows, {
    required _is.ColumnSelections<PatientTable> conflictColumns,
    _is.ColumnSelections<PatientTable>? updateColumns,
    _is.WhereExpressionBuilder<PatientTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Patient>(
      rows,
      conflictColumns: conflictColumns(Patient.t),
      updateColumns: updateColumns?.call(Patient.t),
      updateWhere: updateWhere?.call(Patient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Patient] and returns the resulting row.
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
  /// The returned [Patient] will have its `id` field set.
  Future<Patient?> upsertRow(
    _is.DatabaseSession session,
    Patient row, {
    required _is.ColumnSelections<PatientTable> conflictColumns,
    _is.ColumnSelections<PatientTable>? updateColumns,
    _is.WhereExpressionBuilder<PatientTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Patient>(
      row,
      conflictColumns: conflictColumns(Patient.t),
      updateColumns: updateColumns?.call(Patient.t),
      updateWhere: updateWhere?.call(Patient.t),
      transaction: transaction,
    );
  }

  /// Updates all [Patient]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Patient>> update(
    _is.DatabaseSession session,
    List<Patient> rows, {
    _is.ColumnSelections<PatientTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Patient>(
      rows,
      columns: columns?.call(Patient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Patient]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Patient> updateRow(
    _is.DatabaseSession session,
    Patient row, {
    _is.ColumnSelections<PatientTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Patient>(
      row,
      columns: columns?.call(Patient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Patient] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Patient?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PatientUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Patient>(
      id,
      columnValues: columnValues(Patient.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Patient]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Patient>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PatientUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PatientTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Patient>(
      columnValues: columnValues(Patient.t.updateTable),
      where: where(Patient.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Patient]s in the list and returns the deleted rows.
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
  Future<List<Patient>> delete(
    _is.DatabaseSession session,
    List<Patient> rows, {
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Patient>(
      rows,
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Patient].
  Future<Patient> deleteRow(
    _is.DatabaseSession session,
    Patient row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Patient>(
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
  Future<List<Patient>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PatientTable> where,
    _is.OrderByBuilder<PatientTable>? orderBy,
    _is.OrderByListBuilder<PatientTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Patient>(
      where: where(Patient.t),
      orderBy: orderBy?.call(Patient.t),
      orderByList: orderByList?.call(Patient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PatientTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Patient>(
      where: where?.call(Patient.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Patient] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PatientTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Patient>(
      where: where(Patient.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
