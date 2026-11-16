import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../core/providers.dart';
import '../../data/app_data.dart';

/// F1 sign-in. Email one-time code today; Google and phone OTP appear here
/// automatically once their server IdPs are configured (HUMAN, B0).
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.appName)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              Text(l.tagline, style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: d.gapL),
              SignInWidget(
                client: ref.watch(clientProvider),
                onAuthenticated: () {
                  ref.invalidate(meProvider);
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
