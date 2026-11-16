import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/app_settings.dart';
import '../../core/services.dart';
import '../../data/app_data.dart';
import '../../data/med_repository.dart';
import '../bottle_scan/scan_flow_notifier.dart';

/// Result (F4, A13.4): full-screen status card, instruction, source quote,
/// read aloud, add to questions, scan next. Stop / Duplicate need the
/// explicit "I've set this bottle aside" acknowledgment.
class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool _setAside = false;
  bool _questionAdded = false;

  @override
  void initState() {
    super.initState();
    // The server wrote a Question / alert; refresh the lists.
    WidgetsBinding.instance.addPostFrameCallback((_) => refreshAll(ref));
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final flow = ref.watch(scanFlowProvider);
    final shown = flow.result;
    final draft = flow.draft;
    if (shown == null || draft == null) return Scaffold(appBar: AppBar());
    final lang = ref.watch(settingsProvider).lang ?? Lang.en;
    final plan = ref.watch(corePlanProvider);
    final item = shown.itemKey == null ? null : plan?.itemById(shown.itemKey!);
    final sigText = item?.sig == null ? null : renderSig(item!.sig!, lang, ShippedRules.templates);
    final message = patientMessage(l, shown.reason, shown.params, sigText: sigText);
    final name = '${flow.chosen?.entry.name ?? draft.name} ${draft.strength?.display ?? ''}'.trim();
    final canLeave = !shown.needsAcknowledgment || _setAside;
    return PopScope(
      canPop: canLeave,
      child: Scaffold(
        appBar: AppBar(automaticallyImplyLeading: canLeave, title: Text(shown.status.label(l))),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: d.maxContentWidth),
            child: ListView(
              padding: EdgeInsetsDirectional.all(d.gapM),
              children: [
                if (shown.offline) Padding(padding: EdgeInsetsDirectional.only(bottom: d.gapM), child: const OfflineNote()),
                StatusCard(
                  status: shown.status,
                  sev: shown.sev,
                  medName: name,
                  message: message,
                  sourceLine: item?.src,
                  flags: shown.flagKinds,
                  onReadAloud: () => ref.read(ttsProvider).speak(
                    '${shown.status.label(l)}. $name. $message',
                    lang,
                    ref.read(settingsProvider).speechRate,
                  ),
                  onAddQuestion: _questionAdded ? null : () => _addQuestion(name, message),
                ),
                if (shown.needsAcknowledgment) ...[
                  SizedBox(height: d.gapM),
                  CheckboxListTile(
                    value: _setAside,
                    onChanged: (v) async {
                      setState(() => _setAside = v ?? false);
                      if ((v ?? false) && shown.scanId != null) {
                        await ref.read(repositoryProvider).setAside(shown.scanId!);
                      }
                    },
                    title: Text(l.setAside, style: Theme.of(context).textTheme.titleMedium),
                  ),
                ],
                SizedBox(height: d.gapL),
                BigButton(label: l.scanNext, icon: Icons.qr_code_scanner, onPressed: canLeave ? () => context.pushReplacement('/scan') : null),
                SizedBox(height: d.gapS),
                BigButton(label: l.done, secondary: true, onPressed: canLeave ? () => context.go('/') : null),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addQuestion(String name, String message) async {
    final l = MedL10n.of(context);
    await ref.read(repositoryProvider).addQuestion('$name: $message');
    if (!mounted) return;
    setState(() => _questionAdded = true);
    ref.invalidate(questionsProvider);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.addedForYou)));
  }
}
