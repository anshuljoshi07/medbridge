import 'package:flutter_localizations/flutter_localizations.dart' as legacy;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

import 'core/app_settings.dart';
import 'routing/router.dart';

/// The app: theme and locale from settings, routing from [routerProvider].
class MedBridgeApp extends ConsumerWidget {
  const MedBridgeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(routerProvider);
    final variant = settings.theme;
    return MaterialApp.router(
      title: 'MedBridge',
      debugShowCheckedModeBanner: false,
      theme: buildMedTheme(variant),
      themeAnimationStyle: AnimationStyle.noAnimation,
      locale: Locale((settings.lang ?? Lang.en).name),
      supportedLocales: MedL10n.supportedLocales,
      localizationsDelegates: const [
        ...medLocalizationsDelegates,
        // Serverpod's sign-in widgets still use the framework Material types.
        legacy.GlobalMaterialLocalizations.delegate,
        legacy.GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
