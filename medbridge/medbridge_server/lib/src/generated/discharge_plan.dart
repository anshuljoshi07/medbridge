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
import 'plan_status.dart' as _iqzysob1;

abstract class DischargePlan
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  DischargePlan._({
    this.id,
    required this.patientId,
    String? source,
    this.dischargeDate,
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    this.verifiedBy,
    this.verifiedAt,
    DateTime? createdAt,
  }) : source = source ?? 'avs_scan',
       status = status ?? _iqzysob1.PlanStatus.draft,
       allergiesJson = allergiesJson ?? '[]',
       unrecognizedJson = unrecognizedJson ?? '[]',
       createdAt = createdAt ?? DateTime.now();

  factory DischargePlan({
    int? id,
    required int patientId,
    String? source,
    DateTime? dischargeDate,
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _is.UuidValue? verifiedBy,
    DateTime? verifiedAt,
    DateTime? createdAt,
  }) = _DischargePlanImpl;

  factory DischargePlan.fromJson(Map<String, dynamic> jsonSerialization) {
    return DischargePlan(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      source: jsonSerialization['source'] as String?,
      dischargeDate: jsonSerialization['dischargeDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dischargeDate'],
            ),
      status: jsonSerialization['status'] == null
          ? null
          : _iqzysob1.PlanStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      allergiesJson: jsonSerialization['allergiesJson'] as String?,
      unrecognizedJson: jsonSerialization['unrecognizedJson'] as String?,
      verifiedBy: jsonSerialization['verifiedBy'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['verifiedBy'],
            ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = DischargePlanTable();

  static const db = DischargePlanRepository._();

  @override
  int? id;

  int patientId;

  String source;

  DateTime? dischargeDate;

  _iqzysob1.PlanStatus status;

  String allergiesJson;

  String unrecognizedJson;

  _is.UuidValue? verifiedBy;

  DateTime? verifiedAt;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [DischargePlan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  DischargePlan copyWith({
    int? id,
    int? patientId,
    String? source,
    DateTime? dischargeDate = const _is.$UndefinedDateTime(),
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _is.UuidValue? verifiedBy = const _is.$UndefinedUuidValue(),
    DateTime? verifiedAt = const _is.$UndefinedDateTime(),
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DischargePlan',
      if (id != null) 'id': id,
      'patientId': patientId,
      'source': source,
      if (dischargeDate != null) 'dischargeDate': dischargeDate?.toJson(),
      'status': status.toJson(),
      'allergiesJson': allergiesJson,
      'unrecognizedJson': unrecognizedJson,
      if (verifiedBy != null) 'verifiedBy': verifiedBy?.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DischargePlan',
      if (id != null) 'id': id,
      'patientId': patientId,
      'source': source,
      if (dischargeDate != null) 'dischargeDate': dischargeDate?.toJson(),
      'status': status.toJson(),
      'allergiesJson': allergiesJson,
      'unrecognizedJson': unrecognizedJson,
      if (verifiedBy != null) 'verifiedBy': verifiedBy?.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static DischargePlanInclude include() {
    return DischargePlanInclude._();
  }

  static DischargePlanIncludeList includeList({
    _is.WhereExpressionBuilder<DischargePlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    DischargePlanInclude? include,
  }) {
    return DischargePlanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DischargePlanImpl extends DischargePlan {
  _DischargePlanImpl({
    int? id,
    required int patientId,
    String? source,
    DateTime? dischargeDate,
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _is.UuidValue? verifiedBy,
    DateTime? verifiedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         patientId: patientId,
         source: source,
         dischargeDate: dischargeDate,
         status: status,
         allergiesJson: allergiesJson,
         unrecognizedJson: unrecognizedJson,
         verifiedBy: verifiedBy,
         verifiedAt: verifiedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [DischargePlan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  DischargePlan copyWith({
    Object? id = _Undefined,
    int? patientId,
    String? source,
    DateTime? dischargeDate = const _is.$UndefinedDateTime(),
    _iqzysob1.PlanStatus? status,
    String? allergiesJson,
    String? unrecognizedJson,
    _is.UuidValue? verifiedBy = const _is.$UndefinedUuidValue(),
    DateTime? verifiedAt = const _is.$UndefinedDateTime(),
    DateTime? createdAt,
  }) {
    return DischargePlan(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      source: source ?? this.source,
      dischargeDate: dischargeDate is _is.UndefinedSentinel
          ? this.dischargeDate
          : dischargeDate,
      status: status ?? this.status,
      allergiesJson: allergiesJson ?? this.allergiesJson,
      unrecognizedJson: unrecognizedJson ?? this.unrecognizedJson,
      verifiedBy: verifiedBy is _is.UndefinedSentinel
          ? this.verifiedBy
          : verifiedBy,
      verifiedAt: verifiedAt is _is.UndefinedSentinel
          ? this.verifiedAt
          : verifiedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class DischargePlanUpdateTable extends _is.UpdateTable<DischargePlanTable> {
  DischargePlanUpdateTable(super.table);

  _is.ColumnValue<int, int> patientId(int value) => _is.ColumnValue(
    table.patientId,
    value,
  );

  _is.ColumnValue<String, String> source(String value) => _is.ColumnValue(
    table.source,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> dischargeDate(DateTime? value) =>
      _is.ColumnValue(
        table.dischargeDate,
        value,
      );

  _is.ColumnValue<_iqzysob1.PlanStatus, _iqzysob1.PlanStatus> status(
    _iqzysob1.PlanStatus value,
  ) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<String, String> allergiesJson(String value) =>
      _is.ColumnValue(
        table.allergiesJson,
        value,
      );

  _is.ColumnValue<String, String> unrecognizedJson(String value) =>
      _is.ColumnValue(
        table.unrecognizedJson,
        value,
      );

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> verifiedBy(
    _is.UuidValue? value,
  ) => _is.ColumnValue(
    table.verifiedBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> verifiedAt(DateTime? value) =>
      _is.ColumnValue(
        table.verifiedAt,
        value,
      );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class DischargePlanTable extends _is.Table<int?> {
  DischargePlanTable({super.tableRelation})
    : super(tableName: 'discharge_plan') {
    updateTable = DischargePlanUpdateTable(this);
    patientId = _is.ColumnInt(
      'patientId',
      this,
    );
    source = _is.ColumnString(
      'source',
      this,
      hasDefault: true,
    );
    dischargeDate = _is.ColumnDateTime(
      'dischargeDate',
      this,
    );
    status = _is.ColumnEnum(
      'status',
      this,
      _is.EnumSerialization.byName,
      hasDefault: true,
    );
    allergiesJson = _is.ColumnString(
      'allergiesJson',
      this,
      hasDefault: true,
    );
    unrecognizedJson = _is.ColumnString(
      'unrecognizedJson',
      this,
      hasDefault: true,
    );
    verifiedBy = _is.ColumnUuid(
      'verifiedBy',
      this,
    );
    verifiedAt = _is.ColumnDateTime(
      'verifiedAt',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final DischargePlanUpdateTable updateTable;

  late final _is.ColumnInt patientId;

  late final _is.ColumnString source;

  late final _is.ColumnDateTime dischargeDate;

  late final _is.ColumnEnum<_iqzysob1.PlanStatus> status;

  late final _is.ColumnString allergiesJson;

  late final _is.ColumnString unrecognizedJson;

  late final _is.ColumnUuid verifiedBy;

  late final _is.ColumnDateTime verifiedAt;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    patientId,
    source,
    dischargeDate,
    status,
    allergiesJson,
    unrecognizedJson,
    verifiedBy,
    verifiedAt,
    createdAt,
  ];
}

class DischargePlanInclude extends _is.IncludeObject {
  DischargePlanInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => DischargePlan.t;
}

class DischargePlanIncludeList extends _is.IncludeList {
  DischargePlanIncludeList._({
    _is.WhereExpressionBuilder<DischargePlanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DischargePlan.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => DischargePlan.t;
}

class DischargePlanRepository {
  const DischargePlanRepository._();

  /// Returns a list of [DischargePlan]s matching the given query parameters.
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
  Future<List<DischargePlan>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DischargePlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DischargePlan>(
      where: where?.call(DischargePlan.t),
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [DischargePlan]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `DischargePlan.t`.
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
  _ida.Stream<List<DischargePlan>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DischargePlanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<DischargePlan>(
      where: where?.call(DischargePlan.t),
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [DischargePlan] matching the given query parameters.
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
  Future<DischargePlan?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DischargePlanTable>? where,
    int? offset,
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DischargePlan>(
      where: where?.call(DischargePlan.t),
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DischargePlan] by its [id] or null if no such row exists.
  Future<DischargePlan?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DischargePlan>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DischargePlan]s in the list and returns the inserted rows.
  ///
  /// The returned [DischargePlan]s will have their `id` fields set.
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
  Future<List<DischargePlan>> insert(
    _is.DatabaseSession session,
    List<DischargePlan> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<DischargePlan>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [DischargePlan] and returns the inserted row.
  ///
  /// The returned [DischargePlan] will have its `id` field set.
  Future<DischargePlan> insertRow(
    _is.DatabaseSession session,
    DischargePlan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<DischargePlan>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [DischargePlan]s in the list and returns the resulting rows.
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
  /// The returned [DischargePlan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DischargePlan>> upsert(
    _is.DatabaseSession session,
    List<DischargePlan> rows, {
    required _is.ColumnSelections<DischargePlanTable> conflictColumns,
    _is.ColumnSelections<DischargePlanTable>? updateColumns,
    _is.WhereExpressionBuilder<DischargePlanTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<DischargePlan>(
      rows,
      conflictColumns: conflictColumns(DischargePlan.t),
      updateColumns: updateColumns?.call(DischargePlan.t),
      updateWhere: updateWhere?.call(DischargePlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [DischargePlan] and returns the resulting row.
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
  /// The returned [DischargePlan] will have its `id` field set.
  Future<DischargePlan?> upsertRow(
    _is.DatabaseSession session,
    DischargePlan row, {
    required _is.ColumnSelections<DischargePlanTable> conflictColumns,
    _is.ColumnSelections<DischargePlanTable>? updateColumns,
    _is.WhereExpressionBuilder<DischargePlanTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<DischargePlan>(
      row,
      conflictColumns: conflictColumns(DischargePlan.t),
      updateColumns: updateColumns?.call(DischargePlan.t),
      updateWhere: updateWhere?.call(DischargePlan.t),
      transaction: transaction,
    );
  }

  /// Updates all [DischargePlan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DischargePlan>> update(
    _is.DatabaseSession session,
    List<DischargePlan> rows, {
    _is.ColumnSelections<DischargePlanTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<DischargePlan>(
      rows,
      columns: columns?.call(DischargePlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [DischargePlan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DischargePlan> updateRow(
    _is.DatabaseSession session,
    DischargePlan row, {
    _is.ColumnSelections<DischargePlanTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<DischargePlan>(
      row,
      columns: columns?.call(DischargePlan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DischargePlan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DischargePlan?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<DischargePlanUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<DischargePlan>(
      id,
      columnValues: columnValues(DischargePlan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DischargePlan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<DischargePlan>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<DischargePlanUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<DischargePlanTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<DischargePlan>(
      columnValues: columnValues(DischargePlan.t.updateTable),
      where: where(DischargePlan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [DischargePlan]s in the list and returns the deleted rows.
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
  Future<List<DischargePlan>> delete(
    _is.DatabaseSession session,
    List<DischargePlan> rows, {
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<DischargePlan>(
      rows,
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [DischargePlan].
  Future<DischargePlan> deleteRow(
    _is.DatabaseSession session,
    DischargePlan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DischargePlan>(
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
  Future<List<DischargePlan>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DischargePlanTable> where,
    _is.OrderByBuilder<DischargePlanTable>? orderBy,
    _is.OrderByListBuilder<DischargePlanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<DischargePlan>(
      where: where(DischargePlan.t),
      orderBy: orderBy?.call(DischargePlan.t),
      orderByList: orderByList?.call(DischargePlan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<DischargePlanTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<DischargePlan>(
      where: where?.call(DischargePlan.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DischargePlan] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<DischargePlanTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DischargePlan>(
      where: where(DischargePlan.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
