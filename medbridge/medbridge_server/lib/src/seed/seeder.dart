import 'dart:io';

import 'package:med_core/med_core.dart' as core;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../core/access.dart';
import '../core/adapters.dart';
import '../generated/protocol.dart';
import '../services/plan_repository.dart';
import '../services/scan_service.dart';

/// Synthetic demo accounts (B5 step 8). Sign in with email one-time codes;
/// in development the code is printed in the server console.
const seedAccounts = {
  'rdoe@medbridge.test': ('R.', <String>{Roles.patient}),
  'jsmith@medbridge.test': ('J.', <String>{Roles.patient}),
  'caregiver@medbridge.test': ('Sam', <String>{Roles.caregiver}),
  'pharmacist@medbridge.test': ('Pat', <String>{Roles.pharmacist}),
  'clinician@medbridge.test': ('Casey', <String>{Roles.clinician}),
  'pcp@medbridge.test': ('Dr. Lee', <String>{Roles.pcp}),
  'admin@medbridge.test': ('Admin', <String>{Roles.admin}),
};

/// The B10 discharge summary, as OCR lines. Synthetic.
const rDoeAvs = [
  'Carle Foundation Hospital - After Visit Summary',
  'Patient: R. Doe   Age: 78',
  'Allergies: Penicillin',
  'START taking these medications',
  'losartan 50 mg tablet',
  'Take 1 tab PO daily',
  'Commonly known as: Cozaar',
  'CHANGE how you take these medications',
  'metoprolol succinate ER 25 mg tablet',
  'Take 1 tab PO daily',
  'CONTINUE taking these medications',
  'atorvastatin 40 mg tablet',
  'Take 1 tab PO QHS',
  'HOLD these medications',
  'metformin 500 mg tablet',
  'Take 1 tab PO BID',
  'until follow-up',
  'STOP taking these medications',
  'lisinopril 10 mg tablet',
  'Follow-up appointments',
];

/// The B10 bottles as (label drug line, label sig).
const rDoeBottles = [
  ('lisinopril 10 mg tablet', 'Take 1 tablet by mouth daily'),
  ('losartan potassium 50 mg tab', 'Take 1 tablet by mouth daily'),
  ('metoprolol succ ER 50 mg tab', 'Take 1 tablet by mouth daily'),
  ('atorvastatin 40 mg tablet', 'Take 1 tablet by mouth at bedtime'),
  ('metformin HCl 500 mg tablet', 'Take 1 tablet by mouth twice daily'),
  ('benazepril 20 mg tablet', 'Take 1 tablet by mouth daily'),
  ('omeprazole DR 20 mg capsule', 'Take 1 capsule by mouth daily'),
];

/// Fixed, documented invite codes for testing (single-use; re-run the seed
/// with `--reset-invites` to make them pending again).
/// (code, role, patient email).
const seedInvites = [
  ('CARE2345', CareRole.caregiver, 'jsmith@medbridge.test'),
  ('PHRM2345', CareRole.pharmacist, 'jsmith@medbridge.test'),
  ('DCTR2345', CareRole.clinician, 'jsmith@medbridge.test'),
  ('PCPD2345', CareRole.pcp, 'jsmith@medbridge.test'),
  ('RDCG2345', CareRole.caregiver, 'rdoe@medbridge.test'),
];

/// A second synthetic patient (J. Smith, 71) with no care team linked yet,
/// so the invite codes above have someone to link to. Includes warfarin
/// (high-risk) to exercise the safety overlays.
const jSmithAvs = [
  'After Visit Summary',
  'Allergies: Sulfa',
  'START taking these medications',
  'lisinopril 10 mg tablet',
  'Take 1 tab PO daily',
  'CONTINUE taking these medications',
  'warfarin 5 mg tablet',
  'Take 1 tab PO QPM',
  'metformin 500 mg tablet',
  'Take 1 tab PO BID PC',
  'STOP taking these medications',
  'simvastatin 20 mg tablet',
  'Follow-up appointments',
];

