import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';
import '../services/scan_service.dart';

/// Bottle scans (A10 `scan`, F3/F4).
class ScanEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Submits a confirmed scan. The server re-runs reconcile with the shipped
  /// rules and returns the authoritative result.
  Future<ReconOutcome> submit(Session session, ScanInput input) async {
    final patient = await requireLink(session);
    final outcome = await ScanService.submit(session, patient, input);
    await audit(session, 'write', 'scan', outcome.scanId);
    return outcome;
  }

  /// Scan history, newest first.
  Future<List<ScanHistoryEntry>> history(
    Session session, {
    int? patientId,
  }) async {
    final patient = await requireLink(
      session,
      patientId: patientId,
      roles: anyCareRole,
    );
    await audit(session, 'read', 'scan.history', patient.id!);
    return historyFor(session, patient.id!);
  }

  /// Records "I've set this bottle aside" for a Stop / Duplicate result.
  Future<BottleScan> setAside(Session session, int scanId) async {
    final patient = await requireLink(session);
    final scan = await BottleScan.db.findById(session, scanId);
    if (scan == null || scan.patientId != patient.id) {
      throw AccessDeniedException(message: 'Not your scan.');
    }
    await audit(session, 'write', 'scan.setAside', scanId);
    return BottleScan.db.updateRow(session, scan.copyWith(setAside: true));
  }

  /// Shared with the dashboard summary.
  static Future<List<ScanHistoryEntry>> historyFor(
    Session session,
    int patientId,
  ) async {
    final scans = await BottleScan.db.find(
      session,
      where: (t) => t.patientId.equals(patientId),
      orderBy: (t) => t.id.desc(),
    );
    if (scans.isEmpty) return [];
    final recons = await ReconRow.db.find(
      session,
      where: (t) => t.scanId.inSet({for (final s in scans) s.id!}),
    );
    final byScan = {for (final r in recons) r.scanId: r};
    return [
      for (final s in scans)
        if (byScan[s.id] != null)
          ScanHistoryEntry(scan: s, recon: byScan[s.id]!),
    ];
  }
}
