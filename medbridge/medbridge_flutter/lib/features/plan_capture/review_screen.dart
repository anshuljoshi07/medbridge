import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/app_settings.dart';
import '../../core/providers.dart';
import '../../data/app_data.dart';
import '../../routing/router.dart';
import '../home/state_views.dart';
import 'plan_capture_notifier.dart';

/// Review plan (F2, A13.4): grouped by action chips, every item shows its
/// source line, low-confidence items outlined amber with "Check this",
/// unrecognized lines kept in a collapsible section, big "Looks right".
class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  final Set<PlanAction> _shown = PlanAction.values.toSet();
  bool _busy = false;
  Object? _error;

  static const _order = [PlanAction.start, PlanAction.change, PlanAction.keep, PlanAction.hold, PlanAction.stop];

  String _chip(MedL10n l, PlanAction a) => switch (a) {
    PlanAction.start => l.chipNew,
    PlanAction.change => l.chipChanged,
    PlanAction.keep => l.chipKeep,
    PlanAction.hold => l.chipPaused,
    PlanAction.stop => l.chipStopped,
  };

  Future<void> _confirm() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await ref.read(planCaptureProvider.notifier).confirm();
      refreshAll(ref);
      if (mounted) context.goHome();
    } on Exception catch (e) {
      if (mounted) setState(() => _error = e);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final cfg = ref.watch(rulesProvider).config;
    final state = ref.watch(planCaptureProvider);
    final draft = state.draft;
    if (draft == null) return Scaffold(appBar: AppBar(title: Text(l.reviewPlan)));
    final byAction = {for (final a in _order) a: draft.items.where((i) => i.action == a).toList()};
    return Scaffold(
      appBar: AppBar(title: Text(l.reviewPlan)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              Wrap(
                spacing: d.gapS,
                runSpacing: d.gapS,
                children: [
                  for (final a in _order)
                    PlanChip(
                      label: _chip(l, a),
                      count: byAction[a]!.length,
                      selected: _shown.contains(a),
                      onSelected: (v) => setState(() => v ? _shown.add(a) : _shown.remove(a)),
                    ),
                ],
              ),
              SizedBox(height: d.gapM),
              for (final a in _order)
                if (_shown.contains(a))
                  for (final item in byAction[a]!)
                    Padding(
                      padding: EdgeInsetsDirectional.only(bottom: d.gapM),
                      child: _ItemCard(
                        item: item,
                        actionLabel: _chip(l, a),
                        needsCheck: state.needsCheck(item, cfg),
                        checked: state.checked.contains(item.id),
                        onChecked: (v) => ref.read(planCaptureProvider.notifier).toggle(item.id, v),
                      ),
                    ),
              if (draft.unrecognized.isNotEmpty)
                ExpansionTile(
                  title: Text('${l.linesWeCouldntRead} (${draft.unrecognized.length})'),
                  children: [for (final line in draft.unrecognized) ListTile(title: Text(line.text))],
                ),
              if (_error != null) ErrorView(error: _error!, onRetry: _confirm),
              SizedBox(height: d.gapL),
              BigButton(label: l.looksRight, icon: Icons.check, onPressed: _busy || !state.allChecked(cfg) ? null : _confirm),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemCard extends ConsumerWidget {
  const _ItemCard({
    required this.item,
    required this.actionLabel,
    required this.needsCheck,
    required this.checked,
    required this.onChecked,
  });

  final PlanItem item;
  final String actionLabel;
  final bool needsCheck;
  final bool checked;
  final ValueChanged<bool> onChecked;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final t = Theme.of(context).textTheme;
    final lang = ref.watch(settingsProvider).lang ?? Lang.en;
    final sigText = item.sig == null ? null : renderSig(item.sig!, lang, ShippedRules.templates);
    return Card(
      shape: d.cardShape.copyWith(
        side: BorderSide(color: needsCheck ? c.amber : c.hairline, width: needsCheck ? d.strongBorderWidth : d.borderWidth),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.all(d.gapM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(actionLabel, style: t.labelLarge),
            Text(item.name, style: t.titleLarge),
            if (item.strength != null) Text(item.strength!.display, style: t.bodyLarge),
            if (item.sigRaw.isNotEmpty) Text(sigText ?? l.askPharmacist, style: t.bodyLarge),
            if (item.holdNote != null) Text(item.holdNote!, style: t.bodyLarge),
            SizedBox(height: d.gapS),
            SourceQuote(text: item.src, heading: l.fromYourPapers),
            if (needsCheck)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                value: checked,
                onChanged: (v) => onChecked(v ?? false),
                title: Text(l.checkThis, style: TextStyle(color: c.amber, fontWeight: FontWeight.w700)),
                secondary: Icon(Icons.help, color: c.amber),
              ),
          ],
        ),
      ),
    );
  }
}
