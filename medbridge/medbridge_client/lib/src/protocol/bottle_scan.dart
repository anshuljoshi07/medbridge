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

abstract class BottleScan
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      confirmed: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['confirmed'],
      ),
      classIdsJson: jsonSerialization['classIdsJson'] as String?,
      setAside: jsonSerialization['setAside'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['setAside']),
      scannedAt: jsonSerialization['scannedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['scannedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [BottleScan]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
