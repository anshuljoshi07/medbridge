import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'generated/serverpod.dart';

/// The fixed one-time code accepted in development (synthetic data only).
/// Never active in staging or production.
const devLoginCode = '123456';

/// Builds the Serverpod instance with auth configured. Shared by the server,
/// the seed script and the admin CLI so they all see the same providers.
Serverpod createPod(List<String> args) {
  final pod = Serverpod(args);
  final isDev =
      pod.runMode == ServerpodRunMode.development ||
      pod.runMode == ServerpodRunMode.test;
  pod.initializeAuthServices(
    tokenManagerBuilders: [JwtConfigFromPasswords()],
    identityProviderBuilders: [
      // Email one-time passwords (F1).
      // Development: every account signs in with the fixed code
      // [devLoginCode] — no email needed. Staging/production: random codes
      // emailed via Serverpod Cloud (swap for SMTP once credentials exist).
      // Google and Firebase phone IdPs are added here when configured.
      if (isDev)
        EmailIdpConfigFromPasswords(
          otpLoginVerificationCodeGenerator: () => devLoginCode,
          otpLoginVerificationCodeAllowedAttempts: 10,
          maxOtpLoginAttempts: const RateLimit(
            timeframe: Duration(minutes: 1),
            maxAttempts: 100,
          ),
          sendOtpLoginVerificationCode:
              (
                session, {
                required email,
                required otpLoginRequestId,
                required verificationCode,
                required transaction,
              }) {
                session.log('Dev login code for $email: $verificationCode');
              },
        )
      else
        ServerpodCloudEmailIdpConfig(appDisplayName: 'MedBridge'),
    ],
  );
  return pod;
}
