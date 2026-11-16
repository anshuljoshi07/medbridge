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

abstract class PlanItemRow
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  PlanItemRow._({
    this.id,
    required this.planId,
    required this.itemKey,
    required this.action,
    required this.name,
    this.rxcui,
    required this.ingsJson,
    this.scd,
    required this.strength,
    required this.form,
    this.route,
    required this.sigRaw,
    this.sigJson,
    this.holdUntil,
    this.holdNote,
    required this.src,
    required this.conf,
    String? classIdsJson,
  }) : classIdsJson = classIdsJson ?? '[]';

  factory PlanItemRow({
    int? id,
    required int planId,
    required String itemKey,
    required String action,
    required String name,
    String? rxcui,
    required String ingsJson,
    String? scd,
    required String strength,
    required String form,
    String? route,
    required String sigRaw,
    String? sigJson,
    DateTime? holdUntil,
    String? holdNote,
    required String src,
    required double conf,
    String? classIdsJson,
  }) = _PlanItemRowImpl;

  factory PlanItemRow.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlanItemRow(
      id: jsonSerialization['id'] as int?,
      planId: jsonSerialization['planId'] as int,
      itemKey: jsonSerialization['itemKey'] as String,
      action: jsonSerialization['action'] as String,
      name: jsonSerialization['name'] as String,
      rxcui: jsonSerialization['rxcui'] as String?,
      ingsJson: jsonSerialization['ingsJson'] as String,
      scd: jsonSerialization['scd'] as String?,
      strength: jsonSerialization['strength'] as String,
      form: jsonSerialization['form'] as String,
      route: jsonSerialization['route'] as String?,
      sigRaw: jsonSerialization['sigRaw'] as String,
      sigJson: jsonSerialization['sigJson'] as String?,
      holdUntil: jsonSerialization['holdUntil'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['holdUntil']),
      holdNote: jsonSerialization['holdNote'] as String?,
      src: jsonSerialization['src'] as String,
      conf: (jsonSerialization['conf'] as num).toDouble(),
      classIdsJson: jsonSerialization['classIdsJson'] as String?,
    );
  }

  static final t = PlanItemRowTable();

  static const db = PlanItemRowRepository._();

  @override
  int? id;

  int planId;

  String itemKey;

  String action;

  String name;

  String? rxcui;

  String ingsJson;

  String? scd;

  String strength;

  String form;

  String? route;

  String sigRaw;

  String? sigJson;

  DateTime? holdUntil;

  String? holdNote;

  String src;

  double conf;

  String classIdsJson;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [PlanItemRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlanItemRow copyWith({
    int? id,
    int? planId,
    String? itemKey,
    String? action,
    String? name,
    String? rxcui,
    String? ingsJson,
    String? scd,
    String? strength,
    String? form,
    String? route,
    String? sigRaw,
    String? sigJson,
    DateTime? holdUntil = const _is.$UndefinedDateTime(),
    String? holdNote,
    String? src,
    double? conf,
    String? classIdsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlanItemRow',
      if (id != null) 'id': id,
      'planId': planId,
      'itemKey': itemKey,
      'action': action,
      'name': name,
      if (rxcui != null) 'rxcui': rxcui,
      'ingsJson': ingsJson,
      if (scd != null) 'scd': scd,
      'strength': strength,
      'form': form,
      if (route != null) 'route': route,
      'sigRaw': sigRaw,
      if (sigJson != null) 'sigJson': sigJson,
      if (holdUntil != null) 'holdUntil': holdUntil?.toJson(),
      if (holdNote != null) 'holdNote': holdNote,
      'src': src,
      'conf': conf,
      'classIdsJson': classIdsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlanItemRow',
      if (id != null) 'id': id,
      'planId': planId,
      'itemKey': itemKey,
      'action': action,
      'name': name,
      if (rxcui != null) 'rxcui': rxcui,
      'ingsJson': ingsJson,
      if (scd != null) 'scd': scd,
      'strength': strength,
      'form': form,
      if (route != null) 'route': route,
      'sigRaw': sigRaw,
      if (sigJson != null) 'sigJson': sigJson,
      if (holdUntil != null) 'holdUntil': holdUntil?.toJson(),
      if (holdNote != null) 'holdNote': holdNote,
      'src': src,
      'conf': conf,
      'classIdsJson': classIdsJson,
    };
  }

  static PlanItemRowInclude include() {
    return PlanItemRowInclude._();
  }

  static PlanItemRowIncludeList includeList({
    _is.WhereExpressionBuilder<PlanItemRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    PlanItemRowInclude? include,
  }) {
    return PlanItemRowIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlanItemRowImpl extends PlanItemRow {
  _PlanItemRowImpl({
    int? id,
    required int planId,
    required String itemKey,
    required String action,
    required String name,
    String? rxcui,
    required String ingsJson,
    String? scd,
    required String strength,
    required String form,
    String? route,
    required String sigRaw,
    String? sigJson,
    DateTime? holdUntil,
    String? holdNote,
    required String src,
    required double conf,
    String? classIdsJson,
  }) : super._(
         id: id,
         planId: planId,
         itemKey: itemKey,
         action: action,
         name: name,
         rxcui: rxcui,
         ingsJson: ingsJson,
         scd: scd,
         strength: strength,
         form: form,
         route: route,
         sigRaw: sigRaw,
         sigJson: sigJson,
         holdUntil: holdUntil,
         holdNote: holdNote,
         src: src,
         conf: conf,
         classIdsJson: classIdsJson,
       );

  /// Returns a shallow copy of this [PlanItemRow]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlanItemRow copyWith({
    Object? id = _Undefined,
    int? planId,
    String? itemKey,
    String? action,
    String? name,
    Object? rxcui = _Undefined,
    String? ingsJson,
    Object? scd = _Undefined,
    String? strength,
    String? form,
    Object? route = _Undefined,
    String? sigRaw,
    Object? sigJson = _Undefined,
    DateTime? holdUntil = const _is.$UndefinedDateTime(),
    Object? holdNote = _Undefined,
    String? src,
    double? conf,
    String? classIdsJson,
  }) {
    return PlanItemRow(
      id: id is int? ? id : this.id,
      planId: planId ?? this.planId,
      itemKey: itemKey ?? this.itemKey,
      action: action ?? this.action,
      name: name ?? this.name,
      rxcui: rxcui is String? ? rxcui : this.rxcui,
      ingsJson: ingsJson ?? this.ingsJson,
      scd: scd is String? ? scd : this.scd,
      strength: strength ?? this.strength,
      form: form ?? this.form,
      route: route is String? ? route : this.route,
      sigRaw: sigRaw ?? this.sigRaw,
      sigJson: sigJson is String? ? sigJson : this.sigJson,
      holdUntil: holdUntil is _is.UndefinedSentinel
          ? this.holdUntil
          : holdUntil,
      holdNote: holdNote is String? ? holdNote : this.holdNote,
      src: src ?? this.src,
      conf: conf ?? this.conf,
      classIdsJson: classIdsJson ?? this.classIdsJson,
    );
  }
}

