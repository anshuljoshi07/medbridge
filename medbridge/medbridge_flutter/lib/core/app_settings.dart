import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Per-device preferences (A13.4 Settings). Immutable value.
class AppSettings {
  const AppSettings({
    this.lang,
    this.theme = MedThemeVariant.light,
    this.speechRate = 0.5,
    this.showNamesInNotifications = false,
    this.onboarded = false,
  });

  /// Chosen language; `null` until onboarding picks one.
  final Lang? lang;
  final MedThemeVariant theme;

  /// Read-aloud rate, 0..1 (platform TTS scale).
  final double speechRate;

  /// Lock-screen reminders show drug names only if the user opts in (A13.5).
  final bool showNamesInNotifications;
  final bool onboarded;

  AppSettings copyWith({
    Lang? lang,
    MedThemeVariant? theme,
    double? speechRate,
    bool? showNamesInNotifications,
    bool? onboarded,
  }) => AppSettings(
    lang: lang ?? this.lang,
    theme: theme ?? this.theme,
    speechRate: speechRate ?? this.speechRate,
    showNamesInNotifications:
        showNamesInNotifications ?? this.showNamesInNotifications,
    onboarded: onboarded ?? this.onboarded,
  );

  static const _kLang = 'settings.v1.lang';
  static const _kTheme = 'settings.v1.theme';
  static const _kRate = 'settings.v1.speechRate';
  static const _kNames = 'settings.v1.showNames';
  static const _kOnboarded = 'settings.v1.onboarded';

  /// Loads settings before the first frame. Unknown stored values fall back
  /// explicitly to defaults.
  static Future<AppSettings> load(SharedPreferences p) async => AppSettings(
    lang: Lang.values.where((l) => l.name == p.getString(_kLang)).firstOrNull,
    theme:
        MedThemeVariant.values
            .where((v) => v.name == p.getString(_kTheme))
            .firstOrNull ??
        MedThemeVariant.light,
    speechRate: p.getDouble(_kRate) ?? 0.5,
    showNamesInNotifications: p.getBool(_kNames) ?? false,
    onboarded: p.getBool(_kOnboarded) ?? false,
  );

  Future<void> save(SharedPreferences p) async {
    if (lang != null) await p.setString(_kLang, lang!.name);
    await p.setString(_kTheme, theme.name);
    await p.setDouble(_kRate, speechRate);
    await p.setBool(_kNames, showNamesInNotifications);
    await p.setBool(_kOnboarded, onboarded);
  }
}

/// Shared preferences instance, overridden in bootstrap.
final prefsProvider = Provider<SharedPreferences>(
  (ref) => throw StateError('prefsProvider must be overridden in bootstrap'),
);

/// Initial settings, loaded before `runApp`, overridden in bootstrap.
final initialSettingsProvider = Provider<AppSettings>(
  (ref) => const AppSettings(),
);

/// The settings ViewModel: persist first, then publish.
class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.read(initialSettingsProvider);

  Future<void> update(AppSettings next) async {
    await next.save(ref.read(prefsProvider));
    state = next;
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);
