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
import '../dto/plan_view.dart' as _ie5lg4sc;
import '../dto/scan_history_entry.dart' as _ingq81mz;
import '../patient.dart' as _ibusw2g9;
import '../question.dart' as _iiyzbzce;

abstract class PcpSummary
    implements _is.SerializableModel, _is.ProtocolSerialization {
  PcpSummary._({
    required this.patient,
    this.plan,
    required this.history,
    required this.questions,
  });

  factory PcpSummary({
    required _ibusw2g9.Patient patient,
    _ie5lg4sc.PlanView? plan,
    required List<_ingq81mz.ScanHistoryEntry> history,
    required List<_iiyzbzce.Question> questions,
  }) = _PcpSummaryImpl;

  factory PcpSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return PcpSummary(
      patient: _iix47o0j.Protocol().deserialize<_ibusw2g9.Patient>(
        jsonSerialization['patient'],
      ),
      plan: jsonSerialization['plan'] == null
          ? null
          : _iix47o0j.Protocol().deserialize<_ie5lg4sc.PlanView>(
              jsonSerialization['plan'],
            ),
      history: _iix47o0j.Protocol()
          .deserialize<List<_ingq81mz.ScanHistoryEntry>>(
            jsonSerialization['history'],
          ),
      questions: _iix47o0j.Protocol().deserialize<List<_iiyzbzce.Question>>(
        jsonSerialization['questions'],
      ),
    );
  }

  _ibusw2g9.Patient patient;

  _ie5lg4sc.PlanView? plan;

  List<_ingq81mz.ScanHistoryEntry> history;

  List<_iiyzbzce.Question> questions;

  /// Returns a shallow copy of this [PcpSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  PcpSummary copyWith({
    _ibusw2g9.Patient? patient,
    _ie5lg4sc.PlanView? plan = const _UndefinedPcpSummary$plan(),
    List<_ingq81mz.ScanHistoryEntry>? history,
    List<_iiyzbzce.Question>? questions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PcpSummary',
      'patient': patient.toJson(),
      if (plan != null) 'plan': plan?.toJson(),
      'history': history.toJson(valueToJson: (v) => v.toJson()),
      'questions': questions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PcpSummary',
      'patient': patient.toJsonForProtocol(),
      if (plan != null) 'plan': plan?.toJsonForProtocol(),
      'history': history.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'questions': questions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _UndefinedPcpSummary$plan extends _is.UndefinedSentinel
    implements _ie5lg4sc.PlanView {
  const _UndefinedPcpSummary$plan();
}

class _PcpSummaryImpl extends PcpSummary {
  _PcpSummaryImpl({
    required _ibusw2g9.Patient patient,
    _ie5lg4sc.PlanView? plan,
    required List<_ingq81mz.ScanHistoryEntry> history,
    required List<_iiyzbzce.Question> questions,
  }) : super._(
         patient: patient,
         plan: plan,
         history: history,
         questions: questions,
       );

  /// Returns a shallow copy of this [PcpSummary]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  PcpSummary copyWith({
    _ibusw2g9.Patient? patient,
    _ie5lg4sc.PlanView? plan = const _UndefinedPcpSummary$plan(),
    List<_ingq81mz.ScanHistoryEntry>? history,
    List<_iiyzbzce.Question>? questions,
  }) {
    return PcpSummary(
      patient: patient ?? this.patient.copyWith(),
      plan: plan is _is.UndefinedSentinel ? this.plan?.copyWith() : plan,
      history: history ?? this.history.map((e0) => e0.copyWith()).toList(),
      questions:
          questions ?? this.questions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
