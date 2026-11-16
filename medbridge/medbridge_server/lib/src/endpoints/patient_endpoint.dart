import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../core/access.dart';
import '../generated/protocol.dart';

/// The caller's own profile and preferences (A10 `patient`).
class PatientEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Who the caller is: own patient profile, roles, and linked patients.
  Future<MeView> me(Session session) async {
    final uid = callerId(session);
    final patient = await Patient.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(uid),
    );
    final links = await CareLink.db.find(
      session,
      where: (t) => t.userId.equals(uid) & t.status.equals(LinkStatus.active),
    );
    final linked = links.isEmpty
        ? <Patient>[]
        : await Patient.db.find(
            session,
            where: (t) => t.id.inSet({for (final l in links) l.patientId}),
            orderBy: (t) => t.firstName,
          );
    return MeView(
      patient: patient,
      roles: (await callerRoles(session)).toList()..sort(),
      linkedPatients: linked,
    );
  }

  /// Onboarding: become a patient or a caregiver. Clinician roles are only
  /// granted by an admin (`bin/admin.dart`).
  Future<MeView> register(
    Session session,
    String role,
    String firstName,
    String lang,
    int utcOffsetMin,
  ) async {
    if (role != Roles.patient && role != Roles.caregiver) {
      throw AccessDeniedException(message: 'Choose patient or caregiver.');
    }
    final uid = callerId(session);
    await grantRole(session, uid, role);
    if (role == Roles.patient) {
      final existing = await Patient.db.findFirstRow(
        session,
        where: (t) => t.userId.equals(uid),
      );
      final row = Patient(
        id: existing?.id,
        userId: uid,
        firstName: firstName.trim().isEmpty ? 'Patient' : firstName.trim(),
        lang: lang,
        utcOffsetMin: utcOffsetMin,
        allergiesJson: existing?.allergiesJson ?? '[]',
      );
      existing == null
          ? await Patient.db.insertRow(session, row)
          : await Patient.db.updateRow(session, row);
    }
    return me(session);
  }

  /// Updates language, name and time-zone offset.
  Future<Patient> updatePrefs(
    Session session,
    String lang,
    int utcOffsetMin, {
    String? firstName,
  }) async {
    final p = await requireLink(session);
    return Patient.db.updateRow(
      session,
      p.copyWith(
        lang: lang,
        utcOffsetMin: utcOffsetMin,
        firstName: firstName ?? p.firstName,
      ),
    );
  }

  /// Replaces the patient's allergy list (lower-case terms).
  Future<Patient> setAllergies(Session session, List<String> allergies) async {
    final p = await requireLink(session);
    await audit(session, 'write', 'patient.allergies', p.id!);
    final terms = {
      for (final a in allergies)
        if (a.trim().isNotEmpty) a.trim().toLowerCase(),
    }.toList()..sort();
    return Patient.db.updateRow(
      session,
      p.copyWith(allergiesJson: jsonEncode(terms)),
    );
  }
}
