import 'dart:io';

import 'package:medbridge_server/src/pod_setup.dart';
import 'package:medbridge_server/src/seed/seeder.dart';

/// Seeds synthetic users for every role plus the B10 patient "R. Doe, 78".
///
///   dart run bin/seed.dart                # plan + care team
///   dart run bin/seed.dart --with-scans   # also the 7 B10 bottle scans
///   dart run bin/seed.dart --reset-invites  # make the test invite codes pending again
///
/// Run while the server is stopped (it boots the same config to reach the
/// database). Synthetic data only.
Future<void> main(List<String> args) async {
  final withScans = args.contains('--with-scans');
  final resetInvites = args.contains('--reset-invites');
  final pod = createPod([
    '--apply-migrations',
    ...args.where(
      (a) => !a.startsWith('--with-scans') && a != '--reset-invites',
    ),
  ]);
  await pod.start();
  final session = await pod.createSession(enableLogging: false);
  try {
    await seed(session, withScans: withScans, resetInvites: resetInvites);
    stdout.writeln(
      'Accounts (email one-time code, printed in the server log):',
    );
    for (final email in seedAccounts.keys) {
      stdout.writeln('  $email');
    }
  } finally {
    await session.close();
    await pod.shutdown(exitProcess: false);
  }
  exit(0);
}
