import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'push_sender.dart';

/// Caregiver alerts (F7). Every alert is logged; push text has no PHI.
abstract final class AlertService {
  /// The push transport. Replaced at startup when FCM credentials exist.
  static PushSender sender = const LogPushSender();

  /// Logs an alert to every active caregiver of [patient] and pushes a
  /// PHI-free message. Idempotent per [dedupeKey].
  static Future<Alert?> raise(
    Session session,
    Patient patient, {
    required String type,
    required String sev,
    required String dedupeKey,
    Transaction? transaction,
  }) async {
    final existing = await Alert.db.findFirstRow(
      session,
      where: (t) => t.dedupeKey.equals(dedupeKey),
      transaction: transaction,
    );
    if (existing != null) return existing;
    final links = await CareLink.db.find(
      session,
      where: (t) =>
          t.patientId.equals(patient.id!) &
          t.role.equals(CareRole.caregiver) &
          t.status.equals(LinkStatus.active),
      transaction: transaction,
    );
    final recipients = [
      for (final l in links)
        if (l.userId != null) l.userId!.toString(),
    ];
    final alert = await Alert.db.insertRow(
      session,
      Alert(
        patientId: patient.id!,
        type: type,
        sev: sev,
        dedupeKey: dedupeKey,
        recipientsJson: jsonEncode(recipients),
      ),
      transaction: transaction,
    );
    if (recipients.isNotEmpty) {
      await sender.send(session, recipients, pushText(patient.firstName));
    }
    return alert;
  }

  /// The only push text ever sent: no drug names, no results (F7).
  static String pushText(String firstName) =>
      "MedBridge: please check on $firstName's medications";
}
