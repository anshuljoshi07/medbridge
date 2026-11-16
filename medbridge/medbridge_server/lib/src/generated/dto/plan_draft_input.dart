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
import '../dto/plan_item_input.dart' as _i5ambu3h;

abstract class PlanDraftInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PlanDraftInput._({
    required this.items,
    required this.allergies,
    required this.unrecognized,
    this.dischargeDate,
  });

  factory PlanDraftInput({
    required List<_i5ambu3h.PlanItemInput> items,
    required List<String> allergies,
    required List<String> unrecognized,
    DateTime? dischargeDate,
  }) = _PlanDraftInputImpl;

  factory PlanDraftInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlanDraftInput(
      items: _iix47o0j.Protocol().deserialize<List<_i5ambu3h.PlanItemInput>>(
        jsonSerialization['items'],
      ),
      allergies: _iix47o0j.Protocol().deserialize<List<String>>(
        jsonSerialization['allergies'],
      ),
      unrecognized: _iix47o0j.Protocol().deserialize<List<String>>(
        jsonSerialization['unrecognized'],
      ),
      dischargeDate: jsonSerialization['dischargeDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['dischargeDate'],
            ),
    );
  }

  List<_i5ambu3h.PlanItemInput> items;

  List<String> allergies;

  List<String> unrecognized;

  DateTime? dischargeDate;

  /// Returns a shallow copy of this [PlanDraftInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlanDraftInput copyWith({
    List<_i5ambu3h.PlanItemInput>? items,
    List<String>? allergies,
    List<String>? unrecognized,
    DateTime? dischargeDate = const _is.$UndefinedDateTime(),
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlanDraftInput',
      'items': items.toJson(valueToJson: (v) => v.toJson()),
      'allergies': allergies.toJson(),
      'unrecognized': unrecognized.toJson(),
      if (dischargeDate != null) 'dischargeDate': dischargeDate?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlanDraftInput',
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'allergies': allergies.toJson(),
      'unrecognized': unrecognized.toJson(),
      if (dischargeDate != null) 'dischargeDate': dischargeDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PlanDraftInputImpl extends PlanDraftInput {
  _PlanDraftInputImpl({
    required List<_i5ambu3h.PlanItemInput> items,
    required List<String> allergies,
    required List<String> unrecognized,
    DateTime? dischargeDate,
  }) : super._(
         items: items,
         allergies: allergies,
         unrecognized: unrecognized,
         dischargeDate: dischargeDate,
       );

  /// Returns a shallow copy of this [PlanDraftInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlanDraftInput copyWith({
    List<_i5ambu3h.PlanItemInput>? items,
    List<String>? allergies,
    List<String>? unrecognized,
    DateTime? dischargeDate = const _is.$UndefinedDateTime(),
  }) {
    return PlanDraftInput(
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
      allergies: allergies ?? this.allergies.map((e0) => e0).toList(),
      unrecognized: unrecognized ?? this.unrecognized.map((e0) => e0).toList(),
      dischargeDate: dischargeDate is _is.UndefinedSentinel
          ? this.dischargeDate
          : dischargeDate,
    );
  }
}
