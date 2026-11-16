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

abstract class BottleScan
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BottleScan._({
    this.id,
    required this.patientId,
    this.ndc11,
    this.rxcui,
    required this.name,
    required this.ingsJson,
    required this.strength,
    required this.form,
    required this.sigRaw,
    this.sigJson,
    required this.ocrText,
    required this.conf,
    required this.confirmed,
    String? classIdsJson,
    bool? setAside,
    DateTime? scannedAt,
  }) : classIdsJson = classIdsJson ?? '[]',
       setAside = setAside ?? false,
       scannedAt = scannedAt ?? DateTime.now();

  factory BottleScan({
    int? id,
    required int patientId,
    String? ndc11,
    String? rxcui,
    required String name,
    required String ingsJson,
    required String strength,
    required String form,
    required String sigRaw,
    String? sigJson,
    required String ocrText,
    required double conf,
    required bool confirmed,
    String? classIdsJson,
    bool? setAside,
    DateTime? scannedAt,
  }) = _BottleScanImpl;

  factory BottleScan.fromJson(Map<String, dynamic> jsonSerialization) {
    return BottleScan(
      id: jsonSerialization['id'] as int?,
      patientId: jsonSerialization['patientId'] as int,
      ndc11: jsonSerialization['ndc11'] as String?,
      rxcui: jsonSerialization['rxcui'] as String?,
      name: jsonSerialization['name'] as String,
      ingsJson: jsonSerialization['ingsJson'] as String,
      strength: jsonSerialization['strength'] as String,
      form: jsonSerialization['form'] as String,
      sigRaw: jsonSerialization['sigRaw'] as String,
      sigJson: jsonSerialization['sigJson'] as String?,
      ocrText: jsonSerialization['ocrText'] as String,
      conf: (jsonSerialization['conf'] as num).toDouble(),
      confirmed: _is.BoolJsonExtension.fromJson(jsonSerialization['confirmed']),
      classIdsJson: jsonSerialization['classIdsJson'] as String?,
      setAside: jsonSerialization['setAside'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['setAside']),
      scannedAt: jsonSerialization['scannedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['scannedAt']),
    );
  }

  static final t = BottleScanTable();

  static const db = BottleScanRepository._();

  @override
  int? id;

  int patientId;

  String? ndc11;

  String? rxcui;

  String name;

  String ingsJson;

  String strength;

  String form;

  String sigRaw;

  String? sigJson;

  String ocrText;

  double conf;

  bool confirmed;

  String classIdsJson;

  bool setAside;

  DateTime scannedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BottleScan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BottleScan copyWith({
    int? id,
    int? patientId,
    String? ndc11,
    String? rxcui,
    String? name,
    String? ingsJson,
    String? strength,
    String? form,
    String? sigRaw,
    String? sigJson,
    String? ocrText,
    double? conf,
    bool? confirmed,
    String? classIdsJson,
    bool? setAside,
    DateTime? scannedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BottleScan',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (ndc11 != null) 'ndc11': ndc11,
      if (rxcui != null) 'rxcui': rxcui,
      'name': name,
      'ingsJson': ingsJson,
      'strength': strength,
      'form': form,
      'sigRaw': sigRaw,
      if (sigJson != null) 'sigJson': sigJson,
      'ocrText': ocrText,
      'conf': conf,
      'confirmed': confirmed,
      'classIdsJson': classIdsJson,
      'setAside': setAside,
      'scannedAt': scannedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BottleScan',
      if (id != null) 'id': id,
      'patientId': patientId,
      if (ndc11 != null) 'ndc11': ndc11,
      if (rxcui != null) 'rxcui': rxcui,
      'name': name,
      'ingsJson': ingsJson,
      'strength': strength,
      'form': form,
      'sigRaw': sigRaw,
      if (sigJson != null) 'sigJson': sigJson,
      'ocrText': ocrText,
      'conf': conf,
      'confirmed': confirmed,
      'classIdsJson': classIdsJson,
      'setAside': setAside,
      'scannedAt': scannedAt.toJson(),
    };
  }

  static BottleScanInclude include() {
    return BottleScanInclude._();
  }

  static BottleScanIncludeList includeList({
    _is.WhereExpressionBuilder<BottleScanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    BottleScanInclude? include,
  }) {
    return BottleScanIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BottleScanImpl extends BottleScan {
  _BottleScanImpl({
    int? id,
    required int patientId,
    String? ndc11,
    String? rxcui,
    required String name,
    required String ingsJson,
    required String strength,
    required String form,
    required String sigRaw,
    String? sigJson,
    required String ocrText,
    required double conf,
    required bool confirmed,
    String? classIdsJson,
    bool? setAside,
    DateTime? scannedAt,
  }) : super._(
         id: id,
         patientId: patientId,
         ndc11: ndc11,
         rxcui: rxcui,
         name: name,
         ingsJson: ingsJson,
         strength: strength,
         form: form,
         sigRaw: sigRaw,
         sigJson: sigJson,
         ocrText: ocrText,
         conf: conf,
         confirmed: confirmed,
         classIdsJson: classIdsJson,
         setAside: setAside,
         scannedAt: scannedAt,
       );

  /// Returns a shallow copy of this [BottleScan]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BottleScan copyWith({
    Object? id = _Undefined,
    int? patientId,
    Object? ndc11 = _Undefined,
    Object? rxcui = _Undefined,
    String? name,
    String? ingsJson,
    String? strength,
    String? form,
    String? sigRaw,
    Object? sigJson = _Undefined,
    String? ocrText,
    double? conf,
    bool? confirmed,
    String? classIdsJson,
    bool? setAside,
    DateTime? scannedAt,
  }) {
    return BottleScan(
      id: id is int? ? id : this.id,
      patientId: patientId ?? this.patientId,
      ndc11: ndc11 is String? ? ndc11 : this.ndc11,
      rxcui: rxcui is String? ? rxcui : this.rxcui,
      name: name ?? this.name,
      ingsJson: ingsJson ?? this.ingsJson,
      strength: strength ?? this.strength,
      form: form ?? this.form,
      sigRaw: sigRaw ?? this.sigRaw,
      sigJson: sigJson is String? ? sigJson : this.sigJson,
      ocrText: ocrText ?? this.ocrText,
      conf: conf ?? this.conf,
      confirmed: confirmed ?? this.confirmed,
      classIdsJson: classIdsJson ?? this.classIdsJson,
      setAside: setAside ?? this.setAside,
      scannedAt: scannedAt ?? this.scannedAt,
    );
  }
}

