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

abstract class DoseSchedule
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
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
      prn: _is.BoolJsonExtension.fromJson(jsonSerialization['prn']),
      active: jsonSerialization['active'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['active']),
      suspendedUntil: jsonSerialization['suspendedUntil'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['suspendedUntil'],
            ),
    );
  }

  static final t = DoseScheduleTable();

  static const db = DoseScheduleRepository._();

  @override
  int? id;

  int planItemId;

  String slotsJson;

  bool prn;

  bool active;

  DateTime? suspendedUntil;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DoseSchedule]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DoseSchedule copyWith({
    int? id,
    int? planItemId,
    String? slotsJson,
    bool? prn,
    bool? active,
    DateTime? suspendedUntil = const _is.$UndefinedDateTime(),
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

  static DoseScheduleInclude include() {
    return DoseScheduleInclude._();
  }

  static DoseScheduleIncludeList includeList({
    _is.WhereExpressionBuilder<DoseScheduleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    DoseScheduleInclude? include,
  }) {
    return DoseScheduleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
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
  @_is.useResult
  @override
  DoseSchedule copyWith({
    Object? id = _Undefined,
    int? planItemId,
    String? slotsJson,
    bool? prn,
    bool? active,
    DateTime? suspendedUntil = const _is.$UndefinedDateTime(),
  }) {
    return DoseSchedule(
      id: id is int? ? id : this.id,
      planItemId: planItemId ?? this.planItemId,
      slotsJson: slotsJson ?? this.slotsJson,
      prn: prn ?? this.prn,
      active: active ?? this.active,
      suspendedUntil: suspendedUntil is _is.UndefinedSentinel
          ? this.suspendedUntil
          : suspendedUntil,
    );
  }
}

class DoseScheduleUpdateTable extends _is.UpdateTable<DoseScheduleTable> {
  DoseScheduleUpdateTable(super.table);

  _is.ColumnValue<int, int> planItemId(int value) => _is.ColumnValue(
    table.planItemId,
    value,
  );

  _is.ColumnValue<String, String> slotsJson(String value) => _is.ColumnValue(
    table.slotsJson,
    value,
  );

  _is.ColumnValue<bool, bool> prn(bool value) => _is.ColumnValue(
    table.prn,
    value,
  );

  _is.ColumnValue<bool, bool> active(bool value) => _is.ColumnValue(
    table.active,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> suspendedUntil(DateTime? value) =>
      _is.ColumnValue(
        table.suspendedUntil,
        value,
      );
}

class DoseScheduleTable extends _is.Table<int?> {
  DoseScheduleTable({super.tableRelation}) : super(tableName: 'dose_schedule') {
    updateTable = DoseScheduleUpdateTable(this);
    planItemId = _is.ColumnInt(
      'planItemId',
      this,
    );
    slotsJson = _is.ColumnString(
      'slotsJson',
      this,
    );
    prn = _is.ColumnBool(
      'prn',
      this,
    );
    active = _is.ColumnBool(
      'active',
      this,
      hasDefault: true,
    );
    suspendedUntil = _is.ColumnDateTime(
      'suspendedUntil',
      this,
    );
  }

  late final DoseScheduleUpdateTable updateTable;

  late final _is.ColumnInt planItemId;

  late final _is.ColumnString slotsJson;

  late final _is.ColumnBool prn;

  late final _is.ColumnBool active;

  late final _is.ColumnDateTime suspendedUntil;

  @override
  List<_is.Column> get columns => [
    id,
    planItemId,
    slotsJson,
    prn,
    active,
    suspendedUntil,
  ];
}

class DoseScheduleInclude extends _is.IncludeObject {
  DoseScheduleInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DoseSchedule.t;
}

class DoseScheduleIncludeList extends _is.IncludeList {
  DoseScheduleIncludeList._({
    _is.WhereExpressionBuilder<DoseScheduleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DoseSchedule.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DoseSchedule.t;
}

class DoseScheduleRepository {
  const DoseScheduleRepository._();

  /// Returns a list of [DoseSchedule]s matching the given query parameters.
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
  Future<List<DoseSchedule>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseScheduleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DoseSchedule>(
      where: where?.call(DoseSchedule.t),
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [DoseSchedule]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `DoseSchedule.t`.
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
  _ida.Stream<List<DoseSchedule>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseScheduleTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<DoseSchedule>(
      where: where?.call(DoseSchedule.t),
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [DoseSchedule] matching the given query parameters.
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
  Future<DoseSchedule?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseScheduleTable>? where,
    int? offset,
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DoseSchedule>(
      where: where?.call(DoseSchedule.t),
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DoseSchedule] by its [id] or null if no such row exists.
  Future<DoseSchedule?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DoseSchedule>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DoseSchedule]s in the list and returns the inserted rows.
  ///
  /// The returned [DoseSchedule]s will have their `id` fields set.
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
  Future<List<DoseSchedule>> insert(
    _is.DatabaseSession session,
    List<DoseSchedule> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DoseSchedule>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DoseSchedule] and returns the inserted row.
  ///
  /// The returned [DoseSchedule] will have its `id` field set.
  Future<DoseSchedule> insertRow(
    _is.DatabaseSession session,
    DoseSchedule row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DoseSchedule>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DoseSchedule]s in the list and returns the resulting rows.
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
  /// The returned [DoseSchedule]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseSchedule>> upsert(
    _is.DatabaseSession session,
    List<DoseSchedule> rows, {
    required _is.ColumnSelections<DoseScheduleTable> conflictColumns,
    _is.ColumnSelections<DoseScheduleTable>? updateColumns,
    _is.WhereExpressionBuilder<DoseScheduleTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DoseSchedule>(
      rows,
      conflictColumns: conflictColumns(DoseSchedule.t),
      updateColumns: updateColumns?.call(DoseSchedule.t),
      updateWhere: updateWhere?.call(DoseSchedule.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DoseSchedule] and returns the resulting row.
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
  /// The returned [DoseSchedule] will have its `id` field set.
  Future<DoseSchedule?> upsertRow(
    _is.DatabaseSession session,
    DoseSchedule row, {
    required _is.ColumnSelections<DoseScheduleTable> conflictColumns,
    _is.ColumnSelections<DoseScheduleTable>? updateColumns,
    _is.WhereExpressionBuilder<DoseScheduleTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DoseSchedule>(
      row,
      conflictColumns: conflictColumns(DoseSchedule.t),
      updateColumns: updateColumns?.call(DoseSchedule.t),
      updateWhere: updateWhere?.call(DoseSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates all [DoseSchedule]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseSchedule>> update(
    _is.DatabaseSession session,
    List<DoseSchedule> rows, {
    _is.ColumnSelections<DoseScheduleTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DoseSchedule>(
      rows,
      columns: columns?.call(DoseSchedule.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DoseSchedule]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DoseSchedule> updateRow(
    _is.DatabaseSession session,
    DoseSchedule row, {
    _is.ColumnSelections<DoseScheduleTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DoseSchedule>(
      row,
      columns: columns?.call(DoseSchedule.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DoseSchedule] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DoseSchedule?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DoseScheduleUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DoseSchedule>(
      id,
      columnValues: columnValues(DoseSchedule.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DoseSchedule]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DoseSchedule>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DoseScheduleUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DoseScheduleTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DoseSchedule>(
      columnValues: columnValues(DoseSchedule.t.updateTable),
      where: where(DoseSchedule.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DoseSchedule]s in the list and returns the deleted rows.
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
  Future<List<DoseSchedule>> delete(
    _is.DatabaseSession session,
    List<DoseSchedule> rows, {
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DoseSchedule>(
      rows,
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DoseSchedule].
  Future<DoseSchedule> deleteRow(
    _is.DatabaseSession session,
    DoseSchedule row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DoseSchedule>(
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
  Future<List<DoseSchedule>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoseScheduleTable> where,
    _is.OrderByBuilder<DoseScheduleTable>? orderBy,
    _is.OrderByListBuilder<DoseScheduleTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DoseSchedule>(
      where: where(DoseSchedule.t),
      orderBy: orderBy?.call(DoseSchedule.t),
      orderByList: orderByList?.call(DoseSchedule.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DoseScheduleTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DoseSchedule>(
      where: where?.call(DoseSchedule.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DoseSchedule] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DoseScheduleTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DoseSchedule>(
      where: where(DoseSchedule.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
