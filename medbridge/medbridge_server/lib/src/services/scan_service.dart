import 'dart:convert';

import 'package:med_core/med_core.dart' as core;
import 'package:serverpod/serverpod.dart';

import '../core/adapters.dart';
import '../generated/protocol.dart';
import 'alert_service.dart';
import 'plan_repository.dart';

/// Authoritative scan handling (B5 step 6): re-run reconcile with the
/// shipped rules, persist, then raise the Question and alert A8.4 #4 needs.
abstract final class ScanService {
  /// Reconciles and stores one confirmed scan for [patient].
  static Future<ReconOutcome> submit(
    Session session,
    Patient patient,
    ScanInput input,
  ) async {
    final rules = core.ShippedRules.ruleSet;
    final plan = await PlanRepository.corePlan(session, patient.id!);
    final scan = scanToCore(input);
    final result = core.reconcileWithSafety(plan, scan, rules);
    return session.db.transaction((tx) async {
      final stored = await BottleScan.db.insertRow(
        session,
        BottleScan(
          patientId: patient.id!,
          ndc11: input.ndc11,
          rxcui: input.rxcui,
          name: input.name,
          ingsJson: encodeList(scan.ings),
          strength: scan.strength?.display ?? '',
          form: input.form,
          sigRaw: input.sigRaw,
          sigJson: scan.sig == null ? null : jsonEncode(scan.sig!.toJson()),
          ocrText: input.ocrText,
          conf: input.conf,
          confirmed: input.confirmed,
          classIdsJson: encodeList(input.classIds),
        ),
        transaction: tx,
      );
      final itemRow = await _itemRow(session, patient.id!, result.itemId, tx);
      final recon = await ReconRow.db.insertRow(
        session,
        ReconRow(
          scanId: stored.id!,
          planItemId: itemRow?.id,
          itemKey: result.itemId,
          status: result.status.name,
          reason: result.reason,
          sev: result.sev.name,
          flagsJson: jsonEncode([
            for (final f in result.flags) {'code': f.code, 'sev': f.sev.name},
          ]),
          paramsJson: jsonEncode(result.params),
          ruleVersion: result.ruleVersion,
        ),
        transaction: tx,
      );
      Question? question;
      if (result.createsQuestion) {
        question = await Question.db.insertRow(
          session,
          Question(
            patientId: patient.id!,
            text: autoQuestionText(result, input.name),
            source: 'auto',
            linkedReconId: recon.id,
          ),
          transaction: tx,
        );
      }
      if (result.createsFlag) {
        await AlertService.raise(
          session,
          patient,
          type: 'red_result',
          sev: result.sev.name,
          dedupeKey: 'red:${recon.id}',
          transaction: tx,
        );
      }
      return ReconOutcome(
        reconId: recon.id!,
        scanId: stored.id!,
        status: result.status.name,
        reason: result.reason,
        sev: result.sev.name,
        itemKey: result.itemId,
        flags: flagsToDto(result.flags),
        ruleVersion: result.ruleVersion,
        params: result.params,
        questionId: question?.id,
        needsAcknowledgment: result.needsAcknowledgment,
      );
    });
  }

  static Future<PlanItemRow?> _itemRow(
    Session session,
    int patientId,
    String? itemKey,
    Transaction tx,
  ) async {
    if (itemKey == null) return null;
    final view = await PlanRepository.latest(session, patientId);
    if (view == null) return null;
    for (final row in view.items) {
      if (row.itemKey == itemKey) return row;
    }
    return null;
  }

  /// Plain-language text of an auto-created Question, linked to its source.
  static String autoQuestionText(core.ReconResult r, String bottle) {
    final planMed = r.params['planMed'];
    final ddi = r.flags.where((f) => f.kind == core.SafetyKind.interaction);
    final allergy = r.flags.where((f) => f.kind == core.SafetyKind.allergy);
    if (allergy.isNotEmpty) {
      return 'Allergy alert: "$bottle" matches a listed allergy. '
          'What should I do with it?';
    }
    return switch (r.reasonCode) {
      'PLAN_STOP' =>
        'My care team stopped "$bottle". What should I do with it?',
      'OLD_STRENGTH_BOTTLE' =>
        'My dose of "$planMed" changed. Can I still use this bottle '
            '("$bottle")?',
      'SAME_CLASS_AS' =>
        '"$bottle" may do the same job as "$planMed". Should I take both?',
      'NOT_ON_PLAN' =>
        '"$bottle" is not on my discharge plan. Should I take it?',
      'LOW_CONFIDENCE' =>
        'The app could not read "$bottle" clearly. Is it on my plan?',
      'SIG_UNSUPPORTED' =>
        'How exactly should I take "$planMed"? The directions are complex.',
      _ when ddi.isNotEmpty =>
        '"$bottle" may interact with another medicine (${ddi.first.detail}). '
            'Is it safe?',
      _ => 'Please check "$bottle" against my discharge plan.',
    };
  }
}
