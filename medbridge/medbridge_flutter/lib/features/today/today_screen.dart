import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart' as core;
import 'package:med_ui/med_ui.dart';
import 'package:medbridge_client/medbridge_client.dart';

import '../../core/app_settings.dart';
import '../../core/services.dart';
import '../../data/adapters.dart';
import '../../data/app_data.dart';
import '../../data/med_repository.dart';
import '../home/state_views.dart';
import 'today_model.dart';

/// Optimistic dose states awaiting their 5-second Undo window.
class PendingDosesNotifier extends Notifier<Map<String, DoseState>> {
  @override
  Map<String, DoseState> build() => const {};
  void set(String key, DoseState? s) {
    final next = {...state};
    s == null ? next.remove(key) : next[key] = s;
    state = next;
  }
}

final pendingDosesProvider = NotifierProvider<PendingDosesNotifier, Map<String, DoseState>>(
  PendingDosesNotifier.new,
);

/// Today (A13.4): Needs-attention card, Next-dose hero, slot sections,
/// "3 of 5 taken today", calm empty state.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final plan = ref.watch(planProvider);
    return plan.when(
      loading: () => const DelayedSkeleton(),
      error: (e, _) => ErrorView(error: e, onRetry: () => refreshAll(ref)),
      data: (p) {
        final ap = ref.watch(activePatientProvider);
        if (p == null) {
          return EmptyState(
            message: l.emptyToday,
            actionLabel: l.scanPapers,
            onAction: (ap?.isCaregiver ?? false) ? () {} : () => context.push('/capture'),
          );
        }
        return const _TodayBody();
      },
    );
  }
}

class _TodayBody extends ConsumerWidget {
  const _TodayBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final schedule = ref.watch(scheduleProvider).value ?? const <ScheduleView>[];
    final history = ref.watch(historyProvider).value ?? const <ScanHistoryEntry>[];
    final pending = ref.watch(pendingDosesProvider);
    final isCaregiver = ref.watch(activePatientProvider)?.isCaregiver ?? false;
    final lang = ref.watch(settingsProvider).lang ?? core.Lang.en;
    final doses = todaysDoses(schedule, pending);
    final red = history.where((e) => e.recon.sev == 'red' && e.recon.resolvedNote == null && !e.scan.setAside).length;
    final next = doses.where((x) => x.state == null).firstOrNull;
    final taken = doses.where((x) => x.state == DoseState.taken).length;
    final prn = schedule.where((v) => v.schedule.prn && v.schedule.active).toList();
    String detail(PlanItemRow item) {
      final c = itemToCore(item);
      return c.sig == null ? '' : core.renderSig(c.sig!, lang, core.ShippedRules.templates) ?? l.askPharmacist;
    }

    return RefreshIndicator(
      onRefresh: () async => refreshAll(ref),
      child: ListView(
        padding: EdgeInsetsDirectional.all(d.gapM),
        children: [
          if (red > 0) ...[
            AttentionBanner(count: red, onReview: () => context.go('/?tab=2')),
            SizedBox(height: d.gapM),
          ],
          if (next != null && !isCaregiver) ...[
            NextDoseCard(
              timeLabel: MaterialLocalizations.of(context).formatTimeOfDay(TimeOfDay.fromDateTime(next.dueUtc.toLocal())),
              medName: next.item.name,
              doseLabel: detail(next.item),
              onTaken: () => _log(context, ref, next, DoseState.taken),
              onSkip: () => _log(context, ref, next, DoseState.skipped),
            ),
            SizedBox(height: d.gapM),
          ],
          if (doses.isNotEmpty) ...[
            ProgressRingLabeled(taken: taken, total: doses.length),
            SizedBox(height: d.gapM),
          ],
          for (final slot in core.DoseSlot.values)
            if (doses.any((x) => x.slot == slot)) ...[
              SlotSection(
                slot: slot,
                children: [
                  for (final dose in doses.where((x) => x.slot == slot))
                    PillRow(
                      medName: dose.item.name,
                      detail: detail(dose.item),
                      state: dose.state == null ? null : core.DoseState.values.byName(dose.state!.name),
                      onTaken: isCaregiver ? () {} : () => _log(context, ref, dose, DoseState.taken),
                      onSkip: isCaregiver ? () {} : () => _log(context, ref, dose, DoseState.skipped),
                    ),
                ],
              ),
              SizedBox(height: d.gapM),
            ],
          for (final v in prn)
            Card(child: ListTile(title: Text(v.item.name), subtitle: Text(l.asNeeded))),
        ],
      ),
    );
  }

  /// Optimistic log with a 5-second Undo (A13.2 #5). The server write
  /// happens only after the window closes without Undo.
  Future<void> _log(BuildContext context, WidgetRef ref, DueDose dose, DoseState s) async {
    final l = MedL10n.of(context);
    final pending = ref.read(pendingDosesProvider.notifier)..set(dose.key, s);
    if (s == DoseState.taken) unawaited(ref.read(hapticsProvider).success());
    var undone = false;
    final messenger = ScaffoldMessenger.of(context);
    final closed = messenger
        .showSnackBar(SnackBar(
          duration: MedDims.of(context).undoWindow,
          content: Text(s == DoseState.taken ? l.markedTaken : l.skipped),
          action: SnackBarAction(label: l.undo, onPressed: () => undone = true),
        ))
        .closed;
    await closed;
    if (undone) {
      pending.set(dose.key, null);
      return;
    }
    try {
      await ref.read(repositoryProvider).logDose(dose.schedule.id!, dose.dueUtc, s);
      ref.invalidate(scheduleProvider);
    } on Exception {
      // Keep the optimistic state; it is retried on the next refresh.
    }
  }
}
