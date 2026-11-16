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
import 'package:medbridge_server/src/generated/care_role.dart' as _ijlk64lj;
import 'package:medbridge_server/src/generated/dose_state.dart' as _i4qgt89u;
import 'package:medbridge_server/src/generated/dto/plan_draft_input.dart'
    as _izhviopi;
import 'package:medbridge_server/src/generated/dto/plan_item_input.dart'
    as _isa8qs69;
import 'package:medbridge_server/src/generated/dto/scan_input.dart'
    as _iq6qcl89;
import 'package:medbridge_server/src/generated/future_calls.dart' as _ic6u0sw1;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../auth/email_idp_endpoint.dart' as _iuc1hd5t;
import '../auth/jwt_refresh_endpoint.dart' as _inwq3ztq;
import '../endpoints/alerts_endpoint.dart' as _iqvu6j2x;
import '../endpoints/care_endpoint.dart' as _iuxmpckp;
import '../endpoints/dashboard_endpoint.dart' as _ibmx856o;
import '../endpoints/patient_endpoint.dart' as _iq9ib001;
import '../endpoints/plan_endpoint.dart' as _ix8ykye2;
import '../endpoints/questions_endpoint.dart' as _ixz1m1z5;
import '../endpoints/rx_endpoint.dart' as _ikkk29n6;
import '../endpoints/scan_endpoint.dart' as _i5jlder5;
import '../endpoints/schedule_endpoint.dart' as _iywcnzta;
export 'future_calls.dart' show ServerpodFutureCallsGetter;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    initializeOwnEndpoints(server);
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeOwnEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeOwnEndpoints(server);
  }

  @override
  void initializeOwnEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'emailIdp': _iuc1hd5t.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _inwq3ztq.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'alerts': _iqvu6j2x.AlertsEndpoint()
        ..initialize(
          server,
          'alerts',
          null,
        ),
      'care': _iuxmpckp.CareEndpoint()
        ..initialize(
          server,
          'care',
          null,
        ),
      'dashboard': _ibmx856o.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'patient': _iq9ib001.PatientEndpoint()
        ..initialize(
          server,
          'patient',
          null,
        ),
      'plan': _ix8ykye2.PlanEndpoint()
        ..initialize(
          server,
          'plan',
          null,
        ),
      'questions': _ixz1m1z5.QuestionsEndpoint()
        ..initialize(
          server,
          'questions',
          null,
        ),
      'rx': _ikkk29n6.RxEndpoint()
        ..initialize(
          server,
          'rx',
          null,
        ),
      'scan': _i5jlder5.ScanEndpoint()
        ..initialize(
          server,
          'scan',
          null,
        ),
      'schedule': _iywcnzta.ScheduleEndpoint()
        ..initialize(
          server,
          'schedule',
          null,
        ),
    };
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'startOtpLogin': _is.MethodConnector(
          name: 'startOtpLogin',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startOtpLogin(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyOtpLoginCode': _is.MethodConnector(
          name: 'verifyOtpLoginCode',
          params: {
            'otpLoginRequestId': _is.ParameterDescription(
              name: 'otpLoginRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyOtpLoginCode(
                    session,
                    otpLoginRequestId: params['otpLoginRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishOtpLogin': _is.MethodConnector(
          name: 'finishOtpLogin',
          params: {
            'otpLoginToken': _is.ParameterDescription(
              name: 'otpLoginToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishOtpLogin(
                    session,
                    otpLoginToken: params['otpLoginToken'],
                  ),
        ),
        'finishOtpRegistration': _is.MethodConnector(
          name: 'finishOtpRegistration',
          params: {
            'otpLoginToken': _is.ParameterDescription(
              name: 'otpLoginToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishOtpRegistration(
                    session,
                    otpLoginToken: params['otpLoginToken'],
                    password: params['password'],
                  ),
        ),
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _iuc1hd5t.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _inwq3ztq.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['alerts'] = _is.EndpointConnector(
      name: 'alerts',
      endpoint: endpoints['alerts']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['alerts'] as _iqvu6j2x.AlertsEndpoint).list(
                session,
                patientId: params['patientId'],
              ),
        ),
        'ack': _is.MethodConnector(
          name: 'ack',
          params: {
            'alertId': _is.ParameterDescription(
              name: 'alertId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['alerts'] as _iqvu6j2x.AlertsEndpoint).ack(
                session,
                params['alertId'],
              ),
        ),
      },
    );
    connectors['care'] = _is.EndpointConnector(
      name: 'care',
      endpoint: endpoints['care']!,
      methodConnectors: {
        'createInvite': _is.MethodConnector(
          name: 'createInvite',
          params: {
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<_ijlk64lj.CareRole>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['care'] as _iuxmpckp.CareEndpoint).createInvite(
                    session,
                    params['role'],
                  ),
        ),
        'acceptInvite': _is.MethodConnector(
          name: 'acceptInvite',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['care'] as _iuxmpckp.CareEndpoint).acceptInvite(
                    session,
                    params['code'],
                  ),
        ),
        'revoke': _is.MethodConnector(
          name: 'revoke',
          params: {
            'linkId': _is.ParameterDescription(
              name: 'linkId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['care'] as _iuxmpckp.CareEndpoint).revoke(
                session,
                params['linkId'],
              ),
        ),
        'links': _is.MethodConnector(
          name: 'links',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['care'] as _iuxmpckp.CareEndpoint).links(session),
        ),
      },
    );
    connectors['dashboard'] = _is.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'patients': _is.MethodConnector(
          name: 'patients',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _ibmx856o.DashboardEndpoint)
                  .patients(session),
        ),
        'flagged': _is.MethodConnector(
          name: 'flagged',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _ibmx856o.DashboardEndpoint)
                  .flagged(session),
        ),
        'summary': _is.MethodConnector(
          name: 'summary',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _ibmx856o.DashboardEndpoint)
                  .summary(
                    session,
                    params['patientId'],
                  ),
        ),
        'resolveFlag': _is.MethodConnector(
          name: 'resolveFlag',
          params: {
            'reconId': _is.ParameterDescription(
              name: 'reconId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'note': _is.ParameterDescription(
              name: 'note',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['dashboard'] as _ibmx856o.DashboardEndpoint)
                  .resolveFlag(
                    session,
                    params['reconId'],
                    params['note'],
                  ),
        ),
      },
    );
    connectors['patient'] = _is.EndpointConnector(
      name: 'patient',
      endpoint: endpoints['patient']!,
      methodConnectors: {
        'me': _is.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['patient'] as _iq9ib001.PatientEndpoint).me(
                session,
              ),
        ),
        'register': _is.MethodConnector(
          name: 'register',
          params: {
            'role': _is.ParameterDescription(
              name: 'role',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'firstName': _is.ParameterDescription(
              name: 'firstName',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'lang': _is.ParameterDescription(
              name: 'lang',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'utcOffsetMin': _is.ParameterDescription(
              name: 'utcOffsetMin',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['patient'] as _iq9ib001.PatientEndpoint).register(
                    session,
                    params['role'],
                    params['firstName'],
                    params['lang'],
                    params['utcOffsetMin'],
                  ),
        ),
        'updatePrefs': _is.MethodConnector(
          name: 'updatePrefs',
          params: {
            'lang': _is.ParameterDescription(
              name: 'lang',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'utcOffsetMin': _is.ParameterDescription(
              name: 'utcOffsetMin',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'firstName': _is.ParameterDescription(
              name: 'firstName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['patient'] as _iq9ib001.PatientEndpoint)
                  .updatePrefs(
                    session,
                    params['lang'],
                    params['utcOffsetMin'],
                    firstName: params['firstName'],
                  ),
        ),
        'setAllergies': _is.MethodConnector(
          name: 'setAllergies',
          params: {
            'allergies': _is.ParameterDescription(
              name: 'allergies',
              type: _is.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['patient'] as _iq9ib001.PatientEndpoint)
                  .setAllergies(
                    session,
                    params['allergies'],
                  ),
        ),
      },
    );
    connectors['plan'] = _is.EndpointConnector(
      name: 'plan',
      endpoint: endpoints['plan']!,
      methodConnectors: {
        'uploadDraft': _is.MethodConnector(
          name: 'uploadDraft',
          params: {
            'draft': _is.ParameterDescription(
              name: 'draft',
              type: _is.getType<_izhviopi.PlanDraftInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['plan'] as _ix8ykye2.PlanEndpoint).uploadDraft(
                    session,
                    params['draft'],
                  ),
        ),
        'confirm': _is.MethodConnector(
          name: 'confirm',
          params: {
            'planId': _is.ParameterDescription(
              name: 'planId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['plan'] as _ix8ykye2.PlanEndpoint).confirm(
                session,
                params['planId'],
              ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['plan'] as _ix8ykye2.PlanEndpoint).get(
                session,
                patientId: params['patientId'],
              ),
        ),
        'verify': _is.MethodConnector(
          name: 'verify',
          params: {
            'planId': _is.ParameterDescription(
              name: 'planId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['plan'] as _ix8ykye2.PlanEndpoint).verify(
                session,
                params['planId'],
              ),
        ),
        'editItem': _is.MethodConnector(
          name: 'editItem',
          params: {
            'itemId': _is.ParameterDescription(
              name: 'itemId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_isa8qs69.PlanItemInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['plan'] as _ix8ykye2.PlanEndpoint).editItem(
                session,
                params['itemId'],
                params['input'],
              ),
        ),
      },
    );
    connectors['questions'] = _is.EndpointConnector(
      name: 'questions',
      endpoint: endpoints['questions']!,
      methodConnectors: {
        'list': _is.MethodConnector(
          name: 'list',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questions'] as _ixz1m1z5.QuestionsEndpoint).list(
                    session,
                    patientId: params['patientId'],
                  ),
        ),
        'add': _is.MethodConnector(
          name: 'add',
          params: {
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questions'] as _ixz1m1z5.QuestionsEndpoint).add(
                    session,
                    params['text'],
                    patientId: params['patientId'],
                  ),
        ),
        'answer': _is.MethodConnector(
          name: 'answer',
          params: {
            'questionId': _is.ParameterDescription(
              name: 'questionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'text': _is.ParameterDescription(
              name: 'text',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['questions'] as _ixz1m1z5.QuestionsEndpoint)
                  .answer(
                    session,
                    params['questionId'],
                    params['text'],
                  ),
        ),
      },
    );
    connectors['rx'] = _is.EndpointConnector(
      name: 'rx',
      endpoint: endpoints['rx']!,
      methodConnectors: {
        'byNdc': _is.MethodConnector(
          name: 'byNdc',
          params: {
            'ndc': _is.ParameterDescription(
              name: 'ndc',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rx'] as _ikkk29n6.RxEndpoint).byNdc(
                session,
                params['ndc'],
              ),
        ),
        'approximate': _is.MethodConnector(
          name: 'approximate',
          params: {
            'term': _is.ParameterDescription(
              name: 'term',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rx'] as _ikkk29n6.RxEndpoint).approximate(
                session,
                params['term'],
              ),
        ),
        'classesFor': _is.MethodConnector(
          name: 'classesFor',
          params: {
            'rxcui': _is.ParameterDescription(
              name: 'rxcui',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['rx'] as _ikkk29n6.RxEndpoint).classesFor(
                session,
                params['rxcui'],
              ),
        ),
      },
    );
    connectors['scan'] = _is.EndpointConnector(
      name: 'scan',
      endpoint: endpoints['scan']!,
      methodConnectors: {
        'submit': _is.MethodConnector(
          name: 'submit',
          params: {
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_iq6qcl89.ScanInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['scan'] as _i5jlder5.ScanEndpoint).submit(
                session,
                params['input'],
              ),
        ),
        'history': _is.MethodConnector(
          name: 'history',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['scan'] as _i5jlder5.ScanEndpoint).history(
                session,
                patientId: params['patientId'],
              ),
        ),
        'setAside': _is.MethodConnector(
          name: 'setAside',
          params: {
            'scanId': _is.ParameterDescription(
              name: 'scanId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['scan'] as _i5jlder5.ScanEndpoint).setAside(
                session,
                params['scanId'],
              ),
        ),
      },
    );
    connectors['schedule'] = _is.EndpointConnector(
      name: 'schedule',
      endpoint: endpoints['schedule']!,
      methodConnectors: {
        'get': _is.MethodConnector(
          name: 'get',
          params: {
            'patientId': _is.ParameterDescription(
              name: 'patientId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['schedule'] as _iywcnzta.ScheduleEndpoint).get(
                    session,
                    patientId: params['patientId'],
                  ),
        ),
        'logDose': _is.MethodConnector(
          name: 'logDose',
          params: {
            'scheduleId': _is.ParameterDescription(
              name: 'scheduleId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'dueAt': _is.ParameterDescription(
              name: 'dueAt',
              type: _is.getType<DateTime>(),
              nullable: false,
            ),
            'state': _is.ParameterDescription(
              name: 'state',
              type: _is.getType<_i4qgt89u.DoseState>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['schedule'] as _iywcnzta.ScheduleEndpoint).logDose(
                    session,
                    params['scheduleId'],
                    params['dueAt'],
                    params['state'],
                  ),
        ),
      },
    );
  }

  @override
  _is.FutureCallDispatch? get futureCalls {
    return _ic6u0sw1.FutureCalls();
  }
}
