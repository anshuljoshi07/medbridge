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
import 'package:medbridge_server/src/generated/protocol.dart' as _iix47o0j;
import 'package:serverpod/serverpod.dart' as _is;

abstract class ScanInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  ScanInput._({
    this.ndc11,
    this.rxcui,
    this.scd,
    required this.name,
    required this.ings,
    this.strength,
    required this.form,
    required this.sigRaw,
    required this.conf,
    required this.confirmed,
    required this.classIds,
    required this.ocrText,
  });

  factory ScanInput({
    String? ndc11,
    String? rxcui,
    String? scd,
    required String name,
    required List<String> ings,
    String? strength,
    required String form,
    required String sigRaw,
    required double conf,
    required bool confirmed,
    required List<String> classIds,
    required String ocrText,
  }) = _ScanInputImpl;

  factory ScanInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return ScanInput(
      ndc11: jsonSerialization['ndc11'] as String?,
      rxcui: jsonSerialization['rxcui'] as String?,
      scd: jsonSerialization['scd'] as String?,
      name: jsonSerialization['name'] as String,
      ings: _iix47o0j.Protocol().deserialize<List<String>>(
        jsonSerialization['ings'],
      ),
      strength: jsonSerialization['strength'] as String?,
      form: jsonSerialization['form'] as String,
      sigRaw: jsonSerialization['sigRaw'] as String,
      conf: (jsonSerialization['conf'] as num).toDouble(),
      confirmed: _is.BoolJsonExtension.fromJson(jsonSerialization['confirmed']),
      classIds: _iix47o0j.Protocol().deserialize<List<String>>(
        jsonSerialization['classIds'],
      ),
      ocrText: jsonSerialization['ocrText'] as String,
    );
  }

  String? ndc11;

  String? rxcui;

  String? scd;

  String name;

  List<String> ings;

  String? strength;

  String form;

  String sigRaw;

  double conf;

  bool confirmed;

  List<String> classIds;

  String ocrText;

  /// Returns a shallow copy of this [ScanInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ScanInput copyWith({
    String? ndc11,
    String? rxcui,
    String? scd,
    String? name,
    List<String>? ings,
    String? strength,
    String? form,
    String? sigRaw,
    double? conf,
    bool? confirmed,
    List<String>? classIds,
    String? ocrText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScanInput',
      if (ndc11 != null) 'ndc11': ndc11,
      if (rxcui != null) 'rxcui': rxcui,
      if (scd != null) 'scd': scd,
      'name': name,
      'ings': ings.toJson(),
      if (strength != null) 'strength': strength,
      'form': form,
      'sigRaw': sigRaw,
      'conf': conf,
      'confirmed': confirmed,
      'classIds': classIds.toJson(),
      'ocrText': ocrText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ScanInput',
      if (ndc11 != null) 'ndc11': ndc11,
      if (rxcui != null) 'rxcui': rxcui,
      if (scd != null) 'scd': scd,
      'name': name,
      'ings': ings.toJson(),
      if (strength != null) 'strength': strength,
      'form': form,
      'sigRaw': sigRaw,
      'conf': conf,
      'confirmed': confirmed,
      'classIds': classIds.toJson(),
      'ocrText': ocrText,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ScanInputImpl extends ScanInput {
  _ScanInputImpl({
    String? ndc11,
    String? rxcui,
    String? scd,
    required String name,
    required List<String> ings,
    String? strength,
    required String form,
    required String sigRaw,
    required double conf,
    required bool confirmed,
    required List<String> classIds,
    required String ocrText,
  }) : super._(
         ndc11: ndc11,
         rxcui: rxcui,
         scd: scd,
         name: name,
         ings: ings,
         strength: strength,
         form: form,
         sigRaw: sigRaw,
         conf: conf,
         confirmed: confirmed,
         classIds: classIds,
         ocrText: ocrText,
       );

  /// Returns a shallow copy of this [ScanInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ScanInput copyWith({
    Object? ndc11 = _Undefined,
    Object? rxcui = _Undefined,
    Object? scd = _Undefined,
    String? name,
    List<String>? ings,
    Object? strength = _Undefined,
    String? form,
    String? sigRaw,
    double? conf,
    bool? confirmed,
    List<String>? classIds,
    String? ocrText,
  }) {
    return ScanInput(
      ndc11: ndc11 is String? ? ndc11 : this.ndc11,
      rxcui: rxcui is String? ? rxcui : this.rxcui,
      scd: scd is String? ? scd : this.scd,
      name: name ?? this.name,
      ings: ings ?? this.ings.map((e0) => e0).toList(),
      strength: strength is String? ? strength : this.strength,
      form: form ?? this.form,
      sigRaw: sigRaw ?? this.sigRaw,
      conf: conf ?? this.conf,
      confirmed: confirmed ?? this.confirmed,
      classIds: classIds ?? this.classIds.map((e0) => e0).toList(),
      ocrText: ocrText ?? this.ocrText,
    );
  }
}
