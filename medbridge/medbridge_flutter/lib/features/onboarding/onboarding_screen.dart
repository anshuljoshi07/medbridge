import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/app_settings.dart';
import '../../data/app_data.dart';
import '../../data/med_repository.dart';

/// Onboarding (F1, A13.4): language → role → name + text-size preview →
/// notification primer → allergies (optional). One decision per screen.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  int _step = 0;
  String _role = 'patient';
  final _name = TextEditingController();
  final _allergies = TextEditingController();
  bool _busy = false;
  String? _error;

  static const _steps = 5;

  @override
  void dispose() {
    _name.dispose();
    _allergies.dispose();
    super.dispose();
  }

  Future<void> _setLang(Lang lang) async {
    final s = ref.read(settingsProvider);
    await ref.read(settingsProvider.notifier).update(s.copyWith(lang: lang));
    setState(() => _step = 1);
  }

  Future<void> _finish() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final l = MedL10n.of(context);
    final lang = (ref.read(settingsProvider).lang ?? Lang.en).name;
    try {
      await ref.read(meProvider.notifier).register(_role, _name.text, lang);
      final terms = _allergies.text.split(',').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
      if (_role == 'patient' && terms.isNotEmpty) {
        await ref.read(repositoryProvider).setAllergies(terms);
      }
      final s = ref.read(settingsProvider);
      await ref.read(settingsProvider.notifier).update(s.copyWith(onboarded: true));
      if (!mounted) return;
      context.go(_role == 'caregiver' ? '/care-team' : '/');
    } on Exception {
      if (!mounted) return;
      setState(() => _error = l.errorGeneric);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final t = Theme.of(context).textTheme;
    final body = switch (_step) {
      0 => _Step(
        title: l.chooseLanguage,
        children: [
          // Names in their own language (A13.4).
          BigButton(label: 'English', onPressed: () => _setLang(Lang.en)),
          SizedBox(height: d.gapS),
          BigButton(label: 'Español', onPressed: () => _setLang(Lang.es), secondary: true),
        ],
      ),
      1 => _Step(
        title: l.whoAreYou,
        children: [
          BigButton(label: l.rolePatient, icon: Icons.person, onPressed: () => setState(() { _role = 'patient'; _step = 2; })),
          SizedBox(height: d.gapS),
          BigButton(label: l.roleCaregiver, icon: Icons.volunteer_activism, secondary: true, onPressed: () => setState(() { _role = 'caregiver'; _step = 2; })),
        ],
      ),
      2 => _Step(
        title: l.textSize,
        children: [
          TextField(controller: _name, decoration: InputDecoration(labelText: l.yourFirstName), textInputAction: TextInputAction.done),
          SizedBox(height: d.gapL),
          Card(
            child: Padding(
              padding: EdgeInsetsDirectional.all(d.gapM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.textSizePreview, style: t.titleMedium),
                  SizedBox(height: d.gapS),
                  Text('metoprolol succinate ER 25 mg', style: t.bodyLarge),
                  Text(l.msgNewDirections('Take 1 tablet by mouth once a day.'), style: t.bodyLarge),
                ],
              ),
            ),
          ),
          SizedBox(height: d.gapL),
          BigButton(label: l.continueLabel, onPressed: () => setState(() => _step = 3)),
        ],
      ),
      3 => _Step(
        title: l.settings,
        children: [
          Text(l.notificationPrimer, style: t.bodyLarge),
          SizedBox(height: d.gapM),
          Text(l.cameraPrimer, style: t.bodyLarge),
          SizedBox(height: d.gapL),
          BigButton(label: l.continueLabel, onPressed: () => setState(() => _step = _role == 'patient' ? 4 : 4)),
        ],
      ),
      _ => _Step(
        title: _role == 'patient' ? l.allergiesOptional : l.done,
        children: [
          if (_role == 'patient')
            TextField(controller: _allergies, decoration: InputDecoration(labelText: l.allergiesOptional, hintText: 'penicillin, sulfa')),
          if (_error != null) Padding(padding: EdgeInsetsDirectional.only(top: d.gapM), child: Text(_error!, style: TextStyle(color: MedColors.of(context).red))),
          SizedBox(height: d.gapL),
          BigButton(label: l.done, onPressed: _busy ? null : _finish),
        ],
      ),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(l.stepOf(_step + 1, _steps)),
        leading: _step == 0 ? null : IconButton(tooltip: l.back, icon: const BackButtonIcon(), onPressed: () => setState(() => _step--)),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(padding: EdgeInsetsDirectional.all(d.gapM), children: [_Dots(step: _step, total: _steps), SizedBox(height: d.gapL), body]),
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Semantics(header: true, child: Text(title, style: Theme.of(context).textTheme.headlineMedium)),
      SizedBox(height: MedDims.of(context).gapL),
      ...children,
    ],
  );
}

class _Dots extends StatelessWidget {
  const _Dots({required this.step, required this.total});
  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    return ExcludeSemantics(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < total; i++)
            Container(
              margin: EdgeInsetsDirectional.all(d.gapXs),
              width: d.gapM,
              height: d.gapM,
              decoration: BoxDecoration(shape: BoxShape.circle, color: i <= step ? c.brand : c.hairline),
            ),
        ],
      ),
    );
  }
}
