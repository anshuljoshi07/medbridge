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
import 'package:medbridge_client/src/protocol/protocol.dart' as _iw3s9cgw;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class PlanItemInput
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PlanItemInput._({
    required this.itemKey,
    required this.action,
    required this.name,
    this.rxcui,
    this.scd,
    required this.ings,
    this.strength,
    required this.form,
    required this.sigRaw,
    this.holdUntil,
    this.holdNote,
    required this.src,
    required this.conf,
    required this.classIds,
  });

  factory PlanItemInput({
    required String itemKey,
    required String action,
    required String name,
    String? rxcui,
    String? scd,
    required List<String> ings,
    String? strength,
    required String form,
    required String sigRaw,
    DateTime? holdUntil,
    String? holdNote,
    required String src,
    required double conf,
    required List<String> classIds,
  }) = _PlanItemInputImpl;

  factory PlanItemInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlanItemInput(
      itemKey: jsonSerialization['itemKey'] as String,
      action: jsonSerialization['action'] as String,
      name: jsonSerialization['name'] as String,
      rxcui: jsonSerialization['rxcui'] as String?,
      scd: jsonSerialization['scd'] as String?,
      ings: _iw3s9cgw.Protocol().deserialize<List<String>>(
        jsonSerialization['ings'],
      ),
      strength: jsonSerialization['strength'] as String?,
      form: jsonSerialization['form'] as String,
      sigRaw: jsonSerialization['sigRaw'] as String,
      holdUntil: jsonSerialization['holdUntil'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['holdUntil']),
      holdNote: jsonSerialization['holdNote'] as String?,
      src: jsonSerialization['src'] as String,
      conf: (jsonSerialization['conf'] as num).toDouble(),
      classIds: _iw3s9cgw.Protocol().deserialize<List<String>>(
        jsonSerialization['classIds'],
      ),
    );
  }

  String itemKey;

  String action;

  String name;

  String? rxcui;

  String? scd;

  List<String> ings;

  String? strength;

  String form;

  String sigRaw;

  DateTime? holdUntil;

  String? holdNote;

  String src;

  double conf;

  List<String> classIds;

  /// Returns a shallow copy of this [PlanItemInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PlanItemInput copyWith({
    String? itemKey,
    String? action,
    String? name,
    String? rxcui,
    String? scd,
    List<String>? ings,
    String? strength,
    String? form,
    String? sigRaw,
    DateTime? holdUntil = const _isc.$UndefinedDateTime(),
    String? holdNote,
    String? src,
    double? conf,
    List<String>? classIds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlanItemInput',
      'itemKey': itemKey,
      'action': action,
      'name': name,
      if (rxcui != null) 'rxcui': rxcui,
      if (scd != null) 'scd': scd,
      'ings': ings.toJson(),
      if (strength != null) 'strength': strength,
      'form': form,
      'sigRaw': sigRaw,
      if (holdUntil != null) 'holdUntil': holdUntil?.toJson(),
      if (holdNote != null) 'holdNote': holdNote,
      'src': src,
      'conf': conf,
      'classIds': classIds.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlanItemInput',
      'itemKey': itemKey,
      'action': action,
      'name': name,
      if (rxcui != null) 'rxcui': rxcui,
      if (scd != null) 'scd': scd,
      'ings': ings.toJson(),
      if (strength != null) 'strength': strength,
      'form': form,
      'sigRaw': sigRaw,
      if (holdUntil != null) 'holdUntil': holdUntil?.toJson(),
      if (holdNote != null) 'holdNote': holdNote,
      'src': src,
      'conf': conf,
      'classIds': classIds.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlanItemInputImpl extends PlanItemInput {
  _PlanItemInputImpl({
    required String itemKey,
    required String action,
    required String name,
    String? rxcui,
    String? scd,
    required List<String> ings,
    String? strength,
    required String form,
    required String sigRaw,
    DateTime? holdUntil,
    String? holdNote,
    required String src,
    required double conf,
    required List<String> classIds,
  }) : super._(
         itemKey: itemKey,
         action: action,
         name: name,
         rxcui: rxcui,
         scd: scd,
         ings: ings,
         strength: strength,
         form: form,
         sigRaw: sigRaw,
         holdUntil: holdUntil,
         holdNote: holdNote,
         src: src,
         conf: conf,
         classIds: classIds,
       );

  /// Returns a shallow copy of this [PlanItemInput]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PlanItemInput copyWith({
    String? itemKey,
    String? action,
    String? name,
    Object? rxcui = _Undefined,
    Object? scd = _Undefined,
    List<String>? ings,
    Object? strength = _Undefined,
    String? form,
    String? sigRaw,
    DateTime? holdUntil = const _isc.$UndefinedDateTime(),
    Object? holdNote = _Undefined,
    String? src,
    double? conf,
    List<String>? classIds,
  }) {
    return PlanItemInput(
      itemKey: itemKey ?? this.itemKey,
      action: action ?? this.action,
      name: name ?? this.name,
      rxcui: rxcui is String? ? rxcui : this.rxcui,
      scd: scd is String? ? scd : this.scd,
      ings: ings ?? this.ings.map((e0) => e0).toList(),
      strength: strength is String? ? strength : this.strength,
      form: form ?? this.form,
      sigRaw: sigRaw ?? this.sigRaw,
      holdUntil: holdUntil is _isc.UndefinedSentinel
          ? this.holdUntil
          : holdUntil,
      holdNote: holdNote is String? ? holdNote : this.holdNote,
      src: src ?? this.src,
      conf: conf ?? this.conf,
      classIds: classIds ?? this.classIds.map((e0) => e0).toList(),
    );
  }
}
