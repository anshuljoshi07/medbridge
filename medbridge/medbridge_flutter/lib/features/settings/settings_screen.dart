import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

import '../../core/app_settings.dart';
import '../../data/app_data.dart';
import '../../data/med_repository.dart';

/// Settings (A13.4): language, read-aloud speed, theme, notification names,
/// sign out. Text size follows the system setting and is never clamped.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final s = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              Text(l.language, style: Theme.of(context).textTheme.titleLarge),
              SegmentedButton<Lang>(
                segments: const [
                  ButtonSegment(value: Lang.en, label: Text('English')),
                  ButtonSegment(value: Lang.es, label: Text('Español')),
                ],
                selected: {s.lang ?? Lang.en},
                onSelectionChanged: (v) async {
                  await notifier.update(s.copyWith(lang: v.first));
                  await ref.read(repositoryProvider).updateLang(v.first.name).catchError((_) {});
                },
              ),
              if (s.lang == Lang.es) Padding(padding: EdgeInsetsDirectional.only(top: d.gapS), child: Text(l.pendingTranslatorReview)),
              SizedBox(height: d.gapL),
              Text(l.theme, style: Theme.of(context).textTheme.titleLarge),
              SegmentedButton<MedThemeVariant>(
                segments: [
                  ButtonSegment(value: MedThemeVariant.light, label: Text(l.themeLight)),
                  ButtonSegment(value: MedThemeVariant.dark, label: Text(l.themeDark)),
                  ButtonSegment(value: MedThemeVariant.highContrast, label: Text(l.themeHighContrast)),
                ],
                selected: {s.theme},
                onSelectionChanged: (v) => notifier.update(s.copyWith(theme: v.first)),
              ),
              SizedBox(height: d.gapL),
              Text(l.speechRate, style: Theme.of(context).textTheme.titleLarge),
              Slider(
                value: s.speechRate,
                min: 0.2,
                max: 0.8,
                divisions: 6,
                label: s.speechRate.toStringAsFixed(1),
                onChanged: (v) => notifier.update(s.copyWith(speechRate: v)),
              ),
              SwitchListTile(
                value: s.showNamesInNotifications,
                onChanged: (v) => notifier.update(s.copyWith(showNamesInNotifications: v)),
                title: Text(l.notificationPrimer),
              ),
              SizedBox(height: d.gapL),
              BigButton(
                label: l.signOut,
                icon: Icons.logout,
                secondary: true,
                onPressed: () async {
                  await ref.read(repositoryProvider).signOut();
                  await notifier.update(s.copyWith(onboarded: false));
                  ref.invalidate(meProvider);
                  if (context.mounted) context.go('/sign-in');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