class BottleScanUpdateTable extends _is.UpdateTable<BottleScanTable> {
  BottleScanUpdateTable(super.table);

  _is.ColumnValue<int, int> patientId(int value) => _is.ColumnValue(
    table.patientId,
    value,
  );

  _is.ColumnValue<String, String> ndc11(String? value) => _is.ColumnValue(
    table.ndc11,
    value,
  );

  _is.ColumnValue<String, String> rxcui(String? value) => _is.ColumnValue(
    table.rxcui,
    value,
  );

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(
    table.name,
    value,
  );

  _is.ColumnValue<String, String> ingsJson(String value) => _is.ColumnValue(
    table.ingsJson,
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

  _is.ColumnValue<String, String> sigRaw(String value) => _is.ColumnValue(
    table.sigRaw,
    value,
  );

  _is.ColumnValue<String, String> sigJson(String? value) => _is.ColumnValue(
    table.sigJson,
    value,
  );

  _is.ColumnValue<String, String> ocrText(String value) => _is.ColumnValue(
    table.ocrText,
    value,
  );

  _is.ColumnValue<double, double> conf(double value) => _is.ColumnValue(
    table.conf,
    value,
  );

  _is.ColumnValue<bool, bool> confirmed(bool value) => _is.ColumnValue(
    table.confirmed,
    value,
  );

  _is.ColumnValue<String, String> classIdsJson(String value) => _is.ColumnValue(
    table.classIdsJson,
    value,
  );

  _is.ColumnValue<bool, bool> setAside(bool value) => _is.ColumnValue(
    table.setAside,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> scannedAt(DateTime value) =>
      _is.ColumnValue(
        table.scannedAt,
        value,
      );
}

class BottleScanTable extends _is.Table<int?> {
  BottleScanTable({super.tableRelation}) : super(tableName: 'bottle_scan') {
    updateTable = BottleScanUpdateTable(this);
    patientId = _is.ColumnInt(
      'patientId',
      this,
    );
    ndc11 = _is.ColumnString(
      'ndc11',
      this,
    );
    rxcui = _is.ColumnString(
      'rxcui',
      this,
    );
    name = _is.ColumnString(
      'name',
      this,
    );
    ingsJson = _is.ColumnString(
      'ingsJson',
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
    sigRaw = _is.ColumnString(
      'sigRaw',
      this,
    );
    sigJson = _is.ColumnString(
      'sigJson',
      this,
    );
    ocrText = _is.ColumnString(
      'ocrText',
      this,
    );
    conf = _is.ColumnDouble(
      'conf',
      this,
    );
    confirmed = _is.ColumnBool(
      'confirmed',
      this,
    );
    classIdsJson = _is.ColumnString(
      'classIdsJson',
      this,
      hasDefault: true,
    );
    setAside = _is.ColumnBool(
      'setAside',
      this,
      hasDefault: true,
    );
    scannedAt = _is.ColumnDateTime(
      'scannedAt',
      this,
      hasDefault: true,
    );
  }

  late final BottleScanUpdateTable updateTable;

  late final _is.ColumnInt patientId;

  late final _is.ColumnString ndc11;

  late final _is.ColumnString rxcui;

  late final _is.ColumnString name;

  late final _is.ColumnString ingsJson;

  late final _is.ColumnString strength;

  late final _is.ColumnString form;

  late final _is.ColumnString sigRaw;

  late final _is.ColumnString sigJson;

  late final _is.ColumnString ocrText;

  late final _is.ColumnDouble conf;

  late final _is.ColumnBool confirmed;

  late final _is.ColumnString classIdsJson;

  late final _is.ColumnBool setAside;

  late final _is.ColumnDateTime scannedAt;

  @override
  List<_is.Column> get columns => [
    id,
    patientId,
    ndc11,
    rxcui,
    name,
    ingsJson,
    strength,
    form,
    sigRaw,
    sigJson,
    ocrText,
    conf,
    confirmed,
    classIdsJson,
    setAside,
    scannedAt,
  ];
}

class BottleScanInclude extends _is.IncludeObject {
  BottleScanInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BottleScan.t;
}

class BottleScanIncludeList extends _is.IncludeList {
  BottleScanIncludeList._({
    _is.WhereExpressionBuilder<BottleScanTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BottleScan.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BottleScan.t;
}

class BottleScanRepository {
  const BottleScanRepository._();

  /// Returns a list of [BottleScan]s matching the given query parameters.
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
  Future<List<BottleScan>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BottleScanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BottleScan>(
      where: where?.call(BottleScan.t),
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Emits [BottleScan]s matching the given query parameters every time the
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
  /// to that set. Pass [Table] instances such as `BottleScan.t`.
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
  _ida.Stream<List<BottleScan>> watch(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BottleScanTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    Duration? throttle = const Duration(milliseconds: 30),
    Iterable<_is.Table>? alsoTriggerOnTables,
  }) {
    return session.db.watch<BottleScan>(
      where: where?.call(BottleScan.t),
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      limit: limit,
      offset: offset,
      throttle: throttle,
      alsoTriggerOnTables: alsoTriggerOnTables,
    );
  }

  /// Returns the first matching [BottleScan] matching the given query parameters.
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
  Future<BottleScan?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BottleScanTable>? where,
    int? offset,
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BottleScan>(
      where: where?.call(BottleScan.t),
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BottleScan] by its [id] or null if no such row exists.
  Future<BottleScan?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BottleScan>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BottleScan]s in the list and returns the inserted rows.
  ///
  /// The returned [BottleScan]s will have their `id` fields set.
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
  Future<List<BottleScan>> insert(
    _is.DatabaseSession session,
    List<BottleScan> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BottleScan>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BottleScan] and returns the inserted row.
  ///
  /// The returned [BottleScan] will have its `id` field set.
  Future<BottleScan> insertRow(
    _is.DatabaseSession session,
    BottleScan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BottleScan>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BottleScan]s in the list and returns the resulting rows.
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
  /// The returned [BottleScan]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BottleScan>> upsert(
    _is.DatabaseSession session,
    List<BottleScan> rows, {
    required _is.ColumnSelections<BottleScanTable> conflictColumns,
    _is.ColumnSelections<BottleScanTable>? updateColumns,
    _is.WhereExpressionBuilder<BottleScanTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BottleScan>(
      rows,
      conflictColumns: conflictColumns(BottleScan.t),
      updateColumns: updateColumns?.call(BottleScan.t),
      updateWhere: updateWhere?.call(BottleScan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BottleScan] and returns the resulting row.
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
  /// The returned [BottleScan] will have its `id` field set.
  Future<BottleScan?> upsertRow(
    _is.DatabaseSession session,
    BottleScan row, {
    required _is.ColumnSelections<BottleScanTable> conflictColumns,
    _is.ColumnSelections<BottleScanTable>? updateColumns,
    _is.WhereExpressionBuilder<BottleScanTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BottleScan>(
      row,
      conflictColumns: conflictColumns(BottleScan.t),
      updateColumns: updateColumns?.call(BottleScan.t),
      updateWhere: updateWhere?.call(BottleScan.t),
      transaction: transaction,
    );
  }

  /// Updates all [BottleScan]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BottleScan>> update(
    _is.DatabaseSession session,
    List<BottleScan> rows, {
    _is.ColumnSelections<BottleScanTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BottleScan>(
      rows,
      columns: columns?.call(BottleScan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BottleScan]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BottleScan> updateRow(
    _is.DatabaseSession session,
    BottleScan row, {
    _is.ColumnSelections<BottleScanTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BottleScan>(
      row,
      columns: columns?.call(BottleScan.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BottleScan] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BottleScan?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BottleScanUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BottleScan>(
      id,
      columnValues: columnValues(BottleScan.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BottleScan]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BottleScan>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BottleScanUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BottleScanTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BottleScan>(
      columnValues: columnValues(BottleScan.t.updateTable),
      where: where(BottleScan.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BottleScan]s in the list and returns the deleted rows.
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
  Future<List<BottleScan>> delete(
    _is.DatabaseSession session,
    List<BottleScan> rows, {
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BottleScan>(
      rows,
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BottleScan].
  Future<BottleScan> deleteRow(
    _is.DatabaseSession session,
    BottleScan row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BottleScan>(
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
  Future<List<BottleScan>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BottleScanTable> where,
    _is.OrderByBuilder<BottleScanTable>? orderBy,
    _is.OrderByListBuilder<BottleScanTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BottleScan>(
      where: where(BottleScan.t),
      orderBy: orderBy?.call(BottleScan.t),
      orderByList: orderByList?.call(BottleScan.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BottleScanTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BottleScan>(
      where: where?.call(BottleScan.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BottleScan] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BottleScanTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BottleScan>(
      where: where(BottleScan.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
