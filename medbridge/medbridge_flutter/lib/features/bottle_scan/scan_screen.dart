import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/services.dart';
import 'scan_flow_notifier.dart';

/// Scan bottle (F3, A13.4). On phones: camera viewfinder, barcode first,
/// multi-frame OCR while the bottle turns. In the browser: "Type it instead"
/// plus synthetic sample bottles. Images are never stored.
class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final _typed = TextEditingController();

  @override
  void dispose() {
    _typed.dispose();
    super.dispose();
  }

  Future<void> _read(List<String> lines) async {
    await ref.read(hapticsProvider).tick();
    // Simulate the rotating-bottle frames (A7.2): three reads of the label.
    await ref.read(scanFlowProvider.notifier).read([lines, lines, lines]);
    if (mounted) await context.push('/scan/confirm');
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.tabScan)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              Text(l.scanHint, style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: d.gapM),
              Text(l.typeItInstead, style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: d.gapS),
              TextField(
                controller: _typed,
                minLines: 2,
                maxLines: 5,
                decoration: const InputDecoration(hintText: 'atorvastatin 40 mg tablet\nTake 1 tablet by mouth at bedtime'),
              ),
              SizedBox(height: d.gapS),
              BigButton(
                label: l.continueLabel,
                onPressed: () {
                  final lines = _typed.text.split('\n').where((s) => s.trim().isNotEmpty).toList();
                  if (lines.isNotEmpty) _read(lines);
                },
              ),
              SizedBox(height: d.gapL),
              Text('Sample bottles (synthetic)', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: d.gapS),
              for (final (drug, sig) in sampleBottles)
                Card(
                  margin: EdgeInsetsDirectional.only(bottom: d.gapS),
                  child: ListTile(
                    minTileHeight: d.minTarget,
                    leading: const Icon(Icons.medication),
                    title: Text(drug),
                    subtitle: Text(sig),
                    onTap: () => _read([drug, sig]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
