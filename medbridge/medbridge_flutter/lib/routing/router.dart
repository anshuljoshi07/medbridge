import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../core/app_settings.dart';
import '../core/providers.dart';
import '../features/auth/sign_in_screen.dart';
import '../features/bottle_scan/choice_screen.dart';
import '../features/bottle_scan/confirm_screen.dart';
import '../features/bottle_scan/scan_screen.dart';
import '../features/care_team/care_team_screen.dart';
import '../features/home/home_shell.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/plan_capture/capture_screen.dart';
import '../features/plan_capture/review_screen.dart';
import '../features/results/result_screen.dart';
import '../features/settings/settings_screen.dart';

/// Route paths.
abstract final class Routes {
  static const signIn = '/sign-in';
  static const onboarding = '/onboarding';
  static const home = '/';
  static const capture = '/capture';
  static const review = '/review';
  static const scan = '/scan';
  static const confirm = '/scan/confirm';
  static const choice = '/scan/choice';
  static const result = '/scan/result';
  static const careTeam = '/care-team';
  static const settings = '/settings';
}

/// The single router: auth + onboarding guards, deep link /invite/:code.
final routerProvider = Provider<GoRouter>((ref) {
  final client = ref.watch(clientProvider);
  final router = GoRouter(
    initialLocation: Routes.home,
    refreshListenable: client.auth.authInfoListenable,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      if (!client.auth.isAuthenticated) {
        return loc == Routes.signIn ? null : Routes.signIn;
      }
      final onboarded = ref.read(settingsProvider).onboarded;
      if (!onboarded && loc != Routes.onboarding) return Routes.onboarding;
      if (onboarded && (loc == Routes.signIn || loc == Routes.onboarding)) {
        return Routes.home;
      }
      return null;
    },
    routes: [
      GoRoute(path: Routes.signIn, builder: (_, _) => const SignInScreen()),
      GoRoute(path: Routes.onboarding, builder: (_, _) => const OnboardingScreen()),
      GoRoute(
        path: Routes.home,
        builder: (_, s) => HomeShell(initialTab: int.tryParse(s.uri.queryParameters['tab'] ?? '') ?? 0),
      ),
      GoRoute(path: Routes.capture, builder: (_, _) => const CaptureScreen()),
      GoRoute(path: Routes.review, builder: (_, _) => const ReviewScreen()),
      GoRoute(path: Routes.scan, builder: (_, _) => const ScanScreen()),
      GoRoute(path: Routes.confirm, builder: (_, _) => const ConfirmScreen()),
      GoRoute(path: Routes.choice, builder: (_, _) => const ChoiceScreen()),
      GoRoute(path: Routes.result, builder: (_, _) => const ResultScreen()),
      GoRoute(path: Routes.careTeam, builder: (_, _) => const CareTeamScreen()),
      GoRoute(path: Routes.settings, builder: (_, _) => const SettingsScreen()),
      GoRoute(
        path: '/invite/:code',
        builder: (_, s) => CareTeamScreen(inviteCode: s.pathParameters['code']),
      ),
    ],
    errorBuilder: (_, _) => const HomeShell(initialTab: 0),
  );
  ref.onDispose(router.dispose);
  return router;
});

/// Navigation helpers used by screens.
extension NavX on BuildContext {
  void goHome([int tab = 0]) => go('${Routes.home}?tab=$tab');
}
