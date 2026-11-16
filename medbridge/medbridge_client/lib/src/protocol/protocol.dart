/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:medbridge_client/src/protocol/alert.dart' as _ighnstc1;
import 'package:medbridge_client/src/protocol/care_link.dart' as _i3x46ubp;
import 'package:medbridge_client/src/protocol/dto/flagged_scan.dart'
    as _ip4xoa2x;
import 'package:medbridge_client/src/protocol/dto/patient_summary.dart'
    as _i36xms3u;
import 'package:medbridge_client/src/protocol/dto/rx_hit.dart' as _iba2asag;
import 'package:medbridge_client/src/protocol/dto/scan_history_entry.dart'
    as _irf1034y;
import 'package:medbridge_client/src/protocol/dto/schedule_view.dart'
    as _iy3ix7sn;
import 'package:medbridge_client/src/protocol/question.dart' as _ile5b8en;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'alert.dart' as _iqmz6gj4;
import 'bottle_scan.dart' as _ifld0q78;
import 'care_link.dart' as _ilhcsb3l;
import 'care_role.dart' as _ipgwqulm;
import 'discharge_plan.dart' as _iun0pa6x;
import 'dose_event.dart' as _i6sqb1u1;
import 'dose_schedule.dart' as _iqv8gzde;
import 'dose_state.dart' as _ivb9e1ub;
import 'dto/access_denied_exception.dart' as _i62njew3;
import 'dto/flagged_scan.dart' as _ix0j9q1o;
import 'dto/me_view.dart' as _iu86wh6v;
import 'dto/patient_summary.dart' as _iwqcihyo;
import 'dto/pcp_summary.dart' as _iy7eu2en;
import 'dto/plan_draft_input.dart' as _i09ss2f2;
import 'dto/plan_item_input.dart' as _ikd8eydh;
import 'dto/plan_view.dart' as _iytyh6s9;
import 'dto/recon_outcome.dart' as _irkzenra;
import 'dto/rx_hit.dart' as _i25f6c9t;
import 'dto/safety_flag_dto.dart' as _ity9sy6e;
import 'dto/scan_history_entry.dart' as _ibi54gyh;
import 'dto/scan_input.dart' as _i84iv1s5;
import 'dto/schedule_view.dart' as _itg4xv15;
import 'link_status.dart' as _i1hij6nc;
import 'patient.dart' as _ius4lr2t;
import 'plan_item_row.dart' as _iwji8ji8;
import 'plan_status.dart' as _iqzysob1;
import 'question.dart' as _in6mynjk;
import 'question_status.dart' as _ixi4rbc4;
import 'recon_row.dart' as _i4zxqgb9;
export 'alert.dart';
export 'bottle_scan.dart';
export 'care_link.dart';
export 'care_role.dart';
export 'discharge_plan.dart';
export 'dose_event.dart';
export 'dose_schedule.dart';
export 'dose_state.dart';
export 'dto/access_denied_exception.dart';
export 'dto/flagged_scan.dart';
export 'dto/me_view.dart';
export 'dto/patient_summary.dart';
export 'dto/pcp_summary.dart';
export 'dto/plan_draft_input.dart';
export 'dto/plan_item_input.dart';
export 'dto/plan_view.dart';
export 'dto/recon_outcome.dart';
export 'dto/rx_hit.dart';
export 'dto/safety_flag_dto.dart';
export 'dto/scan_history_entry.dart';
export 'dto/scan_input.dart';
export 'dto/schedule_view.dart';
export 'link_status.dart';
export 'patient.dart';
export 'plan_item_row.dart';
export 'plan_status.dart';
export 'question.dart';
export 'question_status.dart';
export 'recon_row.dart';
export 'client.dart';

