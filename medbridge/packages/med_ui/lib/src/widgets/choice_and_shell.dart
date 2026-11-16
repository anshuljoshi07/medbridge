import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/src/l10n_gen/med_localizations.dart';
import 'package:med_ui/src/theme/med_colors.dart';
import 'package:med_ui/src/theme/med_dims.dart';
import 'package:med_ui/src/widgets/basics.dart';

/// LASA forced choice: two cards side by side (stacked at large text), the
/// differing letters in Tall Man, plus "Neither" (A13.4).
class ChoiceCompare extends StatelessWidget {
  /// Creates the choice between [a] and [b].
  const ChoiceCompare({
    required this.a,
    required this.b,
    required this.rules,
    required this.onPick,
    super.key,
  });

  /// First candidate name.
  final String a;

  /// Second candidate name.
  final String b;

  /// Rules for Tall Man lettering.
  final RuleSet rules;

  /// Called with the chosen name, or `null` for "Neither".
  final ValueChanged<String?> onPick;

  @override
  Widget build(BuildContext context) {
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    final stacked =
        MediaQuery.textScalerOf(context).scale(1) > 1.3 ||
        MediaQuery.sizeOf(context).width < 360;
    final cards = [
      _ChoiceCard(name: a, rules: rules, onTap: () => onPick(a)),
      _ChoiceCard(name: b, rules: rules, onTap: () => onPick(b)),
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l.whichOne, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: d.gapM),
        if (stacked)
          ...cards.expand((c) => [c, SizedBox(height: d.gapS)])
        else
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: cards[0]),
                SizedBox(width: d.gapS),
                Expanded(child: cards[1]),
              ],
            ),
          ),
        SizedBox(height: d.gapM),
        BigButton(
          label: l.neither,
          onPressed: () => onPick(null),
          secondary: true,
        ),
      ],
    );
  }
}

class _ChoiceCard extends StatelessWidget {
  const _ChoiceCard({
    required this.name,
    required this.rules,
    required this.onTap,
  });
  final String name;
  final RuleSet rules;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final d = MedDims.of(context);
    return Card(
      shape: d.cardShape.copyWith(
        side: BorderSide(
          color: MedColors.of(context).brand,
          width: d.strongBorderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: d.cardShape,
        child: Semantics(
          button: true,
          label: name,
          excludeSemantics: true,
          child: Padding(
            padding: EdgeInsetsDirectional.all(d.gapL),
            child: Center(child: TallManText(name, rules: rules)),
          ),
        ),
      ),
    );
  }
}

/// The app shell: 4 labeled tabs (icon + text, always): Today · Scan ·
/// My meds · Questions, with Scan as the raised center action (A13.3).
class AppTabScaffold extends StatelessWidget {
  /// Creates the shell.
  const AppTabScaffold({
    required this.index,
    required this.onTab,
    required this.body,
    required this.title,
    this.actions = const [],
    this.banner,
    super.key,
  });

  /// Selected tab: 0 Today, 1 Scan, 2 My meds, 3 Questions.
  final int index;

  /// Tab selection.
  final ValueChanged<int> onTab;

  /// Tab content.
  final Widget body;

  /// App-bar title.
  final String title;

  /// App-bar actions (e.g. the settings avatar).
  final List<Widget> actions;

  /// A persistent banner above the content (caregiver mode, offline).
  final Widget? banner;

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: actions),
      body: Column(
        children: [
          ?banner,
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: d.maxContentWidth),
                child: body,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: onTab,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.today),
            label: l.tabToday,
          ),
          NavigationDestination(
            icon: CircleAvatar(
              backgroundColor: MedColors.of(context).brand,
              foregroundColor: MedColors.of(context).onBrand,
              child: const Icon(Icons.qr_code_scanner),
            ),
            label: l.tabScan,
          ),
          NavigationDestination(
            icon: const Icon(Icons.medication),
            label: l.tabMyMeds,
          ),
          NavigationDestination(
            icon: const Icon(Icons.question_answer),
            label: l.tabQuestions,
          ),
        ],
      ),
    );
  }
}
