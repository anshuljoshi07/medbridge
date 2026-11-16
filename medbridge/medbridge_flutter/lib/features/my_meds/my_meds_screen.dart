import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart' as core;
import 'package:med_ui/med_ui.dart';
import 'package:medbridge_client/medbridge_client.dart';

import '../../core/app_settings.dart';
import '../../data/adapters.dart';
import '../../data/app_data.dart';
import '../home/state_views.dart';

/// My meds (A13.4): "4 of 6 bottles checked", status chip + scanned state,
/// plain-language directions, the pick-up checklist (F4), and results for
/// bottles not on the plan.
class MyMedsScreen extends ConsumerWidget {
  const MyMedsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final plan = ref.watch(planProvider);
    final history = ref.watch(historyProvider).value ?? const <ScanHistoryEntry>[];
    final lang = ref.watch(settingsProvider).lang ?? core.Lang.en;
    return plan.when(
      loading: () => const DelayedSkeleton(),
      error: (e, _) => ErrorView(error: e, onRetry: () => refreshAll(ref)),
      data: (p) {
        if (p == null) return Center(child: Text(l.emptyToday, textAlign: TextAlign.center));
        final latestByItem = <String, ScanHistoryEntry>{};
        for (final e in history.reversed) {
          if (e.recon.itemKey != null) latestByItem[e.recon.itemKey!] = e;
        }
        final offPlan = history.where((e) => e.recon.itemKey == null || e.recon.reason.startsWith('SAME_CLASS_AS')).toList();
        final checked = p.items.where((i) => latestByItem.containsKey(i.itemKey)).length;
        final pickUp = p.items.where((i) => (i.action == 'start' || i.action == 'change') && !latestByItem.containsKey(i.itemKey)).toList();
        // Red results sort first (A13.2 #2).
        final items = [...p.items]..sort((a, b) {
          int rank(PlanItemRow r) => latestByItem[r.itemKey]?.recon.sev == 'red' ? 0 : 1;
          return rank(a).compareTo(rank(b));
        });
        return ListView(
          padding: EdgeInsetsDirectional.all(d.gapM),
          children: [
            Row(children: [
              Icon(p.plan.status == PlanStatus.verified ? Icons.verified : Icons.pending, color: MedColors.of(context).brand),
              SizedBox(width: d.gapS),
              Expanded(child: Text(p.plan.status == PlanStatus.verified ? l.verified : l.unverified)),
            ]),
            SizedBox(height: d.gapS),
            Text(l.bottlesChecked(checked, p.items.length), style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: d.gapM),
            for (final item in items) ...[
              _MedCard(item: item, entry: latestByItem[item.itemKey], lang: lang),
              SizedBox(height: d.gapS),
            ],
            if (pickUp.isNotEmpty) ...[
              SizedBox(height: d.gapM),
              Text(l.pickUpFromPharmacy, style: Theme.of(context).textTheme.titleLarge),
              for (final i in pickUp) ListTile(leading: const Icon(Icons.local_pharmacy), title: Text(i.name)),
            ],
            if (offPlan.isNotEmpty) ...[
              SizedBox(height: d.gapM),
              for (final e in offPlan)
                Card(
                  child: ListTile(
                    title: Text(e.scan.name),
                    subtitle: Padding(
                      padding: EdgeInsetsDirectional.only(top: d.gapXs),
                      child: Align(alignment: AlignmentDirectional.centerStart, child: SeverityBadge(sev: sevOf(e.recon.sev), status: statusOf(e.recon.status))),
                    ),
                  ),
                ),
            ],
          ],
        );
      },
    );
  }
}

class _MedCard extends StatelessWidget {
  const _MedCard({required this.item, required this.entry, required this.lang});
  final PlanItemRow item;
  final ScanHistoryEntry? entry;
  final core.Lang lang;

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final c = itemToCore(item);
    final sig = c.sig == null ? null : core.renderSig(c.sig!, lang, core.ShippedRules.templates);
    final t = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: EdgeInsetsDirectional.all(d.gapM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.name, style: t.titleMedium),
            if (item.sigRaw.isNotEmpty) Text(sig ?? l.askPharmacist),
            if (item.action == 'stop') Text(l.stopShort),
            if (item.action == 'hold') Text(l.msgPlanHold((item.holdNote ?? l.untilFollowUp).replaceFirst('until ', ''))),
            SizedBox(height: d.gapS),
            Wrap(spacing: d.gapS, runSpacing: d.gapS, crossAxisAlignment: WrapCrossAlignment.center, children: [
              if (entry != null) SeverityBadge(sev: sevOf(entry!.recon.sev), status: statusOf(entry!.recon.status)),
              Text(entry != null ? l.scanned : l.notScannedYet),
            ]),
          ],
        ),
      ),
    );
  }
}