class Protocol extends _isc.SerializationManager
    implements _isc.ProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _isc.ProtocolDeserialization get deserializationMetadata =>
      _isc.ProtocolDeserialization.cached(
        this,
        types: const [
          _isc.getType<_iqmz6gj4.Alert>,
          _isc.getType<_ifld0q78.BottleScan>,
          _isc.getType<_ilhcsb3l.CareLink>,
          _isc.getType<_ipgwqulm.CareRole>,
          _isc.getType<_iun0pa6x.DischargePlan>,
          _isc.getType<_i6sqb1u1.DoseEvent>,
          _isc.getType<_iqv8gzde.DoseSchedule>,
          _isc.getType<_ivb9e1ub.DoseState>,
          _isc.getType<_i62njew3.AccessDeniedException>,
          _isc.getType<_ix0j9q1o.FlaggedScan>,
          _isc.getType<_iu86wh6v.MeView>,
          _isc.getType<_iwqcihyo.PatientSummary>,
          _isc.getType<_iy7eu2en.PcpSummary>,
          _isc.getType<_i09ss2f2.PlanDraftInput>,
          _isc.getType<_ikd8eydh.PlanItemInput>,
          _isc.getType<_iytyh6s9.PlanView>,
          _isc.getType<_irkzenra.ReconOutcome>,
          _isc.getType<_i25f6c9t.RxHit>,
          _isc.getType<_ity9sy6e.SafetyFlagDto>,
          _isc.getType<_ibi54gyh.ScanHistoryEntry>,
          _isc.getType<_i84iv1s5.ScanInput>,
          _isc.getType<_itg4xv15.ScheduleView>,
          _isc.getType<_i1hij6nc.LinkStatus>,
          _isc.getType<_ius4lr2t.Patient>,
          _isc.getType<_iwji8ji8.PlanItemRow>,
          _isc.getType<_iqzysob1.PlanStatus>,
          _isc.getType<_in6mynjk.Question>,
          _isc.getType<_ixi4rbc4.QuestionStatus>,
          _isc.getType<_i4zxqgb9.ReconRow>,
          _isc.getType<_iqmz6gj4.Alert?>,
          _isc.getType<_ifld0q78.BottleScan?>,
          _isc.getType<_ilhcsb3l.CareLink?>,
          _isc.getType<_ipgwqulm.CareRole?>,
          _isc.getType<_iun0pa6x.DischargePlan?>,
          _isc.getType<_i6sqb1u1.DoseEvent?>,
          _isc.getType<_iqv8gzde.DoseSchedule?>,
          _isc.getType<_ivb9e1ub.DoseState?>,
          _isc.getType<_i62njew3.AccessDeniedException?>,
          _isc.getType<_ix0j9q1o.FlaggedScan?>,
          _isc.getType<_iu86wh6v.MeView?>,
          _isc.getType<_iwqcihyo.PatientSummary?>,
          _isc.getType<_iy7eu2en.PcpSummary?>,
          _isc.getType<_i09ss2f2.PlanDraftInput?>,
          _isc.getType<_ikd8eydh.PlanItemInput?>,
          _isc.getType<_iytyh6s9.PlanView?>,
          _isc.getType<_irkzenra.ReconOutcome?>,
          _isc.getType<_i25f6c9t.RxHit?>,
          _isc.getType<_ity9sy6e.SafetyFlagDto?>,
          _isc.getType<_ibi54gyh.ScanHistoryEntry?>,
          _isc.getType<_i84iv1s5.ScanInput?>,
          _isc.getType<_itg4xv15.ScheduleView?>,
          _isc.getType<_i1hij6nc.LinkStatus?>,
          _isc.getType<_ius4lr2t.Patient?>,
          _isc.getType<_iwji8ji8.PlanItemRow?>,
          _isc.getType<_iqzysob1.PlanStatus?>,
          _isc.getType<_in6mynjk.Question?>,
          _isc.getType<_ixi4rbc4.QuestionStatus?>,
          _isc.getType<_i4zxqgb9.ReconRow?>,
          _isc.getType<List<String>>,
          _isc.getType<List<_ius4lr2t.Patient>>,
          _isc.getType<List<_ibi54gyh.ScanHistoryEntry>>,
          _isc.getType<List<_in6mynjk.Question>>,
          _isc.getType<List<_ikd8eydh.PlanItemInput>>,
          _isc.getType<List<_iwji8ji8.PlanItemRow>>,
          _isc.getType<List<_ity9sy6e.SafetyFlagDto>>,
          _isc.getType<Map<String, String>>,
          _isc.getType<List<_i6sqb1u1.DoseEvent>>,
          _isc.getType<List<_ighnstc1.Alert>>,
          _isc.getType<List<_i3x46ubp.CareLink>>,
          _isc.getType<List<_i36xms3u.PatientSummary>>,
          _isc.getType<List<_ip4xoa2x.FlaggedScan>>,
          _isc.getType<List<String>>,
          _isc.getType<List<_ile5b8en.Question>>,
          _isc.getType<List<_iba2asag.RxHit>>,
          _isc.getType<List<_irf1034y.ScanHistoryEntry>>,
          _isc.getType<List<_iy3ix7sn.ScheduleView>>,
        ],
        modules: const [
          _iaic.Protocol.new,
          _iacc.Protocol.new,
        ],
        classNames: const [
          'Alert',
          'BottleScan',
          'CareLink',
          'CareRole',
          'DischargePlan',
          'DoseEvent',
          'DoseSchedule',
          'DoseState',
          'AccessDeniedException',
          'FlaggedScan',
          'MeView',
          'PatientSummary',
          'PcpSummary',
          'PlanDraftInput',
          'PlanItemInput',
          'PlanView',
          'ReconOutcome',
          'RxHit',
          'SafetyFlagDto',
          'ScanHistoryEntry',
          'ScanInput',
          'ScheduleView',
          'LinkStatus',
          'Patient',
          'PlanItemRow',
          'PlanStatus',
          'Question',
          'QuestionStatus',
          'ReconRow',
        ],
      );

  static String? getClassNameFromObjectJson(dynamic data) =>
      _isc.ProtocolDeserialization.readClassName(data);

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    final rawDataClassName = _isc.ProtocolDeserialization.readClassName(data);
    final dataClassName = rawDataClassName;
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _isc.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iqmz6gj4.Alert) {
      return _iqmz6gj4.Alert.fromJson(data) as T;
    }
    if (t == _ifld0q78.BottleScan) {
      return _ifld0q78.BottleScan.fromJson(data) as T;
    }
    if (t == _ilhcsb3l.CareLink) {
      return _ilhcsb3l.CareLink.fromJson(data) as T;
    }
    if (t == _ipgwqulm.CareRole) {
      return _ipgwqulm.CareRole.fromJson(data) as T;
    }
    if (t == _iun0pa6x.DischargePlan) {
      return _iun0pa6x.DischargePlan.fromJson(data) as T;
    }
    if (t == _i6sqb1u1.DoseEvent) {
      return _i6sqb1u1.DoseEvent.fromJson(data) as T;
    }
    if (t == _iqv8gzde.DoseSchedule) {
      return _iqv8gzde.DoseSchedule.fromJson(data) as T;
    }
    if (t == _ivb9e1ub.DoseState) {
      return _ivb9e1ub.DoseState.fromJson(data) as T;
    }
    if (t == _i62njew3.AccessDeniedException) {
      return _i62njew3.AccessDeniedException.fromJson(data) as T;
    }
    if (t == _ix0j9q1o.FlaggedScan) {
      return _ix0j9q1o.FlaggedScan.fromJson(data) as T;
    }
    if (t == _iu86wh6v.MeView) {
      return _iu86wh6v.MeView.fromJson(data) as T;
    }
    if (t == _iwqcihyo.PatientSummary) {
      return _iwqcihyo.PatientSummary.fromJson(data) as T;
    }
    if (t == _iy7eu2en.PcpSummary) {
      return _iy7eu2en.PcpSummary.fromJson(data) as T;
    }
    if (t == _i09ss2f2.PlanDraftInput) {
      return _i09ss2f2.PlanDraftInput.fromJson(data) as T;
    }
    if (t == _ikd8eydh.PlanItemInput) {
      return _ikd8eydh.PlanItemInput.fromJson(data) as T;
    }
    if (t == _iytyh6s9.PlanView) {
      return _iytyh6s9.PlanView.fromJson(data) as T;
    }
    if (t == _irkzenra.ReconOutcome) {
      return _irkzenra.ReconOutcome.fromJson(data) as T;
    }
    if (t == _i25f6c9t.RxHit) {
      return _i25f6c9t.RxHit.fromJson(data) as T;
    }
    if (t == _ity9sy6e.SafetyFlagDto) {
      return _ity9sy6e.SafetyFlagDto.fromJson(data) as T;
    }
    if (t == _ibi54gyh.ScanHistoryEntry) {
      return _ibi54gyh.ScanHistoryEntry.fromJson(data) as T;
    }
    if (t == _i84iv1s5.ScanInput) {
      return _i84iv1s5.ScanInput.fromJson(data) as T;
    }
    if (t == _itg4xv15.ScheduleView) {
      return _itg4xv15.ScheduleView.fromJson(data) as T;
    }
    if (t == _i1hij6nc.LinkStatus) {
      return _i1hij6nc.LinkStatus.fromJson(data) as T;
    }
    if (t == _ius4lr2t.Patient) {
      return _ius4lr2t.Patient.fromJson(data) as T;
    }
    if (t == _iwji8ji8.PlanItemRow) {
      return _iwji8ji8.PlanItemRow.fromJson(data) as T;
    }
    if (t == _iqzysob1.PlanStatus) {
      return _iqzysob1.PlanStatus.fromJson(data) as T;
    }
    if (t == _in6mynjk.Question) {
      return _in6mynjk.Question.fromJson(data) as T;
    }
    if (t == _ixi4rbc4.QuestionStatus) {
      return _ixi4rbc4.QuestionStatus.fromJson(data) as T;
    }
    if (t == _i4zxqgb9.ReconRow) {
      return _i4zxqgb9.ReconRow.fromJson(data) as T;
    }
    if (t == _isc.getType<_iqmz6gj4.Alert?>()) {
      return (data != null ? _iqmz6gj4.Alert.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ifld0q78.BottleScan?>()) {
      return (data != null ? _ifld0q78.BottleScan.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ilhcsb3l.CareLink?>()) {
      return (data != null ? _ilhcsb3l.CareLink.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ipgwqulm.CareRole?>()) {
      return (data != null ? _ipgwqulm.CareRole.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iun0pa6x.DischargePlan?>()) {
      return (data != null ? _iun0pa6x.DischargePlan.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i6sqb1u1.DoseEvent?>()) {
      return (data != null ? _i6sqb1u1.DoseEvent.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqv8gzde.DoseSchedule?>()) {
      return (data != null ? _iqv8gzde.DoseSchedule.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ivb9e1ub.DoseState?>()) {
      return (data != null ? _ivb9e1ub.DoseState.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i62njew3.AccessDeniedException?>()) {
      return (data != null
              ? _i62njew3.AccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _isc.getType<_ix0j9q1o.FlaggedScan?>()) {
      return (data != null ? _ix0j9q1o.FlaggedScan.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iu86wh6v.MeView?>()) {
      return (data != null ? _iu86wh6v.MeView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwqcihyo.PatientSummary?>()) {
      return (data != null ? _iwqcihyo.PatientSummary.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iy7eu2en.PcpSummary?>()) {
      return (data != null ? _iy7eu2en.PcpSummary.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i09ss2f2.PlanDraftInput?>()) {
      return (data != null ? _i09ss2f2.PlanDraftInput.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ikd8eydh.PlanItemInput?>()) {
      return (data != null ? _ikd8eydh.PlanItemInput.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_iytyh6s9.PlanView?>()) {
      return (data != null ? _iytyh6s9.PlanView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_irkzenra.ReconOutcome?>()) {
      return (data != null ? _irkzenra.ReconOutcome.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i25f6c9t.RxHit?>()) {
      return (data != null ? _i25f6c9t.RxHit.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ity9sy6e.SafetyFlagDto?>()) {
      return (data != null ? _ity9sy6e.SafetyFlagDto.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_ibi54gyh.ScanHistoryEntry?>()) {
      return (data != null ? _ibi54gyh.ScanHistoryEntry.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i84iv1s5.ScanInput?>()) {
      return (data != null ? _i84iv1s5.ScanInput.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_itg4xv15.ScheduleView?>()) {
      return (data != null ? _itg4xv15.ScheduleView.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_i1hij6nc.LinkStatus?>()) {
      return (data != null ? _i1hij6nc.LinkStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ius4lr2t.Patient?>()) {
      return (data != null ? _ius4lr2t.Patient.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iwji8ji8.PlanItemRow?>()) {
      return (data != null ? _iwji8ji8.PlanItemRow.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_iqzysob1.PlanStatus?>()) {
      return (data != null ? _iqzysob1.PlanStatus.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_in6mynjk.Question?>()) {
      return (data != null ? _in6mynjk.Question.fromJson(data) : null) as T;
    }
    if (t == _isc.getType<_ixi4rbc4.QuestionStatus?>()) {
      return (data != null ? _ixi4rbc4.QuestionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _isc.getType<_i4zxqgb9.ReconRow?>()) {
      return (data != null ? _i4zxqgb9.ReconRow.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ius4lr2t.Patient>) {
      return (data as List)
              .map((e) => deserialize<_ius4lr2t.Patient>(e))
              .toList()
          as T;
    }
    if (t == List<_ibi54gyh.ScanHistoryEntry>) {
      return (data as List)
              .map((e) => deserialize<_ibi54gyh.ScanHistoryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_in6mynjk.Question>) {
      return (data as List)
              .map((e) => deserialize<_in6mynjk.Question>(e))
              .toList()
          as T;
    }
    if (t == List<_ikd8eydh.PlanItemInput>) {
      return (data as List)
              .map((e) => deserialize<_ikd8eydh.PlanItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_iwji8ji8.PlanItemRow>) {
      return (data as List)
              .map((e) => deserialize<_iwji8ji8.PlanItemRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ity9sy6e.SafetyFlagDto>) {
      return (data as List)
              .map((e) => deserialize<_ity9sy6e.SafetyFlagDto>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i6sqb1u1.DoseEvent>) {
      return (data as List)
              .map((e) => deserialize<_i6sqb1u1.DoseEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ighnstc1.Alert>) {
      return (data as List).map((e) => deserialize<_ighnstc1.Alert>(e)).toList()
          as T;
    }
    if (t == List<_i3x46ubp.CareLink>) {
      return (data as List)
              .map((e) => deserialize<_i3x46ubp.CareLink>(e))
              .toList()
          as T;
    }
    if (t == List<_i36xms3u.PatientSummary>) {
      return (data as List)
              .map((e) => deserialize<_i36xms3u.PatientSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_ip4xoa2x.FlaggedScan>) {
      return (data as List)
              .map((e) => deserialize<_ip4xoa2x.FlaggedScan>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ile5b8en.Question>) {
      return (data as List)
              .map((e) => deserialize<_ile5b8en.Question>(e))
              .toList()
          as T;
    }
    if (t == List<_iba2asag.RxHit>) {
      return (data as List).map((e) => deserialize<_iba2asag.RxHit>(e)).toList()
          as T;
    }
    if (t == List<_irf1034y.ScanHistoryEntry>) {
      return (data as List)
              .map((e) => deserialize<_irf1034y.ScanHistoryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_iy3ix7sn.ScheduleView>) {
      return (data as List)
              .map((e) => deserialize<_iy3ix7sn.ScheduleView>(e))
              .toList()
          as T;
    }
    final modules = deserializationMetadata.modulesForDeserialization(
      t,
      className: rawDataClassName,
    );
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _isc.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iqmz6gj4.Alert => 'Alert',
      _ifld0q78.BottleScan => 'BottleScan',
      _ilhcsb3l.CareLink => 'CareLink',
      _ipgwqulm.CareRole => 'CareRole',
      _iun0pa6x.DischargePlan => 'DischargePlan',
      _i6sqb1u1.DoseEvent => 'DoseEvent',
      _iqv8gzde.DoseSchedule => 'DoseSchedule',
      _ivb9e1ub.DoseState => 'DoseState',
      _i62njew3.AccessDeniedException => 'AccessDeniedException',
      _ix0j9q1o.FlaggedScan => 'FlaggedScan',
      _iu86wh6v.MeView => 'MeView',
      _iwqcihyo.PatientSummary => 'PatientSummary',
      _iy7eu2en.PcpSummary => 'PcpSummary',
      _i09ss2f2.PlanDraftInput => 'PlanDraftInput',
      _ikd8eydh.PlanItemInput => 'PlanItemInput',
      _iytyh6s9.PlanView => 'PlanView',
      _irkzenra.ReconOutcome => 'ReconOutcome',
      _i25f6c9t.RxHit => 'RxHit',
      _ity9sy6e.SafetyFlagDto => 'SafetyFlagDto',
      _ibi54gyh.ScanHistoryEntry => 'ScanHistoryEntry',
      _i84iv1s5.ScanInput => 'ScanInput',
      _itg4xv15.ScheduleView => 'ScheduleView',
      _i1hij6nc.LinkStatus => 'LinkStatus',
      _ius4lr2t.Patient => 'Patient',
      _iwji8ji8.PlanItemRow => 'PlanItemRow',
      _iqzysob1.PlanStatus => 'PlanStatus',
      _in6mynjk.Question => 'Question',
      _ixi4rbc4.QuestionStatus => 'QuestionStatus',
      _i4zxqgb9.ReconRow => 'ReconRow',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('medbridge.', '');
    }

    switch (data) {
      case _iqmz6gj4.Alert():
        return 'Alert';
      case _ifld0q78.BottleScan():
        return 'BottleScan';
      case _ilhcsb3l.CareLink():
        return 'CareLink';
      case _ipgwqulm.CareRole():
        return 'CareRole';
      case _iun0pa6x.DischargePlan():
        return 'DischargePlan';
      case _i6sqb1u1.DoseEvent():
        return 'DoseEvent';
      case _iqv8gzde.DoseSchedule():
        return 'DoseSchedule';
      case _ivb9e1ub.DoseState():
        return 'DoseState';
      case _i62njew3.AccessDeniedException():
        return 'AccessDeniedException';
      case _ix0j9q1o.FlaggedScan():
        return 'FlaggedScan';
      case _iu86wh6v.MeView():
        return 'MeView';
      case _iwqcihyo.PatientSummary():
        return 'PatientSummary';
      case _iy7eu2en.PcpSummary():
        return 'PcpSummary';
      case _i09ss2f2.PlanDraftInput():
        return 'PlanDraftInput';
      case _ikd8eydh.PlanItemInput():
        return 'PlanItemInput';
      case _iytyh6s9.PlanView():
        return 'PlanView';
      case _irkzenra.ReconOutcome():
        return 'ReconOutcome';
      case _i25f6c9t.RxHit():
        return 'RxHit';
      case _ity9sy6e.SafetyFlagDto():
        return 'SafetyFlagDto';
      case _ibi54gyh.ScanHistoryEntry():
        return 'ScanHistoryEntry';
      case _i84iv1s5.ScanInput():
        return 'ScanInput';
      case _itg4xv15.ScheduleView():
        return 'ScheduleView';
      case _i1hij6nc.LinkStatus():
        return 'LinkStatus';
      case _ius4lr2t.Patient():
        return 'Patient';
      case _iwji8ji8.PlanItemRow():
        return 'PlanItemRow';
      case _iqzysob1.PlanStatus():
        return 'PlanStatus';
      case _in6mynjk.Question():
        return 'Question';
      case _ixi4rbc4.QuestionStatus():
        return 'QuestionStatus';
      case _i4zxqgb9.ReconRow():
        return 'ReconRow';
    }
    className = _iaic.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacc.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Alert') {
      return deserialize<_iqmz6gj4.Alert>(data['data']);
    }
    if (dataClassName == 'BottleScan') {
      return deserialize<_ifld0q78.BottleScan>(data['data']);
    }
    if (dataClassName == 'CareLink') {
      return deserialize<_ilhcsb3l.CareLink>(data['data']);
    }
    if (dataClassName == 'CareRole') {
      return deserialize<_ipgwqulm.CareRole>(data['data']);
    }
    if (dataClassName == 'DischargePlan') {
      return deserialize<_iun0pa6x.DischargePlan>(data['data']);
    }
    if (dataClassName == 'DoseEvent') {
      return deserialize<_i6sqb1u1.DoseEvent>(data['data']);
    }
    if (dataClassName == 'DoseSchedule') {
      return deserialize<_iqv8gzde.DoseSchedule>(data['data']);
    }
    if (dataClassName == 'DoseState') {
      return deserialize<_ivb9e1ub.DoseState>(data['data']);
    }
    if (dataClassName == 'AccessDeniedException') {
      return deserialize<_i62njew3.AccessDeniedException>(data['data']);
    }
    if (dataClassName == 'FlaggedScan') {
      return deserialize<_ix0j9q1o.FlaggedScan>(data['data']);
    }
    if (dataClassName == 'MeView') {
      return deserialize<_iu86wh6v.MeView>(data['data']);
    }
    if (dataClassName == 'PatientSummary') {
      return deserialize<_iwqcihyo.PatientSummary>(data['data']);
    }
    if (dataClassName == 'PcpSummary') {
      return deserialize<_iy7eu2en.PcpSummary>(data['data']);
    }
    if (dataClassName == 'PlanDraftInput') {
      return deserialize<_i09ss2f2.PlanDraftInput>(data['data']);
    }
    if (dataClassName == 'PlanItemInput') {
      return deserialize<_ikd8eydh.PlanItemInput>(data['data']);
    }
    if (dataClassName == 'PlanView') {
      return deserialize<_iytyh6s9.PlanView>(data['data']);
    }
    if (dataClassName == 'ReconOutcome') {
      return deserialize<_irkzenra.ReconOutcome>(data['data']);
    }
    if (dataClassName == 'RxHit') {
      return deserialize<_i25f6c9t.RxHit>(data['data']);
    }
    if (dataClassName == 'SafetyFlagDto') {
      return deserialize<_ity9sy6e.SafetyFlagDto>(data['data']);
    }
    if (dataClassName == 'ScanHistoryEntry') {
      return deserialize<_ibi54gyh.ScanHistoryEntry>(data['data']);
    }
    if (dataClassName == 'ScanInput') {
      return deserialize<_i84iv1s5.ScanInput>(data['data']);
    }
    if (dataClassName == 'ScheduleView') {
      return deserialize<_itg4xv15.ScheduleView>(data['data']);
    }
    if (dataClassName == 'LinkStatus') {
      return deserialize<_i1hij6nc.LinkStatus>(data['data']);
    }
    if (dataClassName == 'Patient') {
      return deserialize<_ius4lr2t.Patient>(data['data']);
    }
    if (dataClassName == 'PlanItemRow') {
      return deserialize<_iwji8ji8.PlanItemRow>(data['data']);
    }
    if (dataClassName == 'PlanStatus') {
      return deserialize<_iqzysob1.PlanStatus>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_in6mynjk.Question>(data['data']);
    }
    if (dataClassName == 'QuestionStatus') {
      return deserialize<_ixi4rbc4.QuestionStatus>(data['data']);
    }
    if (dataClassName == 'ReconRow') {
      return deserialize<_i4zxqgb9.ReconRow>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      return _iaic.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(19),
      });
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      return _iacc.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(20),
      });
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iaic.Protocol().registerHostProtocol('medbridge', this);
    _iacc.Protocol().registerHostProtocol('medbridge', this);
  }

  @override
  String getModuleName() => 'medbridge';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iaic.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacc.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
