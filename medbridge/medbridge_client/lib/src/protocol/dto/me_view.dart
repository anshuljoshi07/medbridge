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
import '../patient.dart' as _ibusw2g9;

abstract class MeView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  MeView._({
    this.patient,
    required this.roles,
    required this.linkedPatients,
  });

  factory MeView({
    _ibusw2g9.Patient? patient,
    required List<String> roles,
    required List<_ibusw2g9.Patient> linkedPatients,
  }) = _MeViewImpl;

  factory MeView.fromJson(Map<String, dynamic> jsonSerialization) {
    return MeView(
      patient: jsonSerialization['patient'] == null
          ? null
          : _iw3s9cgw.Protocol().deserialize<_ibusw2g9.Patient>(
              jsonSerialization['patient'],
            ),
      roles: _iw3s9cgw.Protocol().deserialize<List<String>>(
        jsonSerialization['roles'],
      ),
      linkedPatients: _iw3s9cgw.Protocol().deserialize<List<_ibusw2g9.Patient>>(
        jsonSerialization['linkedPatients'],
      ),
    );
  }

  _ibusw2g9.Patient? patient;

  List<String> roles;

  List<_ibusw2g9.Patient> linkedPatients;

  /// Returns a shallow copy of this [MeView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  MeView copyWith({
    _ibusw2g9.Patient? patient = const _UndefinedMeView$patient(),
    List<String>? roles,
    List<_ibusw2g9.Patient>? linkedPatients,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MeView',
      if (patient != null) 'patient': patient?.toJson(),
      'roles': roles.toJson(),
      'linkedPatients': linkedPatients.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MeView',
      if (patient != null) 'patient': patient?.toJsonForProtocol(),
      'roles': roles.toJson(),
      'linkedPatients': linkedPatients.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _UndefinedMeView$patient extends _isc.UndefinedSentinel
    implements _ibusw2g9.Patient {
  const _UndefinedMeView$patient();
}

class _MeViewImpl extends MeView {
  _MeViewImpl({
    _ibusw2g9.Patient? patient,
    required List<String> roles,
    required List<_ibusw2g9.Patient> linkedPatients,
  }) : super._(
         patient: patient,
         roles: roles,
         linkedPatients: linkedPatients,
       );

  /// Returns a shallow copy of this [MeView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  MeView copyWith({
    _ibusw2g9.Patient? patient = const _UndefinedMeView$patient(),
    List<String>? roles,
    List<_ibusw2g9.Patient>? linkedPatients,
  }) {
    return MeView(
      patient: patient is _isc.UndefinedSentinel
          ? this.patient?.copyWith()
          : patient,
      roles: roles ?? this.roles.map((e0) => e0).toList(),
      linkedPatients:
          linkedPatients ??
          this.linkedPatients.map((e0) => e0.copyWith()).toList(),
    );
  }
}
