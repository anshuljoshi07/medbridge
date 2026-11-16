import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/services.dart';
import 'plan_capture_notifier.dart';

/// "Scan papers" (A13.4). On phones this hosts the native document scanner
/// + ML Kit OCR; in the browser the same pipeline takes typed or pasted
/// text, or the synthetic sample. Images are never stored.
class CaptureScreen extends ConsumerStatefulWidget {
  const CaptureScreen({super.key});

  @override
  ConsumerState<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends ConsumerState<CaptureScreen> {
  final _text = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _add(String text) async {
    setState(() => _busy = true);
    await ref.read(hapticsProvider).tick();
    await ref.read(planCaptureProvider.notifier).addPage(text);
    if (!mounted) return;
    _text.clear();
    setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final state = ref.watch(planCaptureProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.scanPapers)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              Text(l.cameraPrimer, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: d.gapM),
              if (state.pages > 0)
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: d.gapM),
                  child: Row(children: [const Icon(Icons.filter_none), SizedBox(width: d.gapS), Text(l.pages(state.pages))]),
                ),
              TextField(
                controller: _text,
                minLines: 6,
                maxLines: 14,
                decoration: InputDecoration(labelText: l.pasteOrType, alignLabelWithHint: true),
              ),
              SizedBox(height: d.gapM),
              BigButton(label: l.addPage, icon: Icons.add, secondary: true, onPressed: _busy ? null : () => _add(_text.text)),
              SizedBox(height: d.gapS),
              BigButton(label: l.useSampleR, icon: Icons.science, secondary: true, onPressed: _busy ? null : () => _add(sampleAvs)),
              SizedBox(height: d.gapL),
              if (_busy) const LinearProgressIndicator(),
              BigButton(
                label: l.done,
                icon: Icons.check,
                onPressed: state.draft == null || _busy ? null : () => context.push('/review'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
