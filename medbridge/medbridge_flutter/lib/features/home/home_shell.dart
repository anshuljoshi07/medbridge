import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';

import '../../data/app_data.dart';
import '../my_meds/my_meds_screen.dart';
import '../questions/questions_screen.dart';
import '../today/today_screen.dart';
import 'scan_tab.dart';

/// The 4-tab shell (A13.3). Settings via the avatar in the app bar.
class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({required this.initialTab, super.key});
  final int initialTab;

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  late int _tab = widget.initialTab.clamp(0, 3);

  @override
  void didUpdateWidget(HomeShell old) {
    super.didUpdateWidget(old);
    if (old.initialTab != widget.initialTab) _tab = widget.initialTab.clamp(0, 3);
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final ap = ref.watch(activePatientProvider);
    final me = ref.watch(meProvider).value;
    final titles = [l.tabToday, l.tabScan, l.tabMyMeds, l.tabQuestions];
    return AppTabScaffold(
      index: _tab,
      onTab: (i) => setState(() => _tab = i),
      title: titles[_tab],
      banner: ap != null && ap.isCaregiver
          ? CaregiverBanner(
              patientName: ap.name,
              onSwitch: (me?.linkedPatients.length ?? 0) > 1 ? () => _pickPatient(context) : null,
            )
          : null,
      actions: [
        IconButton(tooltip: l.careTeam, icon: const Icon(Icons.group), onPressed: () => context.push('/care-team')),
        IconButton(
          tooltip: l.settings,
          icon: CircleAvatar(child: Text((ap?.name ?? '?').characters.first.toUpperCase())),
          onPressed: () => context.push('/settings'),
        ),
      ],
      body: switch (_tab) {
        0 => const TodayScreen(),
        1 => const ScanTab(),
        2 => const MyMedsScreen(),
        _ => const QuestionsScreen(),
      },
    );
  }

  Future<void> _pickPatient(BuildContext context) async {
    final me = ref.read(meProvider).value;
    if (me == null) return;
    final id = await showModalBottomSheet<int>(
      context: context,
      builder: (c) => ListView(
        shrinkWrap: true,
        children: [
          for (final p in me.linkedPatients)
            ListTile(minTileHeight: MedDims.of(c).minTarget, title: Text(p.firstName), onTap: () => Navigator.pop(c, p.id)),
        ],
      ),
    );
    if (id != null) {
      ref.read(selectedPatientProvider.notifier).select(id);
      refreshAll(ref);
    }
  }
}
