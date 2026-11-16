import 'package:serverpod/serverpod.dart';

import '../services/dose_monitor.dart';

/// Scheduled every 15 minutes from `server.dart` (A10 `alerts` dispatcher).
class AlertDispatcherFutureCall extends FutureCall {
  /// One dispatcher pass.
  Future<void> dispatch(Session session) async {
    await DoseMonitor.runDispatch(session, DateTime.now().toUtc());
  }
}
