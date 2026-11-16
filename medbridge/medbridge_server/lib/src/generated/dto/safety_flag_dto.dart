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
import 'package:serverpod/serverpod.dart' as _is;

abstract class SafetyFlagDto
    implements _is.SerializableModel, _is.ProtocolSerialization {
  SafetyFlagDto._({
    required this.kind,
    required this.sev,
    required this.code,
    required this.detail,
  });

  factory SafetyFlagDto({
    required String kind,
    required String sev,
    required String code,
    required String detail,
  }) = _SafetyFlagDtoImpl;

  factory SafetyFlagDto.fromJson(Map<String, dynamic> jsonSerialization) {
    return SafetyFlagDto(
      kind: jsonSerialization['kind'] as String,
      sev: jsonSerialization['sev'] as String,
      code: jsonSerialization['code'] as String,
      detail: jsonSerialization['detail'] as String,
    );
  }

  String kind;

  String sev;

  String code;

  String detail;

  /// Returns a shallow copy of this [SafetyFlagDto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SafetyFlagDto copyWith({
    String? kind,
    String? sev,
    String? code,
    String? detail,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SafetyFlagDto',
      'kind': kind,
      'sev': sev,
      'code': code,
      'detail': detail,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SafetyFlagDto',
      'kind': kind,
      'sev': sev,
      'code': code,
      'detail': detail,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _SafetyFlagDtoImpl extends SafetyFlagDto {
  _SafetyFlagDtoImpl({
    required String kind,
    required String sev,
    required String code,
    required String detail,
  }) : super._(
         kind: kind,
         sev: sev,
         code: code,
         detail: detail,
       );

  /// Returns a shallow copy of this [SafetyFlagDto]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SafetyFlagDto copyWith({
    String? kind,
    String? sev,
    String? code,
    String? detail,
  }) {
    return SafetyFlagDto(
      kind: kind ?? this.kind,
      sev: sev ?? this.sev,
      code: code ?? this.code,
      detail: detail ?? this.detail,
    );
  }
}
