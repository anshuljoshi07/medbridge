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

abstract class Alert implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
      ackAt: jsonSerialization['ackAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['ackAt']),
    );
  }

  static final t = AlertTable();

  static const db = AlertRepository._();

  @override
  int? id;

  int patientId;

  String type;

  String sev;

  String dedupeKey;

  String recipientsJson;

  DateTime sentAt;

  DateTime? ackAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Alert]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Alert copyWith({
    int? id,
    int? patientId,
    String? type,
    String? sev,
    String? dedupeKey,
    String? recipientsJson,
    DateTime? sentAt,
    DateTime? ackAt = const _is.$UndefinedDateTime(),
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

  static AlertInclude include() {
    return AlertInclude._();
  }

  static AlertIncludeList includeList({
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    AlertInclude? include,
  }) {
    return AlertIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
  @override
  Alert copyWith({
    Object? id = _Undefined,
    int? patientId,
    String? type,
    String? sev,
    String? dedupeKey,
    String? recipientsJson,
    DateTime? sentAt,
    DateTime? ackAt = const _is.$UndefinedDateTime(),
  }) {
    return Alert(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      type: type ?? this.type,
      sev: sev ?? this.sev,
      dedupeKey: dedupeKey ?? this.dedupeKey,
      recipientsJson: recipientsJson ?? this.recipientsJson,
      sentAt: sentAt ?? this.sentAt,
      ackAt: ackAt is _is.UndefinedSentinel ? this.ackAt : ackAt,
    );
  }
}

class AlertUpdateTable extends _is.UpdateTable<AlertTable> {
  AlertUpdateTable(super.table);

  _is.ColumnValue<int, int> patientId(int value) => _is.ColumnValue(
    table.patientId,
    value,
  );

  _is.ColumnValue<String, String> type(String value) => _is.ColumnValue(
    table.type,
    value,
  );

  _is.ColumnValue<String, String> sev(String value) => _is.ColumnValue(
    table.sev,
    value,
  );

  _is.ColumnValue<String, String> dedupeKey(String value) => _is.ColumnValue(
    table.dedupeKey,
    value,
  );

  _is.ColumnValue<String, String> recipientsJson(String value) =>
      _is.ColumnValue(
        table.recipientsJson,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> sentAt(DateTime value) => _is.ColumnValue(
    table.sentAt,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> ackAt(DateTime? value) => _is.ColumnValue(
    table.ackAt,
    value,
  );
}

class AlertTable extends _is.Table<int?> {
  AlertTable({super.tableRelation}) : super(tableName: 'alert') {
    updateTable = AlertUpdateTable(this);
    patientId = _is.ColumnInt(
      'patientId',
      this,
    );
    type = _is.ColumnString(
      'type',
      this,
    );
    sev = _is.ColumnString(
      'sev',
      this,
    );
    dedupeKey = _is.ColumnString(
      'dedupeKey',
      this,
    );
    recipientsJson = _is.ColumnString(
      'recipientsJson',
      this,
    );
    sentAt = _is.ColumnDateTime(
      'sentAt',
      this,
      hasDefault: true,
    );
    ackAt = _is.ColumnDateTime(
      'ackAt',
      this,
    );
  }

  late final AlertUpdateTable updateTable;

  late final _is.ColumnInt patientId;

  late final _is.ColumnString type;

  late final _is.ColumnString sev;

  late final _is.ColumnString dedupeKey;

  late final _is.ColumnString recipientsJson;

  late final _is.ColumnDateTime sentAt;

  late final _is.ColumnDateTime ackAt;

  @override
  List<_is.Column> get columns => [
    id,
    patientId,
    type,
    sev,
    dedupeKey,
    recipientsJson,
    sentAt,
    ackAt,
  ];
}

class AlertInclude extends _is.IncludeObject {
  AlertInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Alert.t;
}

class AlertIncludeList extends _is.IncludeList {
  AlertIncludeList._({
    _is.WhereExpressionBuilder<AlertTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Alert.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Alert.t;
}

class AlertRepository {
  const AlertRepository._();

  /// Returns a list of [Alert]s matching the given query parameters.
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
  Future<List<Alert>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [Alert]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `Alert.t`.
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
  _ida.Stream<List<Alert>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [Alert] matching the given query parameters.
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
  Future<Alert?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Alert>(
      where: where?.call(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Alert] by its [id] or null if no such row exists.
  Future<Alert?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Alert>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Alert]s in the list and returns the inserted rows.
  ///
  /// The returned [Alert]s will have their `id` fields set.
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
  Future<List<Alert>> insert(
    _is.DatabaseSession session,
    List<Alert> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Alert>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Alert] and returns the inserted row.
  ///
  /// The returned [Alert] will have its `id` field set.
  Future<Alert> insertRow(
    _is.DatabaseSession session,
    Alert row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Alert>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [Alert]s in the list and returns the resulting rows.
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
  /// The returned [Alert]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Alert>> upsert(
    _is.DatabaseSession session,
    List<Alert> rows, {
    required _is.ColumnSelections<AlertTable> conflictColumns,
    _is.ColumnSelections<AlertTable>? updateColumns,
    _is.WhereExpressionBuilder<AlertTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Alert>(
      rows,
      conflictColumns: conflictColumns(Alert.t),
      updateColumns: updateColumns?.call(Alert.t),
      updateWhere: updateWhere?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Alert] and returns the resulting row.
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
  /// The returned [Alert] will have its `id` field set.
  Future<Alert?> upsertRow(
    _is.DatabaseSession session,
    Alert row, {
    required _is.ColumnSelections<AlertTable> conflictColumns,
    _is.ColumnSelections<AlertTable>? updateColumns,
    _is.WhereExpressionBuilder<AlertTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Alert>(
      row,
      conflictColumns: conflictColumns(Alert.t),
      updateColumns: updateColumns?.call(Alert.t),
      updateWhere: updateWhere?.call(Alert.t),
      transaction: transaction,
    );
  }

  /// Updates all [Alert]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Alert>> update(
    _is.DatabaseSession session,
    List<Alert> rows, {
    _is.ColumnSelections<AlertTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Alert>(
      rows,
      columns: columns?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Alert]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Alert> updateRow(
    _is.DatabaseSession session,
    Alert row, {
    _is.ColumnSelections<AlertTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Alert>(
      row,
      columns: columns?.call(Alert.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Alert] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Alert?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AlertUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Alert>(
      id,
      columnValues: columnValues(Alert.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Alert]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Alert>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AlertUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AlertTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Alert>(
      columnValues: columnValues(Alert.t.updateTable),
      where: where(Alert.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Alert]s in the list and returns the deleted rows.
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
  Future<List<Alert>> delete(
    _is.DatabaseSession session,
    List<Alert> rows, {
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Alert>(
      rows,
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Alert].
  Future<Alert> deleteRow(
    _is.DatabaseSession session,
    Alert row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Alert>(
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
  Future<List<Alert>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AlertTable> where,
    _is.OrderByBuilder<AlertTable>? orderBy,
    _is.OrderByListBuilder<AlertTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Alert>(
      where: where(Alert.t),
      orderBy: orderBy?.call(Alert.t),
      orderByList: orderByList?.call(Alert.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AlertTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Alert>(
      where: where?.call(Alert.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Alert] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AlertTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Alert>(
      where: where(Alert.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
