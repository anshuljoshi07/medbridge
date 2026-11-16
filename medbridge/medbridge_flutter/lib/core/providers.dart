import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_core/med_core.dart';
import 'package:medbridge_client/medbridge_client.dart';

/// The Serverpod client, created once in `bootstrap()` and overridden there.
final clientProvider = Provider<Client>(
  (ref) => throw StateError('clientProvider must be overridden in bootstrap'),
);

/// The shipped rule set (same version as the server).
final rulesProvider = Provider<RuleSet>((ref) => ShippedRules.ruleSet);

/// The RxNorm name lexicon, loaded from the med_core asset once.
final lexiconProvider = FutureProvider<Lexicon>((ref) async {
  final tsv = await rootBundle.loadString(
    'packages/med_core/assets/lexicon.tsv',
  );
  return Lexicon.fromTsv(tsv);
});

/// Minutes east of UTC on this device, read once per call so that a
/// time-zone change is picked up on the next reminder computation.
int deviceUtcOffsetMin() => DateTime.now().timeZoneOffset.inMinutes;
