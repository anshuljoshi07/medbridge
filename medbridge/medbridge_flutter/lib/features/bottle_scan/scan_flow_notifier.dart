import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_core/med_core.dart';
import 'package:medbridge_client/medbridge_client.dart' show ReconOutcome;

import '../../core/providers.dart';
import '../../data/adapters.dart';
import '../../data/app_data.dart';
import '../../data/med_repository.dart';

/// Synthetic sample bottles (B10 + a LASA case) for testing without a camera.
const sampleBottles = [
  ('lisinopril 10 mg tablet', 'Take 1 tablet by mouth daily'),
  ('losartan potassium 50 mg tab', 'Take 1 tablet by mouth daily'),
  ('metoprolol succ ER 50 mg tab', 'Take 1 tablet by mouth daily'),
  ('atorvastatin 40 mg tablet', 'Take 1 tablet by mouth at bedtime'),
  ('metformin HCl 500 mg tablet', 'Take 1 tablet by mouth twice daily'),
  ('benazepril 20 mg tablet', 'Take 1 tablet by mouth daily'),
  ('omeprazole DR 20 mg capsule', 'Take 1 capsule by mouth daily'),
  ('hydroxyzine HCl 25 mg tablet', 'Take 1 tablet by mouth three times daily'),
];

/// The result shown on the Result screen: the server's authoritative
/// outcome, or (offline) the identical on-device reconcile.
class ShownResult {
  const ShownResult({
    required this.status,
    required this.reason,
    required this.sev,
    required this.params,
    required this.flagKinds,
    required this.offline,
    this.itemKey,
    this.scanId,
  });

  final ReconStatus status;
  final String reason;
  final Severity sev;
  final Map<String, String> params;
  final List<SafetyKind> flagKinds;
  final bool offline;
  final String? itemKey;
  final int? scanId;

  bool get needsAcknowledgment =>
      status == ReconStatus.stop || status == ReconStatus.duplicate;
}

class ScanFlowState {
  const ScanFlowState({this.draft, this.chosen, this.result});
  final ScanDraft? draft;
  final LexMatch? chosen;
  final ShownResult? result;
}

class ScanFlowNotifier extends Notifier<ScanFlowState> {
  @override
  ScanFlowState build() => const ScanFlowState();

  /// Reads label text (camera frames on phones; typed / sample on web).
  Future<ScanDraft> read(List<List<String>> frames) async {
    final lx = await ref.read(lexiconProvider.future);
    final ctx = ref.read(corePlanProvider);
    final draft = ref.read(repositoryProvider).parseLabel(frames, lx, ctx);
    state = ScanFlowState(draft: draft);
    return draft;
  }

  void choose(LexMatch? m) =>
      state = ScanFlowState(draft: state.draft, chosen: m);

  /// Submits the confirmed read. [confirmed] is false for "Neither".
  Future<ShownResult> submit({required bool confirmed}) async {
    final draft = state.draft!;
    final input = draftToScan(draft, chosen: state.chosen);
    final scanInput = confirmed ? input : input.copyWith(confirmed: false);
    ShownResult shown;
    try {
      final o = await ref.read(repositoryProvider).submitScan(scanInput);
      shown = _fromOutcome(o);
    } on Exception {
      shown = _local(draft, confirmed);
    }
    state = ScanFlowState(draft: draft, chosen: state.chosen, result: shown);
    return shown;
  }

  ShownResult _fromOutcome(ReconOutcome o) => ShownResult(
    status: statusOf(o.status),
    reason: o.reason,
    sev: sevOf(o.sev),
    params: o.params,
    flagKinds: [
      for (final f in o.flags)
        SafetyKind.values.firstWhere((k) => k.name == f.kind, orElse: () => SafetyKind.lasa),
    ],
    offline: false,
    itemKey: o.itemKey,
    scanId: o.scanId,
  );

  /// Same pure reconcile + safety as the server (same ruleVersion).
  ShownResult _local(ScanDraft draft, bool confirmed) {
    final plan = ref.read(corePlanProvider) ?? const Plan(id: 'none', items: []);
    final r = reconcileWithSafety(
      plan,
      draft.toScan(confirmed: confirmed),
      ref.read(rulesProvider),
    );
    return ShownResult(
      status: r.status,
      reason: r.reason,
      sev: r.sev,
      params: r.params,
      flagKinds: [for (final f in r.flags) f.kind],
      offline: true,
      itemKey: r.itemId,
    );
  }
}

final scanFlowProvider = NotifierProvider<ScanFlowNotifier, ScanFlowState>(
  ScanFlowNotifier.new,
);
