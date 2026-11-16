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

abstract class PlanItemRow
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['holdUntil']),
      holdNote: jsonSerialization['holdNote'] as String?,
      src: jsonSerialization['src'] as String,
      conf: (jsonSerialization['conf'] as num).toDouble(),
      classIdsJson: jsonSerialization['classIdsJson'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [PlanItemRow]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
    DateTime? holdUntil = const _isc.$UndefinedDateTime(),
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
    DateTime? holdUntil = const _isc.$UndefinedDateTime(),
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
      holdUntil: holdUntil is _isc.UndefinedSentinel
          ? this.holdUntil
          : holdUntil,
      holdNote: holdNote is String? ? holdNote : this.holdNote,
      src: src ?? this.src,
      conf: conf ?? this.conf,
      classIdsJson: classIdsJson ?? this.classIdsJson,
    );
  }
}
