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

abstract class RxCache
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  RxCache._({
    this.id,
    required this.key,
    required this.kind,
    required this.json,
    required this.fetchedAt,
  });

  factory RxCache({
    int? id,
    required String key,
    required String kind,
    required String json,
    required DateTime fetchedAt,
  }) = _RxCacheImpl;

  factory RxCache.fromJson(Map<String, dynamic> jsonSerialization) {
    return RxCache(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      kind: jsonSerialization['kind'] as String,
      json: jsonSerialization['json'] as String,
      fetchedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['fetchedAt'],
      ),
    );
  }

  static final t = RxCacheTable();

  static const db = RxCacheRepository._();

  @override
  int? id;

  String key;

  String kind;

  String json;

  DateTime fetchedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [RxCache]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RxCache copyWith({
    int? id,
    String? key,
    String? kind,
    String? json,
    DateTime? fetchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RxCache',
      if (id != null) 'id': id,
      'key': key,
      'kind': kind,
      'json': json,
      'fetchedAt': fetchedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  static RxCacheInclude include() {
    return RxCacheInclude._();
  }

  static RxCacheIncludeList includeList({
    _is.WhereExpressionBuilder<RxCacheTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    RxCacheInclude? include,
  }) {
    return RxCacheIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RxCacheImpl extends RxCache {
  _RxCacheImpl({
    int? id,
    required String key,
    required String kind,
    required String json,
    required DateTime fetchedAt,
  }) : super._(
         id: id,
         key: key,
         kind: kind,
         json: json,
         fetchedAt: fetchedAt,
       );

  /// Returns a shallow copy of this [RxCache]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RxCache copyWith({
    Object? id = _Undefined,
    String? key,
    String? kind,
    String? json,
    DateTime? fetchedAt,
  }) {
    return RxCache(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      kind: kind ?? this.kind,
      json: json ?? this.json,
      fetchedAt: fetchedAt ?? this.fetchedAt,
    );
  }
}

class RxCacheUpdateTable extends _is.UpdateTable<RxCacheTable> {
  RxCacheUpdateTable(super.table);

  _is.ColumnValue<String, String> key(String value) => _is.ColumnValue(
    table.key,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> json(String value) => _is.ColumnValue(
    table.json,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> fetchedAt(DateTime value) =>
      _is.ColumnValue(
        table.fetchedAt,
        value,
      );
}

class RxCacheTable extends _is.Table<int?> {
  RxCacheTable({super.tableRelation}) : super(tableName: 'rx_cache') {
    updateTable = RxCacheUpdateTable(this);
    key = _is.ColumnString(
      'key',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    json = _is.ColumnString(
      'json',
      this,
    );
    fetchedAt = _is.ColumnDateTime(
      'fetchedAt',
      this,
    );
  }

  late final RxCacheUpdateTable updateTable;

  late final _is.ColumnString key;

  late final _is.ColumnString kind;

  late final _is.ColumnString json;

  late final _is.ColumnDateTime fetchedAt;

  @override
  List<_is.Column> get columns => [
    id,
    key,
    kind,
    json,
    fetchedAt,
  ];
}

class RxCacheInclude extends _is.IncludeObject {
  RxCacheInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => RxCache.t;
}

class RxCacheIncludeList extends _is.IncludeList {
  RxCacheIncludeList._({
    _is.WhereExpressionBuilder<RxCacheTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(RxCache.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => RxCache.t;
}

class RxCacheRepository {
  const RxCacheRepository._();

  /// Returns a list of [RxCache]s matching the given query parameters.
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
  Future<List<RxCache>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RxCacheTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<RxCache>(
      where: where?.call(RxCache.t),
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [RxCache]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `RxCache.t`.
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
  _ida.Stream<List<RxCache>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RxCacheTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<RxCache>(
      where: where?.call(RxCache.t),
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [RxCache] matching the given query parameters.
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
  Future<RxCache?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RxCacheTable>? where,
    int? offset,
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<RxCache>(
      where: where?.call(RxCache.t),
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [RxCache] by its [id] or null if no such row exists.
  Future<RxCache?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<RxCache>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [RxCache]s in the list and returns the inserted rows.
  ///
  /// The returned [RxCache]s will have their `id` fields set.
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
  Future<List<RxCache>> insert(
    _is.DatabaseSession session,
    List<RxCache> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<RxCache>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [RxCache] and returns the inserted row.
  ///
  /// The returned [RxCache] will have its `id` field set.
  Future<RxCache> insertRow(
    _is.DatabaseSession session,
    RxCache row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<RxCache>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [RxCache]s in the list and returns the resulting rows.
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
  /// The returned [RxCache]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RxCache>> upsert(
    _is.DatabaseSession session,
    List<RxCache> rows, {
    required _is.ColumnSelections<RxCacheTable> conflictColumns,
    _is.ColumnSelections<RxCacheTable>? updateColumns,
    _is.WhereExpressionBuilder<RxCacheTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<RxCache>(
      rows,
      conflictColumns: conflictColumns(RxCache.t),
      updateColumns: updateColumns?.call(RxCache.t),
      updateWhere: updateWhere?.call(RxCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [RxCache] and returns the resulting row.
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
  /// The returned [RxCache] will have its `id` field set.
  Future<RxCache?> upsertRow(
    _is.DatabaseSession session,
    RxCache row, {
    required _is.ColumnSelections<RxCacheTable> conflictColumns,
    _is.ColumnSelections<RxCacheTable>? updateColumns,
    _is.WhereExpressionBuilder<RxCacheTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<RxCache>(
      row,
      conflictColumns: conflictColumns(RxCache.t),
      updateColumns: updateColumns?.call(RxCache.t),
      updateWhere: updateWhere?.call(RxCache.t),
      transaction: transaction,
    );
  }

  /// Updates all [RxCache]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RxCache>> update(
    _is.DatabaseSession session,
    List<RxCache> rows, {
    _is.ColumnSelections<RxCacheTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<RxCache>(
      rows,
      columns: columns?.call(RxCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [RxCache]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<RxCache> updateRow(
    _is.DatabaseSession session,
    RxCache row, {
    _is.ColumnSelections<RxCacheTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<RxCache>(
      row,
      columns: columns?.call(RxCache.t),
      transaction: transaction,
    );
  }

  /// Updates a single [RxCache] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<RxCache?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<RxCacheUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<RxCache>(
      id,
      columnValues: columnValues(RxCache.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [RxCache]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<RxCache>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<RxCacheUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<RxCacheTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<RxCache>(
      columnValues: columnValues(RxCache.t.updateTable),
      where: where(RxCache.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [RxCache]s in the list and returns the deleted rows.
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
  Future<List<RxCache>> delete(
    _is.DatabaseSession session,
    List<RxCache> rows, {
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<RxCache>(
      rows,
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [RxCache].
  Future<RxCache> deleteRow(
    _is.DatabaseSession session,
    RxCache row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<RxCache>(
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
  Future<List<RxCache>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RxCacheTable> where,
    _is.OrderByBuilder<RxCacheTable>? orderBy,
    _is.OrderByListBuilder<RxCacheTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<RxCache>(
      where: where(RxCache.t),
      orderBy: orderBy?.call(RxCache.t),
      orderByList: orderByList?.call(RxCache.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<RxCacheTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<RxCache>(
      where: where?.call(RxCache.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [RxCache] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<RxCacheTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<RxCache>(
      where: where(RxCache.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
