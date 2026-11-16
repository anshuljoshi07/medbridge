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

abstract class ReconRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ReconRow._({
    this.id,
    required this.scanId,
    this.planItemId,
    this.itemKey,
    required this.status,
    required this.reason,
    required this.sev,
    String? flagsJson,
    String? paramsJson,
    required this.ruleVersion,
    this.resolvedNote,
    this.resolvedBy,
    DateTime? createdAt,
  }) : flagsJson = flagsJson ?? '[]',
       paramsJson = paramsJson ?? '{}',
       createdAt = createdAt ?? DateTime.now();

  factory ReconRow({
    int? id,
    required int scanId,
    int? planItemId,
    String? itemKey,
    required String status,
    required String reason,
    required String sev,
    String? flagsJson,
    String? paramsJson,
    required String ruleVersion,
    String? resolvedNote,
    _is.UuidValue? resolvedBy,
    DateTime? createdAt,
  }) = _ReconRowImpl;

  factory ReconRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReconRow(
      id: jsonSerialization['id'] as int?,
      scanId: jsonSerialization['scanId'] as int,
      planItemId: jsonSerialization['planItemId'] as int?,
      itemKey: jsonSerialization['itemKey'] as String?,
      status: jsonSerialization['status'] as String,
      reason: jsonSerialization['reason'] as String,
      sev: jsonSerialization['sev'] as String,
      flagsJson: jsonSerialization['flagsJson'] as String?,
      paramsJson: jsonSerialization['paramsJson'] as String?,
      ruleVersion: jsonSerialization['ruleVersion'] as String,
      resolvedNote: jsonSerialization['resolvedNote'] as String?,
      resolvedBy: jsonSerialization['resolvedBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['resolvedBy'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = ReconRowTable();

  static const db = ReconRowRepository._();

  @override
  int? id;

  int scanId;

  int? planItemId;

  String? itemKey;

  String status;

  String reason;

  String sev;

  String flagsJson;

  String paramsJson;

  String ruleVersion;

  String? resolvedNote;

  _is.UuidValue? resolvedBy;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ReconRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReconRow copyWith({
    int? id,
    int? scanId,
    int? planItemId,
    String? itemKey,
    String? status,
    String? reason,
    String? sev,
    String? flagsJson,
    String? paramsJson,
    String? ruleVersion,
    String? resolvedNote,
    _is.UuidValue? resolvedBy = const _is.$UndefinedUuidValue(),
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReconRow',
      if (id != null) 'id': id,
      'scanId': scanId,
      if (planItemId != null) 'planItemId': planItemId,
      if (itemKey != null) 'itemKey': itemKey,
      'status': status,
      'reason': reason,
      'sev': sev,
      'flagsJson': flagsJson,
      'paramsJson': paramsJson,
      'ruleVersion': ruleVersion,
      if (resolvedNote != null) 'resolvedNote': resolvedNote,
      if (resolvedBy != null) 'resolvedBy': resolvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReconRow',
      if (id != null) 'id': id,
      'scanId': scanId,
      if (planItemId != null) 'planItemId': planItemId,
      if (itemKey != null) 'itemKey': itemKey,
      'status': status,
      'reason': reason,
      'sev': sev,
      'flagsJson': flagsJson,
      'paramsJson': paramsJson,
      'ruleVersion': ruleVersion,
      if (resolvedNote != null) 'resolvedNote': resolvedNote,
      if (resolvedBy != null) 'resolvedBy': resolvedBy?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static ReconRowInclude include() {
    return ReconRowInclude._();
  }

  static ReconRowIncludeList includeList({
    _is.WhereExpressionBuilder<ReconRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    ReconRowInclude? include,
  }) {
    return ReconRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReconRowImpl extends ReconRow {
  _ReconRowImpl({
    int? id,
    required int scanId,
    int? planItemId,
    String? itemKey,
    required String status,
    required String reason,
    required String sev,
    String? flagsJson,
    String? paramsJson,
    required String ruleVersion,
    String? resolvedNote,
    _is.UuidValue? resolvedBy,
    DateTime? createdAt,
  }) : super._(
         id: id,
         scanId: scanId,
         planItemId: planItemId,
         itemKey: itemKey,
         status: status,
         reason: reason,
         sev: sev,
         flagsJson: flagsJson,
         paramsJson: paramsJson,
         ruleVersion: ruleVersion,
         resolvedNote: resolvedNote,
         resolvedBy: resolvedBy,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [ReconRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReconRow copyWith({
    Object? id = _Undefined,
    int? scanId,
    Object? planItemId = _Undefined,
    Object? itemKey = _Undefined,
    String? status,
    String? reason,
    String? sev,
    String? flagsJson,
    String? paramsJson,
    String? ruleVersion,
    Object? resolvedNote = _Undefined,
    _is.UuidValue? resolvedBy = const _is.$UndefinedUuidValue(),
    DateTime? createdAt,
  }) {
    return ReconRow(
      id: id is int? ? id : this.id,
      scanId: scanId ?? this.scanId,
      planItemId: planItemId is int? ? planItemId : this.planItemId,
      itemKey: itemKey is String? ? itemKey : this.itemKey,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      sev: sev ?? this.sev,
      flagsJson: flagsJson ?? this.flagsJson,
      paramsJson: paramsJson ?? this.paramsJson,
      ruleVersion: ruleVersion ?? this.ruleVersion,
      resolvedNote: resolvedNote is String? ? resolvedNote : this.resolvedNote,
      resolvedBy: resolvedBy is _is.UndefinedSentinel
          ? this.resolvedBy
          : resolvedBy,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class ReconRowUpdateTable extends _is.UpdateTable<ReconRowTable> {
  ReconRowUpdateTable(super.table);

  _is.ColumnValue<int, int> scanId(int value) => _is.ColumnValue(
    table.scanId,
    value,
  );

  _is.ColumnValue<int, int> planItemId(int? value) => _is.ColumnValue(
    table.planItemId,
    value,
  );

  _is.ColumnValue<String, String> itemKey(String? value) => _is.ColumnValue(
    table.itemKey,
    value,
  );

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> reason(String value) => _is.ColumnValue(
    table.reason,
    value,
  );

  _is.ColumnValue<String, String> sev(String value) => _is.ColumnValue(
    table.sev,
    value,
  );

  _is.ColumnValue<String, String> flagsJson(String value) => _is.ColumnValue(
    table.flagsJson,
    value,
  );

  _is.ColumnValue<String, String> paramsJson(String value) => _is.ColumnValue(
    table.paramsJson,
    value,
  );

  _is.ColumnValue<String, String> ruleVersion(String value) => _is.ColumnValue(
    table.ruleVersion,
    value,
  );

  _is.ColumnValue<String, String> resolvedNote(String? value) =>
      _is.ColumnValue(
        table.resolvedNote,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> resolvedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.resolvedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class ReconRowTable extends _is.Table<int?> {
  ReconRowTable({super.tableRelation}) : super(tableName: 'recon') {
    updateTable = ReconRowUpdateTable(this);
    scanId = _is.ColumnInt(
      'scanId',
      this,
    );
    planItemId = _is.ColumnInt(
      'planItemId',
      this,
    );
    itemKey = _is.ColumnString(
      'itemKey',
      this,
    );
    status = _is.ColumnString(
      'status',
      this,
    );
    reason = _is.ColumnString(
      'reason',
      this,
    );
    sev = _is.ColumnString(
      'sev',
      this,
    );
    flagsJson = _is.ColumnString(
      'flagsJson',
      this,
      hasDefault: true,
    );
    paramsJson = _is.ColumnString(
      'paramsJson',
      this,
      hasDefault: true,
    );
    ruleVersion = _is.ColumnString(
      'ruleVersion',
      this,
    );
    resolvedNote = _is.ColumnString(
      'resolvedNote',
      this,
    );
    resolvedBy = _is.ColumnUuid(
      'resolvedBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final ReconRowUpdateTable updateTable;

  late final _is.ColumnInt scanId;

  late final _is.ColumnInt planItemId;

  late final _is.ColumnString itemKey;

  late final _is.ColumnString status;

  late final _is.ColumnString reason;

  late final _is.ColumnString sev;

  late final _is.ColumnString flagsJson;

  late final _is.ColumnString paramsJson;

  late final _is.ColumnString ruleVersion;

  late final _is.ColumnString resolvedNote;

  late final _is.ColumnUuid resolvedBy;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    scanId,
    planItemId,
    itemKey,
    status,
    reason,
    sev,
    flagsJson,
    paramsJson,
    ruleVersion,
    resolvedNote,
    resolvedBy,
    createdAt,
  ];
}

class ReconRowInclude extends _is.IncludeObject {
  ReconRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ReconRow.t;
}

class ReconRowIncludeList extends _is.IncludeList {
  ReconRowIncludeList._({
    _is.WhereExpressionBuilder<ReconRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ReconRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ReconRow.t;
}

class ReconRowRepository {
  const ReconRowRepository._();

  /// Returns a list of [ReconRow]s matching the given query parameters.
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
  Future<List<ReconRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReconRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ReconRow>(
      where: where?.call(ReconRow.t),
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [ReconRow]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `ReconRow.t`.
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
  _ida.Stream<List<ReconRow>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReconRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<ReconRow>(
      where: where?.call(ReconRow.t),
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [ReconRow] matching the given query parameters.
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
  Future<ReconRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReconRowTable>? where,
    int? offset,
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ReconRow>(
      where: where?.call(ReconRow.t),
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ReconRow] by its [id] or null if no such row exists.
  Future<ReconRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ReconRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ReconRow]s in the list and returns the inserted rows.
  ///
  /// The returned [ReconRow]s will have their `id` fields set.
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
  Future<List<ReconRow>> insert(
    _is.DatabaseSession session,
    List<ReconRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ReconRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ReconRow] and returns the inserted row.
  ///
  /// The returned [ReconRow] will have its `id` field set.
  Future<ReconRow> insertRow(
    _is.DatabaseSession session,
    ReconRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ReconRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [ReconRow]s in the list and returns the resulting rows.
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
  /// The returned [ReconRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReconRow>> upsert(
    _is.DatabaseSession session,
    List<ReconRow> rows, {
    required _is.ColumnSelections<ReconRowTable> conflictColumns,
    _is.ColumnSelections<ReconRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ReconRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ReconRow>(
      rows,
      conflictColumns: conflictColumns(ReconRow.t),
      updateColumns: updateColumns?.call(ReconRow.t),
      updateWhere: updateWhere?.call(ReconRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ReconRow] and returns the resulting row.
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
  /// The returned [ReconRow] will have its `id` field set.
  Future<ReconRow?> upsertRow(
    _is.DatabaseSession session,
    ReconRow row, {
    required _is.ColumnSelections<ReconRowTable> conflictColumns,
    _is.ColumnSelections<ReconRowTable>? updateColumns,
    _is.WhereExpressionBuilder<ReconRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ReconRow>(
      row,
      conflictColumns: conflictColumns(ReconRow.t),
      updateColumns: updateColumns?.call(ReconRow.t),
      updateWhere: updateWhere?.call(ReconRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [ReconRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReconRow>> update(
    _is.DatabaseSession session,
    List<ReconRow> rows, {
    _is.ColumnSelections<ReconRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ReconRow>(
      rows,
      columns: columns?.call(ReconRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ReconRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ReconRow> updateRow(
    _is.DatabaseSession session,
    ReconRow row, {
    _is.ColumnSelections<ReconRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ReconRow>(
      row,
      columns: columns?.call(ReconRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ReconRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ReconRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ReconRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ReconRow>(
      id,
      columnValues: columnValues(ReconRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ReconRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ReconRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ReconRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ReconRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ReconRow>(
      columnValues: columnValues(ReconRow.t.updateTable),
      where: where(ReconRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ReconRow]s in the list and returns the deleted rows.
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
  Future<List<ReconRow>> delete(
    _is.DatabaseSession session,
    List<ReconRow> rows, {
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ReconRow>(
      rows,
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ReconRow].
  Future<ReconRow> deleteRow(
    _is.DatabaseSession session,
    ReconRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ReconRow>(
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
  Future<List<ReconRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReconRowTable> where,
    _is.OrderByBuilder<ReconRowTable>? orderBy,
    _is.OrderByListBuilder<ReconRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ReconRow>(
      where: where(ReconRow.t),
      orderBy: orderBy?.call(ReconRow.t),
      orderByList: orderByList?.call(ReconRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ReconRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ReconRow>(
      where: where?.call(ReconRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ReconRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ReconRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ReconRow>(
      where: where(ReconRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
