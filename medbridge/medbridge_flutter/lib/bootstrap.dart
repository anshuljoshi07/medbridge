import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:medbridge_client/medbridge_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'core/app_settings.dart';
import 'core/providers.dart';

/// Composition root: error net first, settings before first paint, real
/// infrastructure injected once via provider overrides.
Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Uncaught: $error\n$stack');
    return true;
  };

  final prefs = await SharedPreferences.getInstance();
  final settings = await AppSettings.load(prefs);

  final client = Client(await getServerUrl())
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();
  await client.auth.initialize();

  // Licenses for the bundled font.
  LicenseRegistry.addLicense(() async* {
    final text = await rootBundle.loadString('packages/med_ui/assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['AtkinsonHyperlegible'], text);
  });

  runApp(
    ProviderScope(
      overrides: [
        clientProvider.overrideWithValue(client),
        prefsProvider.overrideWithValue(prefs),
        initialSettingsProvider.overrideWithValue(settings),
      ],
      child: const MedBridgeApp(),
    ),
  );
}
