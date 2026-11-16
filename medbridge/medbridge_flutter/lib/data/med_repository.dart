import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_core/med_core.dart' as core;
import 'package:medbridge_client/medbridge_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../core/providers.dart';
import 'adapters.dart';

/// The single write path to the server. Widgets and ViewModels never call
/// the client directly.
class MedRepository {
  MedRepository(this._client);
  final Client _client;

  // Session ---------------------------------------------------------------
  Future<MeView> me() => _client.patient.me();

  Future<MeView> register(String role, String firstName, String lang) =>
      _client.patient.register(role, firstName, lang, deviceUtcOffsetMin());

  Future<void> setAllergies(List<String> allergies) =>
      _client.patient.setAllergies(allergies);

  Future<void> updateLang(String lang) =>
      _client.patient.updatePrefs(lang, deviceUtcOffsetMin());

  Future<void> signOut() => _client.auth.signOutDevice();

  // Plan ------------------------------------------------------------------
  /// Parses AVS text on the device (pure med_core, works offline).
  core.PlanDraft parseAvsText(String text, core.Lexicon lx) => core.parseAvs(
    [
      for (final (i, l) in text.split('\n').indexed)
        if (l.trim().isNotEmpty) core.OcrLine(l.trim(), page: i ~/ 60),
    ],
    lx,
    core.ShippedRules.avsRules,
    core.ShippedRules.sigRules,
    core.ShippedRules.ruleSet.config,
  );

  /// Uploads the reviewed draft and confirms it (draft → unverified).
  Future<PlanView> confirmPlan(core.PlanDraft draft) async {
    final uploaded = await _client.plan.uploadDraft(draftToInput(draft));
    return _client.plan.confirm(uploaded.plan.id!);
  }

  Future<PlanView?> plan({int? patientId}) =>
      _client.plan.get(patientId: patientId);

  // Scans -----------------------------------------------------------------
  core.ScanDraft parseLabel(
    List<List<String>> frames,
    core.Lexicon lx,
    core.Plan? ctx,
  ) => core.parseLabel(
    [
      for (final f in frames) core.OcrFrame([for (final l in f) core.OcrLine(l)]),
    ],
    lx,
    ctx,
    core.ShippedRules.ruleSet,
    core.ShippedRules.sigRules,
  );

  Future<ReconOutcome> submitScan(ScanInput input) =>
      _client.scan.submit(input);

  Future<List<ScanHistoryEntry>> history({int? patientId}) =>
      _client.scan.history(patientId: patientId);

  Future<void> setAside(int scanId) => _client.scan.setAside(scanId);

  // Schedule --------------------------------------------------------------
  Future<List<ScheduleView>> schedule({int? patientId}) =>
      _client.schedule.get(patientId: patientId);

  Future<DoseEvent> logDose(int scheduleId, DateTime dueAt, DoseState s) =>
      _client.schedule.logDose(scheduleId, dueAt, s);

  // Questions -------------------------------------------------------------
  Future<List<Question>> questions({int? patientId}) =>
      _client.questions.list(patientId: patientId);

  Future<Question> addQuestion(String text, {int? patientId}) =>
      _client.questions.add(text, patientId: patientId);

  // Care team -------------------------------------------------------------
  Future<CareLink> createInvite(CareRole role) =>
      _client.care.createInvite(role);
  Future<CareLink> acceptInvite(String code) => _client.care.acceptInvite(code);
  Future<CareLink> revoke(int linkId) => _client.care.revoke(linkId);
  Future<List<CareLink>> links() => _client.care.links();
}

final repositoryProvider = Provider<MedRepository>(
  (ref) => MedRepository(ref.watch(clientProvider)),
);
