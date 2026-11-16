import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/providers.dart';
import 'confirm_screen.dart';
import 'scan_flow_notifier.dart';

/// LASA forced choice (A7.2 step 5, A13.4).
class ChoiceScreen extends ConsumerWidget {
  const ChoiceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = MedDims.of(context);
    final draft = ref.watch(scanFlowProvider).draft;
    if (draft == null || draft.candidates.length < 2) {
      return Scaffold(appBar: AppBar());
    }
    final a = draft.candidates[0];
    final b = draft.candidates[1];
    return Scaffold(
      appBar: AppBar(title: Text(MedL10n.of(context).whichOne)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              ChoiceCompare(
                a: a.entry.name,
                b: b.entry.name,
                rules: ref.watch(rulesProvider),
                onPick: (name) async {
                  final notifier = ref.read(scanFlowProvider.notifier)
                    ..choose(name == null ? null : (name == a.entry.name ? a : b));
                  // "Neither" → not confirmed → Unknown (LOW_CONFIDENCE).
                  if (name == null) notifier.choose(null);
                  await submitScan(context, ref, confirmed: name != null);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
