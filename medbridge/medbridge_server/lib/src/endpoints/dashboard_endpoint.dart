import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../services/plan_repository.dart';
import 'scan_endpoint.dart';

/// Clinician dashboard data (A10 `dashboard`, F10). Clinical roles only;
/// only linked patients are ever returned.
class DashboardEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<int>> _linkedPatientIds(Session session) async {
    await requireRole(session, Roles.clinicianRoles);
    final links = await CareLink.db.find(
      session,
      where: (t) =>
          t.userId.equals(callerId(session)) &
          t.status.equals(LinkStatus.active) &
          t.role.notEquals(CareRole.caregiver),
    );
    return [for (final l in links) l.patientId];
  }

  /// Linked patients with red / amber counts, red-first.
  Future<List<PatientSummary>> patients(Session session) async {
    final ids = await _linkedPatientIds(session);
    final out = <PatientSummary>[];
    for (final id in ids) {
      final p = (await Patient.db.findById(session, id))!;
      final history = await ScanEndpoint.historyFor(session, id);
      final open = await Question.db.count(
        session,
        where: (t) =>
            t.patientId.equals(id) & t.status.equals(QuestionStatus.open),
      );
      final plan = await PlanRepository.latest(session, id);
      bool unresolved(ScanHistoryEntry e, String sev) =>
          e.recon.sev == sev && e.recon.resolvedNote == null;
      out.add(
        PatientSummary(
          patientId: id,
          firstName: p.firstName,
          birthYear: p.birthYear,
          planId: plan?.plan.id,
          planStatus: plan?.plan.status.name,
          redCount: history.where((e) => unresolved(e, 'red')).length,
          amberCount: history.where((e) => unresolved(e, 'amber')).length,
          openQuestions: open,
          lastScanAt: history.isEmpty ? null : history.first.scan.scannedAt,
        ),
      );
    }
    await audit(session, 'read', 'dashboard.patients', ids.length);
    return out..sort((a, b) {
      final c = b.redCount.compareTo(a.redCount);
      return c != 0 ? c : b.amberCount.compareTo(a.amberCount);
    });
  }

  /// Red and amber results across linked patients, red first, newest first.
  Future<List<FlaggedScan>> flagged(Session session) async {
    final ids = await _linkedPatientIds(session);
    final out = <FlaggedScan>[];
    for (final id in ids) {
      final p = (await Patient.db.findById(session, id))!;
      for (final e in await ScanEndpoint.historyFor(session, id)) {
        if (e.recon.sev != 'red' && e.recon.sev != 'amber') continue;
        out.add(
          FlaggedScan(
            reconId: e.recon.id!,
            patientId: id,
            patientName: p.firstName,
            scanName: e.scan.name,
            status: e.recon.status,
            reason: e.recon.reason,
            sev: e.recon.sev,
            createdAt: e.recon.createdAt,
            resolvedNote: e.recon.resolvedNote,
          ),
        );
      }
    }
    await audit(session, 'read', 'dashboard.flagged', ids.length);
    return out..sort((a, b) {
      final c = (b.sev == 'red' ? 1 : 0).compareTo(a.sev == 'red' ? 1 : 0);
      return c != 0 ? c : b.createdAt.compareTo(a.createdAt);
    });
  }

  /// Read-only PCP summary for one linked patient.
  Future<PcpSummary> summary(Session session, int patientId) async {
    await requireRole(session, Roles.clinicianRoles);
    final p = await requireLink(
      session,
      patientId: patientId,
      roles: clinicalCareRoles,
    );
    await audit(session, 'read', 'dashboard.summary', patientId);
    return PcpSummary(
      patient: p,
      plan: await PlanRepository.latest(session, patientId),
      history: await ScanEndpoint.historyFor(session, patientId),
      questions: await Question.db.find(
        session,
        where: (t) => t.patientId.equals(patientId),
        orderBy: (t) => t.createdAt.desc(),
      ),
    );
  }

  /// Marks a flagged result as reviewed, with a note.
  Future<ReconRow> resolveFlag(
    Session session,
    int reconId,
    String note,
  ) async {
    await requireRole(session, Roles.clinicianRoles);
    final recon = await ReconRow.db.findById(session, reconId);
    final scan = recon == null
        ? null
        : await BottleScan.db.findById(session, recon.scanId);
    if (scan == null) throw AccessDeniedException(message: 'Not found.');
    await requireLink(
      session,
      patientId: scan.patientId,
      roles: clinicalCareRoles,
    );
    await audit(session, 'write', 'recon.resolve', reconId);
    return ReconRow.db.updateRow(
      session,
      recon!.copyWith(resolvedNote: note.trim(), resolvedBy: callerId(session)),
    );
  }
}
