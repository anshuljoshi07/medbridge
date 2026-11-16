import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';

/// Caregiver alerts (A10 `alerts`, F7). Dispatch runs as a future call.
class AlertsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Alerts for a patient the caller is linked to, newest first.
  Future<List<Alert>> list(Session session, {int? patientId}) async {
    final p = await requireLink(
      session,
      patientId: patientId,
      roles: anyCareRole,
    );
    await audit(session, 'read', 'alerts', p.id!);
    return Alert.db.find(
      session,
      where: (t) => t.patientId.equals(p.id!),
      orderBy: (t) => t.sentAt.desc(),
      limit: 50,
    );
  }

  /// Acknowledges an alert.
  Future<Alert> ack(Session session, int alertId) async {
    final alert = await Alert.db.findById(session, alertId);
    if (alert == null) throw AccessDeniedException(message: 'Not found.');
    await requireLink(session, patientId: alert.patientId, roles: anyCareRole);
    await audit(session, 'write', 'alert.ack', alertId);
    return Alert.db.updateRow(
      session,
      alert.copyWith(ackAt: DateTime.now().toUtc()),
    );
  }
}
