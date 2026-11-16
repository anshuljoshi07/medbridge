/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:medbridge_client/src/protocol/alert.dart' as _ighnstc1;
import 'package:medbridge_client/src/protocol/bottle_scan.dart' as _i5t4wkob;
import 'package:medbridge_client/src/protocol/care_link.dart' as _i3x46ubp;
import 'package:medbridge_client/src/protocol/care_role.dart' as _iqy5onlp;
import 'package:medbridge_client/src/protocol/dose_event.dart' as _itrc8y2p;
import 'package:medbridge_client/src/protocol/dose_state.dart' as _i97051ze;
import 'package:medbridge_client/src/protocol/dto/flagged_scan.dart'
    as _ip4xoa2x;
import 'package:medbridge_client/src/protocol/dto/me_view.dart' as _ip0s4txh;
import 'package:medbridge_client/src/protocol/dto/patient_summary.dart'
    as _i36xms3u;
import 'package:medbridge_client/src/protocol/dto/pcp_summary.dart'
    as _in5smcew;
import 'package:medbridge_client/src/protocol/dto/plan_draft_input.dart'
    as _i8kpeunr;
import 'package:medbridge_client/src/protocol/dto/plan_item_input.dart'
    as _izysdavh;
import 'package:medbridge_client/src/protocol/dto/plan_view.dart' as _ibj0as6u;
import 'package:medbridge_client/src/protocol/dto/recon_outcome.dart'
    as _izowlg7b;
import 'package:medbridge_client/src/protocol/dto/rx_hit.dart' as _iba2asag;
import 'package:medbridge_client/src/protocol/dto/scan_history_entry.dart'
    as _irf1034y;
import 'package:medbridge_client/src/protocol/dto/scan_input.dart' as _igf13yeg;
import 'package:medbridge_client/src/protocol/dto/schedule_view.dart'
    as _iy3ix7sn;
