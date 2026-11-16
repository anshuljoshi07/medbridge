import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../services/rx_client.dart';

/// RxNav proxy (A10 `rx`): cached, throttled, no PHI sent upstream.
class RxEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// RxCUIs for an NDC (barcode or printed).
  Future<List<RxHit>> byNdc(Session session, String ndc) =>
      RxClient.byNdc(session, ndc);

  /// Approximate drug-name match.
  Future<List<RxHit>> approximate(Session session, String term) =>
      RxClient.approximate(session, term);

  /// ATC level-4 classes for an RxCUI.
  Future<List<String>> classesFor(Session session, String rxcui) =>
      RxClient.classesFor(session, rxcui);
}
