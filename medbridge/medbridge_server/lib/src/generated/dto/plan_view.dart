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
import '../discharge_plan.dart' as _ivgdi3rc;
import '../plan_item_row.dart' as _im1sjkto;

abstract class PlanView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PlanView._({
    required this.plan,
    required this.items,
  });

  factory PlanView({
    required _ivgdi3rc.DischargePlan plan,
    required List<_im1sjkto.PlanItemRow> items,
  }) = _PlanViewImpl;

  factory PlanView.fromJson(Map<String, dynamic> jsonSerialization) {
    return PlanView(
      plan: _iix47o0j.Protocol().deserialize<_ivgdi3rc.DischargePlan>(
        jsonSerialization['plan'],
      ),
      items: _iix47o0j.Protocol().deserialize<List<_im1sjkto.PlanItemRow>>(
        jsonSerialization['items'],
      ),
    );
  }

  _ivgdi3rc.DischargePlan plan;

  List<_im1sjkto.PlanItemRow> items;

  /// Returns a shallow copy of this [PlanView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PlanView copyWith({
    _ivgdi3rc.DischargePlan? plan,
    List<_im1sjkto.PlanItemRow>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PlanView',
      'plan': plan.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PlanView',
      'plan': plan.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _PlanViewImpl extends PlanView {
  _PlanViewImpl({
    required _ivgdi3rc.DischargePlan plan,
    required List<_im1sjkto.PlanItemRow> items,
  }) : super._(
         plan: plan,
         items: items,
       );

  /// Returns a shallow copy of this [PlanView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PlanView copyWith({
    _ivgdi3rc.DischargePlan? plan,
    List<_im1sjkto.PlanItemRow>? items,
  }) {
    return PlanView(
      plan: plan ?? this.plan.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