class PlanItemRowUpdateTable extends _is.UpdateTable<PlanItemRowTable> {
  PlanItemRowUpdateTable(super.table);

  _is.ColumnValue<int, int> planId(int value) => _is.ColumnValue(
    table.planId,
    value,
  );

  _is.ColumnValue<String, String> itemKey(String value) => _is.ColumnValue(
    table.itemKey,
    value,
  );

  _is.ColumnValue<String, String> action(String value) => _is.ColumnValue(
    table.action,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> rxcui(String? value) => _is.ColumnValue(
    table.rxcui,
    value,
  );

  _is.ColumnValue<String, String> ingsJson(String value) => _is.ColumnValue(
    table.ingsJson,
    value,
  );

  _is.ColumnValue<String, String> scd(String? value) => _is.ColumnValue(
    table.scd,
    value,
  );

  _is.ColumnValue<String, String> strength(String value) => _is.ColumnValue(
    table.strength,
    value,
  );

  _is.ColumnValue<String, String> form(String value) => _is.ColumnValue(
    table.form,
    value,
  );

  _is.ColumnValue<String, String> route(String? value) => _is.ColumnValue(
    table.route,
    value,
  );

  _is.ColumnValue<String, String> sigRaw(String value) => _is.ColumnValue(
    table.sigRaw,
    value,
  );

  _is.ColumnValue<String, String> sigJson(String? value) => _is.ColumnValue(
    table.sigJson,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> holdUntil(DateTime? value) =>
      _is.ColumnValue(
        table.holdUntil,
        value,
      );

  _is.ColumnValue<String, String> holdNote(String? value) => _is.ColumnValue(
    table.holdNote,
    value,
  );

  _is.ColumnValue<String, String> src(String value) => _is.ColumnValue(
    table.src,
    value,
  );

  _is.ColumnValue<double, double> conf(double value) => _is.ColumnValue(
    table.conf,
    value,
  );

  _is.ColumnValue<String, String> classIdsJson(String value) => _is.ColumnValue(
    table.classIdsJson,
    value,
  );
}

class PlanItemRowTable extends _is.Table<int?> {
  PlanItemRowTable({super.tableRelation}) : super(tableName: 'plan_item') {
    updateTable = PlanItemRowUpdateTable(this);
    planId = _is.ColumnInt(
      'planId',
      this,
    );
    itemKey = _is.ColumnString(
      'itemKey',
      this,
    );
    action = _is.ColumnString(
      'action',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    rxcui = _is.ColumnString(
      'rxcui',
      this,
    );
    ingsJson = _is.ColumnString(
      'ingsJson',
      this,
    );
    scd = _is.ColumnString(
      'scd',
      this,
    );
    strength = _is.ColumnString(
      'strength',
      this,
    );
    form = _is.ColumnString(
      'form',
      this,
    );
    route = _is.ColumnString(
      'route',
      this,
    );
    sigRaw = _is.ColumnString(
      'sigRaw',
      this,
    );
    sigJson = _is.ColumnString(
      'sigJson',
      this,
    );
    holdUntil = _is.ColumnDateTime(
      'holdUntil',
      this,
    );
    holdNote = _is.ColumnString(
      'holdNote',
      this,
    );
    src = _is.ColumnString(
      'src',
      this,
    );
    conf = _is.ColumnDouble(
      'conf',
      this,
    );
    classIdsJson = _is.ColumnString(
      'classIdsJson',
      this,
      hasDefault: true,
    );
  }

  late final PlanItemRowUpdateTable updateTable;

  late final _is.ColumnInt planId;

  late final _is.ColumnString itemKey;

  late final _is.ColumnString action;

  late final _is.ColumnString name;

  late final _is.ColumnString rxcui;

  late final _is.ColumnString ingsJson;

  late final _is.ColumnString scd;

  late final _is.ColumnString strength;

  late final _is.ColumnString form;

  late final _is.ColumnString route;

  late final _is.ColumnString sigRaw;

  late final _is.ColumnString sigJson;

  late final _is.ColumnDateTime holdUntil;

  late final _is.ColumnString holdNote;

  late final _is.ColumnString src;

  late final _is.ColumnDouble conf;

  late final _is.ColumnString classIdsJson;

  @override
  List<_is.Column> get columns => [
    id,
    planId,
    itemKey,
    action,
    name,
    rxcui,
    ingsJson,
    scd,
    strength,
    form,
    route,
    sigRaw,
    sigJson,
    holdUntil,
    holdNote,
    src,
    conf,
    classIdsJson,
  ];
}

class PlanItemRowInclude extends _is.IncludeObject {
  PlanItemRowInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => PlanItemRow.t;
}

class PlanItemRowIncludeList extends _is.IncludeList {
  PlanItemRowIncludeList._({
    _is.WhereExpressionBuilder<PlanItemRowTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(PlanItemRow.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => PlanItemRow.t;
}

class PlanItemRowRepository {
  const PlanItemRowRepository._();

  /// Returns a list of [PlanItemRow]s matching the given query parameters.
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
  Future<List<PlanItemRow>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlanItemRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<PlanItemRow>(
      where: where?.call(PlanItemRow.t),
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [PlanItemRow]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `PlanItemRow.t`.
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
  _ida.Stream<List<PlanItemRow>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlanItemRowTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<PlanItemRow>(
      where: where?.call(PlanItemRow.t),
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [PlanItemRow] matching the given query parameters.
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
  Future<PlanItemRow?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlanItemRowTable>? where,
    int? offset,
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<PlanItemRow>(
      where: where?.call(PlanItemRow.t),
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [PlanItemRow] by its [id] or null if no such row exists.
  Future<PlanItemRow?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<PlanItemRow>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [PlanItemRow]s in the list and returns the inserted rows.
  ///
  /// The returned [PlanItemRow]s will have their `id` fields set.
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
  Future<List<PlanItemRow>> insert(
    _is.DatabaseSession session,
    List<PlanItemRow> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<PlanItemRow>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [PlanItemRow] and returns the inserted row.
  ///
  /// The returned [PlanItemRow] will have its `id` field set.
  Future<PlanItemRow> insertRow(
    _is.DatabaseSession session,
    PlanItemRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<PlanItemRow>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [PlanItemRow]s in the list and returns the resulting rows.
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
  /// The returned [PlanItemRow]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlanItemRow>> upsert(
    _is.DatabaseSession session,
    List<PlanItemRow> rows, {
    required _is.ColumnSelections<PlanItemRowTable> conflictColumns,
    _is.ColumnSelections<PlanItemRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PlanItemRowTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<PlanItemRow>(
      rows,
      conflictColumns: conflictColumns(PlanItemRow.t),
      updateColumns: updateColumns?.call(PlanItemRow.t),
      updateWhere: updateWhere?.call(PlanItemRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [PlanItemRow] and returns the resulting row.
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
  /// The returned [PlanItemRow] will have its `id` field set.
  Future<PlanItemRow?> upsertRow(
    _is.DatabaseSession session,
    PlanItemRow row, {
    required _is.ColumnSelections<PlanItemRowTable> conflictColumns,
    _is.ColumnSelections<PlanItemRowTable>? updateColumns,
    _is.WhereExpressionBuilder<PlanItemRowTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<PlanItemRow>(
      row,
      conflictColumns: conflictColumns(PlanItemRow.t),
      updateColumns: updateColumns?.call(PlanItemRow.t),
      updateWhere: updateWhere?.call(PlanItemRow.t),
      transaction: transaction,
    );
  }

  /// Updates all [PlanItemRow]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlanItemRow>> update(
    _is.DatabaseSession session,
    List<PlanItemRow> rows, {
    _is.ColumnSelections<PlanItemRowTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<PlanItemRow>(
      rows,
      columns: columns?.call(PlanItemRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [PlanItemRow]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<PlanItemRow> updateRow(
    _is.DatabaseSession session,
    PlanItemRow row, {
    _is.ColumnSelections<PlanItemRowTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<PlanItemRow>(
      row,
      columns: columns?.call(PlanItemRow.t),
      transaction: transaction,
    );
  }

  /// Updates a single [PlanItemRow] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<PlanItemRow?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<PlanItemRowUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<PlanItemRow>(
      id,
      columnValues: columnValues(PlanItemRow.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [PlanItemRow]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<PlanItemRow>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<PlanItemRowUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<PlanItemRowTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<PlanItemRow>(
      columnValues: columnValues(PlanItemRow.t.updateTable),
      where: where(PlanItemRow.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [PlanItemRow]s in the list and returns the deleted rows.
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
  Future<List<PlanItemRow>> delete(
    _is.DatabaseSession session,
    List<PlanItemRow> rows, {
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<PlanItemRow>(
      rows,
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [PlanItemRow].
  Future<PlanItemRow> deleteRow(
    _is.DatabaseSession session,
    PlanItemRow row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<PlanItemRow>(
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
  Future<List<PlanItemRow>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlanItemRowTable> where,
    _is.OrderByBuilder<PlanItemRowTable>? orderBy,
    _is.OrderByListBuilder<PlanItemRowTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<PlanItemRow>(
      where: where(PlanItemRow.t),
      orderBy: orderBy?.call(PlanItemRow.t),
      orderByList: orderByList?.call(PlanItemRow.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<PlanItemRowTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<PlanItemRow>(
      where: where?.call(PlanItemRow.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [PlanItemRow] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<PlanItemRowTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<PlanItemRow>(
      where: where(PlanItemRow.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
