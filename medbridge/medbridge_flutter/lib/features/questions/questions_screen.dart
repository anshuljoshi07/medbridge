import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';
import 'package:medbridge_client/medbridge_client.dart';

import '../../data/app_data.dart';
import '../../data/med_repository.dart';
import '../home/state_views.dart';
import 'export_pdf.dart';

/// Questions (F6, A13.4): "Added for you" badge on auto items, big "Add a
/// question", answers from the care team, "Share with my doctor" → PDF.
class QuestionsScreen extends ConsumerWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final qs = ref.watch(questionsProvider);
    return qs.when(
      loading: () => const DelayedSkeleton(),
      error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(questionsProvider)),
      data: (list) => ListView(
        padding: EdgeInsetsDirectional.all(d.gapM),
        children: [
          BigButton(label: l.addQuestion, icon: Icons.add_comment, onPressed: () => _add(context, ref)),
          SizedBox(height: d.gapS),
          BigButton(
            label: l.shareWithDoctor,
            icon: Icons.picture_as_pdf,
            secondary: true,
            onPressed: () async {
              final plan = ref.read(planProvider).value;
              final history = ref.read(historyProvider).value ?? const [];
              final name = ref.read(activePatientProvider)?.name ?? '';
              await sharePcpPdf(name: name, plan: plan, history: history, questions: list);
            },
          ),
          SizedBox(height: d.gapM),
          for (final q in list) ...[_QuestionCard(q: q), SizedBox(height: d.gapS)],
        ],
      ),
    );
  }

  Future<void> _add(BuildContext context, WidgetRef ref) async {
    final l = MedL10n.of(context);
    final controller = TextEditingController();
    final text = await showDialog<String>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text(l.addQuestion),
        content: TextField(controller: controller, autofocus: true, minLines: 2, maxLines: 5),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: Text(l.cancel)),
          FilledButton(onPressed: () => Navigator.pop(c, controller.text), child: Text(l.save)),
        ],
      ),
    );
    controller.dispose();
    if (text == null || text.trim().isEmpty) return;
    final ap = ref.read(activePatientProvider);
    await ref.read(repositoryProvider).addQuestion(text, patientId: ap?.patientId);
    ref.invalidate(questionsProvider);
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({required this.q});
  final Question q;

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final c = MedColors.of(context);
    final t = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: EdgeInsetsDirectional.all(d.gapM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (q.source == 'auto')
              Row(children: [Icon(Icons.auto_awesome, color: c.info), SizedBox(width: d.gapXs), Text(l.addedForYou, style: TextStyle(color: c.info, fontWeight: FontWeight.w700))]),
            Text(q.text, style: t.titleMedium),
            SizedBox(height: d.gapS),
            if (q.answer != null) ...[
              Text(l.answered, style: t.labelLarge),
              Text(q.answer!, style: t.bodyLarge),
            ] else
              Text(l.waitingForAnswer, style: t.bodyMedium?.copyWith(color: c.onSurfaceMuted)),
          ],
        ),
      ),
    );
  }
}
