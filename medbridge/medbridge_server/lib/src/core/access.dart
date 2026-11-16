import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// App roles, stored as auth-user scopes (B5 step 3).
abstract final class Roles {
  /// A patient (default for self sign-up).
  static const patient = 'patient';

  /// A caregiver linked by invite.
  static const caregiver = 'caregiver';

  /// A pharmacist: can verify and edit plans.
  static const pharmacist = 'pharmacist';

  /// A clinician: read and answer only.
  static const clinician = 'clinician';

  /// A primary-care physician: read and answer only.
  static const pcp = 'pcp';

  /// An administrator who creates clinician accounts.
  static const admin = 'admin';

  /// Roles that may use the clinician dashboard.
  static const clinicianRoles = {pharmacist, clinician, pcp};
}

/// The authenticated user's id. Endpoints all `requireLogin`, so this is
/// always present inside an endpoint method.
UuidValue callerId(Session session) {
  final auth = session.authenticated;
  if (auth == null) throw AccessDeniedException(message: 'Sign in first.');
  return auth.authUserId;
}

/// The caller's role names, read from the auth user record so that a role
/// granted after sign-in takes effect immediately.
Future<Set<String>> callerRoles(Session session) async {
  final user = await AuthUser.db.findById(session, callerId(session));
  return user?.scopeNames ?? const {};
}

/// Adds [role] to the auth user's scopes (idempotent).
Future<void> grantRole(Session session, UuidValue userId, String role) async {
  final user = await AuthUser.db.findById(session, userId);
  if (user == null || user.scopeNames.contains(role)) return;
  await AuthUser.db.updateRow(
    session,
    user.copyWith(scopeNames: {...user.scopeNames, role}),
  );
}

/// Throws unless the caller has one of [roles].
Future<void> requireRole(Session session, Set<String> roles) async {
  final mine = await callerRoles(session);
  if (!mine.any(roles.contains)) {
    throw AccessDeniedException(message: 'Your account cannot do this.');
  }
}

/// Resolves the patient the caller may act on (A10 `requireLink`).
///
/// With no [patientId], the caller's own patient profile. Otherwise the
/// caller must be that patient, or hold an active [CareLink] with one of
/// [roles]. Unlinked callers get [AccessDeniedException] (403) — they can
/// never see unlinked patients.
Future<Patient> requireLink(
  Session session, {
  int? patientId,
  Set<CareRole> roles = const {},
}) async {
  final uid = callerId(session);
  if (patientId == null) {
    final own = await Patient.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(uid),
    );
    if (own == null) {
      throw AccessDeniedException(message: 'No patient profile yet.');
    }
    return own;
  }
  final patient = await Patient.db.findById(session, patientId);
  if (patient == null) throw AccessDeniedException(message: 'Not found.');
  if (patient.userId == uid) return patient;
  final link = await CareLink.db.findFirstRow(
    session,
    where: (t) =>
        t.patientId.equals(patientId) &
        t.userId.equals(uid) &
        t.status.equals(LinkStatus.active),
  );
  if (link == null || !roles.contains(link.role)) {
    throw AccessDeniedException(message: 'You are not linked to this patient.');
  }
  return patient;
}

/// Every role that may read a linked patient's data.
const Set<CareRole> anyCareRole = {
  CareRole.caregiver,
  CareRole.pharmacist,
  CareRole.clinician,
  CareRole.pcp,
};

/// Clinical roles (dashboard users).
const Set<CareRole> clinicalCareRoles = {
  CareRole.pharmacist,
  CareRole.clinician,
  CareRole.pcp,
};

/// Writes an [AuditLog] row for a PHI read or write.
Future<void> audit(
  Session session,
  String action,
  String entity,
  Object entityId,
) async {
  await AuditLog.db.insertRow(
    session,
    AuditLog(
      actorUserId: session.authenticated?.authUserId,
      action: action,
      entity: entity,
      entityId: '$entityId',
    ),
  );
}