/// Seeds every role, two synthetic patients and the test invite codes.
/// Idempotent: existing patients are left untouched.
Future<void> seed(
  Session session, {
  required bool withScans,
  bool resetInvites = false,
}) async {
  final ids = <String, UuidValue>{};
  for (final e in seedAccounts.entries) {
    ids[e.key] = await ensureAccount(session, e.key, e.value.$2);
  }
  final lexicon = core.Lexicon.fromTsv(
    File('../packages/med_core/assets/lexicon.tsv').readAsStringSync(),
  );
  final rDoe = await _ensurePatient(
    session,
    ids['rdoe@medbridge.test']!,
    name: 'R.',
    age: 78,
    allergies: {'penicillin', 'penicillins'},
    avs: rDoeAvs,
    lexicon: lexicon,
    onCreated: (patient, view) async {
      for (final (email, role) in [
        ('caregiver@medbridge.test', CareRole.caregiver),
        ('pharmacist@medbridge.test', CareRole.pharmacist),
        ('clinician@medbridge.test', CareRole.clinician),
        ('pcp@medbridge.test', CareRole.pcp),
      ]) {
        await CareLink.db.insertRow(
          session,
          CareLink(
            patientId: patient.id!,
            userId: ids[email],
            role: role,
            status: LinkStatus.active,
            inviteCode: 'SEED${role.name.toUpperCase()}',
          ),
        );
      }
      if (withScans) {
        final ctx = planToCore(view.plan, view.items);
        for (final (drug, sig) in rDoeBottles) {
          await ScanService.submit(
            session,
            patient,
            _scan(drug, sig, lexicon, ctx),
          );
        }
      }
    },
  );
  final jSmith = await _ensurePatient(
    session,
    ids['jsmith@medbridge.test']!,
    name: 'J.',
    age: 71,
    allergies: {'sulfa'},
    avs: jSmithAvs,
    lexicon: lexicon,
  );
  final patients = {
    'rdoe@medbridge.test': rDoe,
    'jsmith@medbridge.test': jSmith,
  };
  for (final (code, role, email) in seedInvites) {
    final existing = await CareLink.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(code),
    );
    if (existing != null && !resetInvites) continue;
    if (existing != null) await CareLink.db.deleteRow(session, existing);
    await CareLink.db.insertRow(
      session,
      CareLink(patientId: patients[email]!.id!, role: role, inviteCode: code),
    );
  }
  stdout.writeln(
    'Seeded patients R. Doe (${rDoe.id}) and J. Smith (${jSmith.id}); '
    'invites: ${seedInvites.map((i) => i.$1).join(', ')}.',
  );
}

Future<Patient> _ensurePatient(
  Session session,
  UuidValue userId, {
  required String name,
  required int age,
  required Set<String> allergies,
  required List<String> avs,
  required core.Lexicon lexicon,
  Future<void> Function(Patient, PlanView)? onCreated,
}) async {
  final existing = await Patient.db.findFirstRow(
    session,
    where: (t) => t.userId.equals(userId),
  );
  if (existing != null) return existing;
  final patient = await Patient.db.insertRow(
    session,
    Patient(
      userId: userId,
      firstName: name,
      birthYear: DateTime.now().year - age,
      utcOffsetMin: -360,
      allergiesJson: encodeList(allergies),
    ),
  );
  final view = await _seedPlan(session, patient, lexicon, avs);
  await onCreated?.call(patient, view);
  return patient;
}

/// Creates (or finds) an email-login account with [roles].
Future<UuidValue> ensureAccount(
  Session session,
  String email,
  Set<String> roles,
) async {
  final found = await EmailAccount.db.findFirstRow(
    session,
    where: (t) => t.email.equals(email),
  );
  if (found != null) {
    for (final r in roles) {
      await grantRole(session, found.authUserId, r);
    }
    return found.authUserId;
  }
  final user = await AuthServices.instance.authUsers.create(
    session,
    scopes: {for (final r in roles) Scope(r)},
  );
  await AuthServices.getIdentityProvider<EmailIdp>().admin
      .createEmailAuthentication(
        session,
        authUserId: user.id,
        email: email,
        password: null,
      );
  return user.id;
}

Future<PlanView> _seedPlan(
  Session session,
  Patient patient,
  core.Lexicon lexicon,
  List<String> avs,
) async {
  final draft = core.parseAvs(
    [for (final l in avs) core.OcrLine(l)],
    lexicon,
    core.ShippedRules.avsRules,
    core.ShippedRules.sigRules,
    core.ShippedRules.ruleSet.config,
  );
  final plan = await DischargePlan.db.insertRow(
    session,
    DischargePlan(
      patientId: patient.id!,
      status: PlanStatus.unverified,
      allergiesJson: encodeList(draft.allergies),
      dischargeDate: DateTime.now().toUtc(),
    ),
  );
  final rows = await PlanItemRow.db.insert(session, [
    for (final i in draft.items)
      planItemRowFromInput(
        PlanItemInput(
          itemKey: i.ings.first,
          action: i.action.name,
          name: i.name,
          rxcui: i.rxcui,
          ings: i.ings.toList(),
          strength: i.strength?.display,
          form: i.name,
          sigRaw: i.sigRaw,
          holdUntil: i.holdUntil,
          holdNote: i.holdNote,
          src: i.src,
          conf: i.conf,
          classIds: i.classIds.toList(),
        ),
        plan.id!,
      ),
  ]);
  final view = PlanView(plan: plan, items: rows);
  await PlanRepository.syncSchedules(session, view);
  return view;
}

ScanInput _scan(String drug, String sig, core.Lexicon lx, core.Plan ctx) {
  final d = core.parseLabel(
    [
      core.OcrFrame([core.OcrLine(drug), core.OcrLine(sig)]),
      core.OcrFrame([core.OcrLine(drug), core.OcrLine(sig)]),
    ],
    lx,
    ctx,
    core.ShippedRules.ruleSet,
    core.ShippedRules.sigRules,
  );
  return ScanInput(
    rxcui: d.rxcui,
    name: '${d.name} ${d.strength?.display ?? ''}'.trim(),
    ings: d.ings.toList(),
    strength: d.strength?.display,
    form: drug,
    sigRaw: d.sigRaw,
    conf: d.conf,
    confirmed: true,
    classIds: d.classIds.toList(),
    ocrText: d.lines.join('\n'),
  );
}
