import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/providers.dart';
import '../../core/services.dart';
import 'scan_flow_notifier.dart';

/// Confirm (F3, A13.4): big name + strength (Tall Man for confusables),
/// "Is this your medicine?" Yes / Not this one. Always shown before a status.
class ConfirmScreen extends ConsumerWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final c = MedColors.of(context);
    final rules = ref.watch(rulesProvider);
    final draft = ref.watch(scanFlowProvider).draft;
    if (draft == null) return Scaffold(appBar: AppBar(title: Text(l.isThisYourMedicine)));
    final band = confBand(draft.conf, rules.config);
    final unreadable = draft.name.isEmpty;
    return Scaffold(
      appBar: AppBar(title: Text(l.isThisYourMedicine)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              Card(
                shape: d.cardShape.copyWith(
                  side: BorderSide(
                    color: band == ConfBand.prefill ? c.hairline : c.amber,
                    width: band == ConfBand.prefill ? d.borderWidth : d.strongBorderWidth,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.all(d.gapL),
                  child: Column(
                    children: [
                      if (unreadable)
                        Text(l.lowConfidenceRead, style: Theme.of(context).textTheme.titleLarge)
                      else ...[
                        TallManText(draft.name, rules: rules),
                        if (draft.strength != null)
                          Text(draft.strength!.display, style: Theme.of(context).textTheme.headlineMedium),
                      ],
                      if (band != ConfBand.prefill && !unreadable) ...[
                        SizedBox(height: d.gapS),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Icon(Icons.help, color: c.amber), SizedBox(width: d.gapXs), Text(l.checkThis, style: TextStyle(color: c.amber))],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(height: d.gapL),
              Text(l.isThisYourMedicine, style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center),
              SizedBox(height: d.gapM),
              BigButton(
                label: l.yes,
                icon: Icons.check,
                onPressed: unreadable
                    ? null
                    : () async {
                        if (draft.needsChoice) {
                          await context.push('/scan/choice');
                          return;
                        }
                        await _submit(context, ref, confirmed: true);
                      },
              ),
              SizedBox(height: d.gapS),
              BigButton(label: l.notThisOne, secondary: true, onPressed: () => context.pop()),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shared by Confirm and Choice: submit, haptic by severity, show result.
Future<void> _submit(BuildContext context, WidgetRef ref, {required bool confirmed}) async {
  final shown = await ref.read(scanFlowProvider.notifier).submit(confirmed: confirmed);
  final haptics = ref.read(hapticsProvider);
  shown.sev == Severity.red ? await haptics.warning() : await haptics.success();
  if (context.mounted) context.pushReplacement('/scan/result');
}

/// Public wrapper used by the choice screen.
Future<void> submitScan(BuildContext context, WidgetRef ref, {required bool confirmed}) =>
    _submit(context, ref, confirmed: confirmed);