import 'package:medbridge_client/src/protocol/patient.dart' as _igj7avxr;
import 'package:medbridge_client/src/protocol/plan_item_row.dart' as _i3aqtgxi;
import 'package:medbridge_client/src/protocol/question.dart' as _ile5b8en;
import 'package:medbridge_client/src/protocol/recon_row.dart' as _i499jppp;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// By extending [EmailOtpIdpBaseEndpoint], the email identity provider
/// endpoints, including the passwordless sign-in with one-time passwords, are
/// made available on the server and enable the corresponding sign-in widget on
/// the client.
///
/// Extend [EmailIdpBaseEndpoint] instead for the password based sign-in only.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailOtpIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Starts a passwordless login by sending a one-time password to [email].
  ///
  /// The code is sent whether or not an account is registered for the email.
  /// If none is, verifying the code lets the user create a new account.
  ///
  /// Always returns a login request ID, which must be passed to
  /// [verifyOtpLoginCode] together with the one-time password.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the email is
  ///   not valid.
  /// - [EmailAccountRequestExceptionReason.tooManyAttempts] if too many
  ///   one-time passwords have been requested for the email.
  @override
  _ida.Future<_isc.UuidValue> startOtpLogin({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startOtpLogin',
        {'email': email},
      );

  /// Verifies a one-time password and returns a token to complete the login.
  ///
  /// If [EmailAccountOtpVerificationResult.accountExists] is `true`, pass the
  /// token to [finishOtpLogin] to sign in. Otherwise, have the user accept the
  /// terms (and optionally set a password if
  /// [EmailAccountOtpVerificationResult.allowPassword] is `true`) and pass it
  /// to [finishOtpRegistration] to create the account.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the login request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts to verify the code.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists for
  ///   the given [otpLoginRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<_iaic.EmailAccountOtpVerificationResult> verifyOtpLoginCode({
    required _isc.UuidValue otpLoginRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<_iaic.EmailAccountOtpVerificationResult>(
    'emailIdp',
    'verifyOtpLoginCode',
    {
      'otpLoginRequestId': otpLoginRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a passwordless login for an existing account and returns a new
  /// session.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the login request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [otpLoginToken] is
  ///   invalid or no account exists for the email.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> finishOtpLogin({
    required String otpLoginToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishOtpLogin',
    {'otpLoginToken': otpLoginToken},
  );

  /// Completes a passwordless login for an email without an account, by
  /// creating a new auth user with a profile and attaching the verified email
  /// to it.
  ///
  /// Must only be called after the user accepted the terms. The [password] is
  /// optional, and may only be set if
  /// [EmailAccountOtpVerificationResult.allowPassword] was `true`.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the login request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if a password is
  ///   given but not allowed, or it does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [otpLoginToken] is
  ///   invalid or an account already exists for the email.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishOtpRegistration({
    required String otpLoginToken,
    String? password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishOtpRegistration',
    {
      'otpLoginToken': otpLoginToken,
      'password': password,
    },
  );

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Caregiver alerts (A10 `alerts`, F7). Dispatch runs as a future call.
/// {@category Endpoint}
class EndpointAlerts extends _isc.EndpointRef {
  EndpointAlerts(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'alerts';

  /// Alerts for a patient the caller is linked to, newest first.
  _ida.Future<List<_ighnstc1.Alert>> list({int? patientId}) =>
      caller.callServerEndpoint<List<_ighnstc1.Alert>>(
        'alerts',
        'list',
        {'patientId': patientId},
      );

  /// Acknowledges an alert.
  _ida.Future<_ighnstc1.Alert> ack(int alertId) =>
      caller.callServerEndpoint<_ighnstc1.Alert>(
        'alerts',
        'ack',
        {'alertId': alertId},
      );
}

/// Patient-initiated care-team linking (A10 `care`, F7).
/// {@category Endpoint}
class EndpointCare extends _isc.EndpointRef {
  EndpointCare(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'care';

  /// The patient creates an invite code for a caregiver or clinician.
  _ida.Future<_i3x46ubp.CareLink> createInvite(_iqy5onlp.CareRole role) =>
      caller.callServerEndpoint<_i3x46ubp.CareLink>(
        'care',
        'createInvite',
        {'role': role},
      );

  /// The invited person accepts with the code. Clinical invites require an
  /// admin-created account with the matching role.
  _ida.Future<_i3x46ubp.CareLink> acceptInvite(String code) =>
      caller.callServerEndpoint<_i3x46ubp.CareLink>(
        'care',
        'acceptInvite',
        {'code': code},
      );

  /// The patient removes a link.
  _ida.Future<_i3x46ubp.CareLink> revoke(int linkId) =>
      caller.callServerEndpoint<_i3x46ubp.CareLink>(
        'care',
        'revoke',
        {'linkId': linkId},
      );

  /// For a patient: their care team. For anyone else: their own links.
  _ida.Future<List<_i3x46ubp.CareLink>> links() =>
      caller.callServerEndpoint<List<_i3x46ubp.CareLink>>(
        'care',
        'links',
        {},
      );
}

/// Clinician dashboard data (A10 `dashboard`, F10). Clinical roles only;
/// only linked patients are ever returned.
/// {@category Endpoint}
class EndpointDashboard extends _isc.EndpointRef {
  EndpointDashboard(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dashboard';

  /// Linked patients with red / amber counts, red-first.
  _ida.Future<List<_i36xms3u.PatientSummary>> patients() =>
      caller.callServerEndpoint<List<_i36xms3u.PatientSummary>>(
        'dashboard',
        'patients',
        {},
      );

  /// Red and amber results across linked patients, red first, newest first.
  _ida.Future<List<_ip4xoa2x.FlaggedScan>> flagged() =>
      caller.callServerEndpoint<List<_ip4xoa2x.FlaggedScan>>(
        'dashboard',
        'flagged',
        {},
      );

  /// Read-only PCP summary for one linked patient.
  _ida.Future<_in5smcew.PcpSummary> summary(int patientId) =>
      caller.callServerEndpoint<_in5smcew.PcpSummary>(
        'dashboard',
        'summary',
        {'patientId': patientId},
      );

  /// Marks a flagged result as reviewed, with a note.
  _ida.Future<_i499jppp.ReconRow> resolveFlag(
    int reconId,
    String note,
  ) => caller.callServerEndpoint<_i499jppp.ReconRow>(
    'dashboard',
    'resolveFlag',
    {
      'reconId': reconId,
      'note': note,
    },
  );
}

/// The caller's own profile and preferences (A10 `patient`).
/// {@category Endpoint}
class EndpointPatient extends _isc.EndpointRef {
  EndpointPatient(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'patient';

  /// Who the caller is: own patient profile, roles, and linked patients.
  _ida.Future<_ip0s4txh.MeView> me() =>
      caller.callServerEndpoint<_ip0s4txh.MeView>(
        'patient',
        'me',
        {},
      );

  /// Onboarding: become a patient or a caregiver. Clinician roles are only
  /// granted by an admin (`bin/admin.dart`).
  _ida.Future<_ip0s4txh.MeView> register(
    String role,
    String firstName,
    String lang,
    int utcOffsetMin,
  ) => caller.callServerEndpoint<_ip0s4txh.MeView>(
    'patient',
    'register',
    {
      'role': role,
      'firstName': firstName,
      'lang': lang,
      'utcOffsetMin': utcOffsetMin,
    },
  );

  /// Updates language, name and time-zone offset.
  _ida.Future<_igj7avxr.Patient> updatePrefs(
    String lang,
    int utcOffsetMin, {
    String? firstName,
  }) => caller.callServerEndpoint<_igj7avxr.Patient>(
    'patient',
    'updatePrefs',
    {
      'lang': lang,
      'utcOffsetMin': utcOffsetMin,
      'firstName': firstName,
    },
  );

  /// Replaces the patient's allergy list (lower-case terms).
  _ida.Future<_igj7avxr.Patient> setAllergies(List<String> allergies) =>
      caller.callServerEndpoint<_igj7avxr.Patient>(
        'patient',
        'setAllergies',
        {'allergies': allergies},
      );
}

/// Discharge plans (A10 `plan`, F2).
/// {@category Endpoint}
class EndpointPlan extends _isc.EndpointRef {
  EndpointPlan(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'plan';

  /// Stores a parsed AVS as a new `draft` plan for the caller.
  _ida.Future<_ibj0as6u.PlanView> uploadDraft(_i8kpeunr.PlanDraftInput draft) =>
      caller.callServerEndpoint<_ibj0as6u.PlanView>(
        'plan',
        'uploadDraft',
        {'draft': draft},
      );

  /// The patient confirms the reviewed plan: `draft` → `unverified`, and
  /// reminders are scheduled.
  _ida.Future<_ibj0as6u.PlanView> confirm(int planId) =>
      caller.callServerEndpoint<_ibj0as6u.PlanView>(
        'plan',
        'confirm',
        {'planId': planId},
      );

  /// The newest plan for the caller or a linked patient.
  _ida.Future<_ibj0as6u.PlanView?> get({int? patientId}) =>
      caller.callServerEndpoint<_ibj0as6u.PlanView?>(
        'plan',
        'get',
        {'patientId': patientId},
      );

  /// Pharmacist verifies the plan (badge in the app).
  _ida.Future<_ibj0as6u.PlanView> verify(int planId) =>
      caller.callServerEndpoint<_ibj0as6u.PlanView>(
        'plan',
        'verify',
        {'planId': planId},
      );

  /// Pharmacist edits one extracted item; schedules follow the edit.
  _ida.Future<_i3aqtgxi.PlanItemRow> editItem(
    int itemId,
    _izysdavh.PlanItemInput input,
  ) => caller.callServerEndpoint<_i3aqtgxi.PlanItemRow>(
    'plan',
    'editItem',
    {
      'itemId': itemId,
      'input': input,
    },
  );
}

/// The Q&A list (A10 `questions`, F6).
/// {@category Endpoint}
class EndpointQuestions extends _isc.EndpointRef {
  EndpointQuestions(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'questions';

  /// All questions for the caller or a linked patient, open first.
  _ida.Future<List<_ile5b8en.Question>> list({int? patientId}) =>
      caller.callServerEndpoint<List<_ile5b8en.Question>>(
        'questions',
        'list',
        {'patientId': patientId},
      );

  /// Adds a free-text question (patient or caregiver).
  _ida.Future<_ile5b8en.Question> add(
    String text, {
    int? patientId,
  }) => caller.callServerEndpoint<_ile5b8en.Question>(
    'questions',
    'add',
    {
      'text': text,
      'patientId': patientId,
    },
  );

  /// A clinician answers a question; it then shows up in the app.
  _ida.Future<_ile5b8en.Question> answer(
    int questionId,
    String text,
  ) => caller.callServerEndpoint<_ile5b8en.Question>(
    'questions',
    'answer',
    {
      'questionId': questionId,
      'text': text,
    },
  );
}

/// RxNav proxy (A10 `rx`): cached, throttled, no PHI sent upstream.
/// {@category Endpoint}
class EndpointRx extends _isc.EndpointRef {
  EndpointRx(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'rx';

  /// RxCUIs for an NDC (barcode or printed).
  _ida.Future<List<_iba2asag.RxHit>> byNdc(String ndc) =>
      caller.callServerEndpoint<List<_iba2asag.RxHit>>(
        'rx',
        'byNdc',
        {'ndc': ndc},
      );

  /// Approximate drug-name match.
  _ida.Future<List<_iba2asag.RxHit>> approximate(String term) =>
      caller.callServerEndpoint<List<_iba2asag.RxHit>>(
        'rx',
        'approximate',
        {'term': term},
      );

  /// ATC level-4 classes for an RxCUI.
  _ida.Future<List<String>> classesFor(String rxcui) =>
      caller.callServerEndpoint<List<String>>(
        'rx',
        'classesFor',
        {'rxcui': rxcui},
      );
}

/// Bottle scans (A10 `scan`, F3/F4).
/// {@category Endpoint}
class EndpointScan extends _isc.EndpointRef {
  EndpointScan(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'scan';

  /// Submits a confirmed scan. The server re-runs reconcile with the shipped
  /// rules and returns the authoritative result.
  _ida.Future<_izowlg7b.ReconOutcome> submit(_igf13yeg.ScanInput input) =>
      caller.callServerEndpoint<_izowlg7b.ReconOutcome>(
        'scan',
        'submit',
        {'input': input},
      );

  /// Scan history, newest first.
  _ida.Future<List<_irf1034y.ScanHistoryEntry>> history({int? patientId}) =>
      caller.callServerEndpoint<List<_irf1034y.ScanHistoryEntry>>(
        'scan',
        'history',
        {'patientId': patientId},
      );

  /// Records "I've set this bottle aside" for a Stop / Duplicate result.
  _ida.Future<_i5t4wkob.BottleScan> setAside(int scanId) =>
      caller.callServerEndpoint<_i5t4wkob.BottleScan>(
        'scan',
        'setAside',
        {'scanId': scanId},
      );
}

/// Daily schedule and adherence log (A10 `schedule`, F5).
/// {@category Endpoint}
class EndpointSchedule extends _isc.EndpointRef {
  EndpointSchedule(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'schedule';

  /// Schedules for the newest plan, each with its last 48 h of dose events.
  _ida.Future<List<_iy3ix7sn.ScheduleView>> get({int? patientId}) =>
      caller.callServerEndpoint<List<_iy3ix7sn.ScheduleView>>(
        'schedule',
        'get',
        {'patientId': patientId},
      );

  /// Logs Taken / Skip for one due dose (upsert by schedule + due time).
  _ida.Future<_itrc8y2p.DoseEvent> logDose(
    int scheduleId,
    DateTime dueAt,
    _i97051ze.DoseState state,
  ) => caller.callServerEndpoint<_itrc8y2p.DoseEvent>(
    'schedule',
    'logDose',
    {
      'scheduleId': scheduleId,
      'dueAt': dueAt,
      'state': state,
    },
  );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    alerts = EndpointAlerts(this);
    care = EndpointCare(this);
    dashboard = EndpointDashboard(this);
    patient = EndpointPatient(this);
    plan = EndpointPlan(this);
    questions = EndpointQuestions(this);
    rx = EndpointRx(this);
    scan = EndpointScan(this);
    schedule = EndpointSchedule(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAlerts alerts;

  late final EndpointCare care;

  late final EndpointDashboard dashboard;

  late final EndpointPatient patient;

  late final EndpointPlan plan;

  late final EndpointQuestions questions;

  late final EndpointRx rx;

  late final EndpointScan scan;

  late final EndpointSchedule schedule;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'alerts': alerts,
    'care': care,
    'dashboard': dashboard,
    'patient': patient,
    'plan': plan,
    'questions': questions,
    'rx': rx,
    'scan': scan,
    'schedule': schedule,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
