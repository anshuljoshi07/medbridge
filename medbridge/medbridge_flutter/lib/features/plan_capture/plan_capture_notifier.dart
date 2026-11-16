import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_core/med_core.dart';
import 'package:medbridge_client/medbridge_client.dart' show PlanView;

import '../../core/providers.dart';
import '../../data/med_repository.dart';

/// Synthetic sample AVS (R. Doe, 78 — B10) for testing without a camera.
const sampleAvs = '''
Carle Foundation Hospital - After Visit Summary
Patient: R. Doe   Age: 78
Allergies: Penicillin
START taking these medications
losartan 50 mg tablet
Take 1 tab PO daily
Commonly known as: Cozaar
CHANGE how you take these medications
metoprolol succinate ER 25 mg tablet
Take 1 tab PO daily
CONTINUE taking these medications
atorvastatin 40 mg tablet
Take 1 tab PO QHS
HOLD these medications
metformin 500 mg tablet
Take 1 tab PO BID
until follow-up
STOP taking these medications
lisinopril 10 mg tablet
Follow-up appointments''';

/// Review state: the parsed draft plus which low-confidence items the
/// patient has checked.
class CaptureState {
  const CaptureState({this.draft, this.checked = const {}, this.pages = 0});
  final PlanDraft? draft;
  final Set<String> checked;
  final int pages;

  /// Items below the pre-fill band must be confirmed (F2 AC).
  bool needsCheck(PlanItem i, RuleConfig c) => i.conf < c.confHigh;

  bool allChecked(RuleConfig c) =>
      draft?.items.every((i) => !needsCheck(i, c) || checked.contains(i.id)) ?? false;
}

class PlanCaptureNotifier extends Notifier<CaptureState> {
  @override
  CaptureState build() => const CaptureState();

  final List<String> _pages = [];

  /// Adds one page of text and re-parses all pages in reading order.
  Future<void> addPage(String text) async {
    if (text.trim().isEmpty) return;
    final lx = await ref.read(lexiconProvider.future);
    _pages.add(text);
    final draft = ref.read(repositoryProvider).parseAvsText(_pages.join('\n'), lx);
    state = CaptureState(draft: draft, checked: state.checked, pages: _pages.length);
  }

  void toggle(String itemId, bool v) {
    final next = {...state.checked};
    v ? next.add(itemId) : next.remove(itemId);
    state = CaptureState(draft: state.draft, checked: next, pages: state.pages);
  }

  /// Uploads and confirms. Returns the confirmed plan.
  Future<PlanView> confirm() async {
    final view = await ref.read(repositoryProvider).confirmPlan(state.draft!);
    _pages.clear();
    state = const CaptureState();
    return view;
  }

  void reset() {
    _pages.clear();
    state = const CaptureState();
  }
}

final planCaptureProvider = NotifierProvider<PlanCaptureNotifier, CaptureState>(
  PlanCaptureNotifier.new,
);
