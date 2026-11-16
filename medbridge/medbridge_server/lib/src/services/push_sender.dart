import 'package:serverpod/serverpod.dart';

/// Sends a push notification to users. Text must never contain PHI.
abstract interface class PushSender {
  /// Sends [text] to [userIds].
  Future<void> send(Session session, List<String> userIds, String text);
}

/// Development sender: logs instead of pushing. Used until the FCM service
/// account (HUMAN item, B0) is configured.
final class LogPushSender implements PushSender {
  /// Creates the logging sender.
  const LogPushSender();

  @override
  Future<void> send(Session session, List<String> userIds, String text) async {
    session.log('push → ${userIds.length} recipient(s): $text');
  }
}
