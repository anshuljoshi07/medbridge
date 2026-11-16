import 'dart:io';

import 'package:medbridge_server/src/core/access.dart';
import 'package:medbridge_server/src/pod_setup.dart';
import 'package:medbridge_server/src/seed/seeder.dart';

/// Admin CLI: clinician accounts are created by an admin, never self-served
/// (A3).
///
///   `dart run bin/admin.dart create-clinician EMAIL ROLE` (pharmacist, clinician, pcp)
Future<void> main(List<String> args) async {
  if (args.length < 3 || args.first != 'create-clinician') {
    stderr.writeln(
      'Usage: dart run bin/admin.dart create-clinician <email> '
      '<pharmacist|clinician|pcp>',
    );
    exit(64);
  }
  final email = args[1].trim().toLowerCase();
  final role = args[2];
  if (!Roles.clinicianRoles.contains(role)) {
    stderr.writeln('Role must be one of ${Roles.clinicianRoles.join(', ')}.');
    exit(64);
  }
  final pod = createPod(args.skip(3).toList());
  await pod.start();
  final session = await pod.createSession(enableLogging: false);
  try {
    final id = await ensureAccount(session, email, {role});
    stdout.writeln('Created $role account $email ($id).');
    stdout.writeln('The patient links it by sharing a $role invite code.');
  } finally {
    await session.close();
    await pod.shutdown(exitProcess: false);
  }
  exit(0);
}
