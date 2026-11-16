import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';

import '../../data/app_data.dart';

/// The Scan tab: discharge papers or a bottle. Caregivers view only (A3).
class ScanTab extends ConsumerWidget {
  const ScanTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final ap = ref.watch(activePatientProvider);
    final hasPlan = ref.watch(planProvider).value != null;
    if (ap?.isCaregiver ?? false) {
      return Padding(
        padding: EdgeInsetsDirectional.all(d.gapL),
        child: Center(child: Text(l.viewingMeds(ap!.name), style: Theme.of(context).textTheme.titleMedium)),
      );
    }
    return ListView(
      padding: EdgeInsetsDirectional.all(d.gapM),
      children: [
        BigButton(label: l.scanPapers, icon: Icons.description, secondary: hasPlan, onPressed: () => context.push('/capture')),
        SizedBox(height: d.gapM),
        if (hasPlan) BigButton(label: l.tabScan, icon: Icons.qr_code_scanner, onPressed: () => context.push('/scan')),
        SizedBox(height: d.gapL),
        Text(l.cameraPrimer, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
