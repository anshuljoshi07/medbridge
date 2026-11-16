/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:medbridge_server/src/generated/alert.dart' as _ibr7zz4s;
import 'package:medbridge_server/src/generated/care_link.dart' as _inn18lhr;
import 'package:medbridge_server/src/generated/dto/flagged_scan.dart'
    as _idqaewx9;
import 'package:medbridge_server/src/generated/dto/patient_summary.dart'
    as _il2iv5s5;
import 'package:medbridge_server/src/generated/dto/rx_hit.dart' as _iqpgzd1p;
import 'package:medbridge_server/src/generated/dto/scan_history_entry.dart'
    as _i9qt9sig;
import 'package:medbridge_server/src/generated/dto/schedule_view.dart'
    as _i6w934wy;
import 'package:medbridge_server/src/generated/question.dart' as _iivzcrlo;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'alert.dart' as _iqmz6gj4;
import 'audit_log.dart' as _itixckla;
import 'bottle_scan.dart' as _ifld0q78;
import 'care_link.dart' as _ilhcsb3l;
import 'care_role.dart' as _ipgwqulm;
import 'discharge_plan.dart' as _iun0pa6x;
import 'dose_event.dart' as _i6sqb1u1;
import 'dose_schedule.dart' as _iqv8gzde;
import 'dose_state.dart' as _ivb9e1ub;
import 'dto/access_denied_exception.dart' as _i62njew3;
import 'dto/flagged_scan.dart' as _ix0j9q1o;
import 'dto/me_view.dart' as _iu86wh6v;
import 'dto/patient_summary.dart' as _iwqcihyo;
import 'dto/pcp_summary.dart' as _iy7eu2en;
import 'dto/plan_draft_input.dart' as _i09ss2f2;
import 'dto/plan_item_input.dart' as _ikd8eydh;
import 'dto/plan_view.dart' as _iytyh6s9;
import 'dto/recon_outcome.dart' as _irkzenra;
import 'dto/rx_hit.dart' as _i25f6c9t;
import 'dto/safety_flag_dto.dart' as _ity9sy6e;
import 'dto/scan_history_entry.dart' as _ibi54gyh;
import 'dto/scan_input.dart' as _i84iv1s5;
import 'dto/schedule_view.dart' as _itg4xv15;
import 'link_status.dart' as _i1hij6nc;
import 'patient.dart' as _ius4lr2t;
import 'plan_item_row.dart' as _iwji8ji8;
import 'plan_status.dart' as _iqzysob1;
import 'question.dart' as _in6mynjk;
import 'question_status.dart' as _ixi4rbc4;
import 'recon_row.dart' as _i4zxqgb9;
import 'rx_cache.dart' as _iah46kd8;
export 'alert.dart';
export 'audit_log.dart';
export 'bottle_scan.dart';
export 'care_link.dart';
export 'care_role.dart';
export 'discharge_plan.dart';
export 'dose_event.dart';
export 'dose_schedule.dart';
export 'dose_state.dart';
export 'dto/access_denied_exception.dart';
export 'dto/flagged_scan.dart';
export 'dto/me_view.dart';
export 'dto/patient_summary.dart';
export 'dto/pcp_summary.dart';
export 'dto/plan_draft_input.dart';
export 'dto/plan_item_input.dart';
export 'dto/plan_view.dart';
export 'dto/recon_outcome.dart';
export 'dto/rx_hit.dart';
export 'dto/safety_flag_dto.dart';
export 'dto/scan_history_entry.dart';
export 'dto/scan_input.dart';
export 'dto/schedule_view.dart';
export 'link_status.dart';
export 'patient.dart';
export 'plan_item_row.dart';
export 'plan_status.dart';
export 'question.dart';
export 'question_status.dart';
export 'recon_row.dart';
export 'rx_cache.dart';

class Protocol extends _is.DatabaseSerializationManager
    implements _is.DatabaseProtocolDeserializationProvider {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  @override
  _is.ProtocolDeserialization get deserializationMetadata =>
      _is.ProtocolDeserialization.cached(
        this,
        types: const [
          _is.getType<_iqmz6gj4.Alert>,
          _is.getType<_itixckla.AuditLog>,
          _is.getType<_ifld0q78.BottleScan>,
          _is.getType<_ilhcsb3l.CareLink>,
          _is.getType<_ipgwqulm.CareRole>,
          _is.getType<_iun0pa6x.DischargePlan>,
          _is.getType<_i6sqb1u1.DoseEvent>,
          _is.getType<_iqv8gzde.DoseSchedule>,
          _is.getType<_ivb9e1ub.DoseState>,
          _is.getType<_i62njew3.AccessDeniedException>,
          _is.getType<_ix0j9q1o.FlaggedScan>,
          _is.getType<_iu86wh6v.MeView>,
          _is.getType<_iwqcihyo.PatientSummary>,
          _is.getType<_iy7eu2en.PcpSummary>,
          _is.getType<_i09ss2f2.PlanDraftInput>,
          _is.getType<_ikd8eydh.PlanItemInput>,
          _is.getType<_iytyh6s9.PlanView>,
          _is.getType<_irkzenra.ReconOutcome>,
          _is.getType<_i25f6c9t.RxHit>,
          _is.getType<_ity9sy6e.SafetyFlagDto>,
          _is.getType<_ibi54gyh.ScanHistoryEntry>,
          _is.getType<_i84iv1s5.ScanInput>,
          _is.getType<_itg4xv15.ScheduleView>,
          _is.getType<_i1hij6nc.LinkStatus>,
          _is.getType<_ius4lr2t.Patient>,
          _is.getType<_iwji8ji8.PlanItemRow>,
          _is.getType<_iqzysob1.PlanStatus>,
          _is.getType<_in6mynjk.Question>,
          _is.getType<_ixi4rbc4.QuestionStatus>,
          _is.getType<_i4zxqgb9.ReconRow>,
          _is.getType<_iah46kd8.RxCache>,
          _is.getType<_iqmz6gj4.Alert?>,
          _is.getType<_itixckla.AuditLog?>,
          _is.getType<_ifld0q78.BottleScan?>,
          _is.getType<_ilhcsb3l.CareLink?>,
          _is.getType<_ipgwqulm.CareRole?>,
          _is.getType<_iun0pa6x.DischargePlan?>,
          _is.getType<_i6sqb1u1.DoseEvent?>,
          _is.getType<_iqv8gzde.DoseSchedule?>,
          _is.getType<_ivb9e1ub.DoseState?>,
          _is.getType<_i62njew3.AccessDeniedException?>,
          _is.getType<_ix0j9q1o.FlaggedScan?>,
          _is.getType<_iu86wh6v.MeView?>,
          _is.getType<_iwqcihyo.PatientSummary?>,
          _is.getType<_iy7eu2en.PcpSummary?>,
          _is.getType<_i09ss2f2.PlanDraftInput?>,
          _is.getType<_ikd8eydh.PlanItemInput?>,
          _is.getType<_iytyh6s9.PlanView?>,
          _is.getType<_irkzenra.ReconOutcome?>,
          _is.getType<_i25f6c9t.RxHit?>,
          _is.getType<_ity9sy6e.SafetyFlagDto?>,
          _is.getType<_ibi54gyh.ScanHistoryEntry?>,
          _is.getType<_i84iv1s5.ScanInput?>,
          _is.getType<_itg4xv15.ScheduleView?>,
          _is.getType<_i1hij6nc.LinkStatus?>,
          _is.getType<_ius4lr2t.Patient?>,
          _is.getType<_iwji8ji8.PlanItemRow?>,
          _is.getType<_iqzysob1.PlanStatus?>,
          _is.getType<_in6mynjk.Question?>,
          _is.getType<_ixi4rbc4.QuestionStatus?>,
          _is.getType<_i4zxqgb9.ReconRow?>,
          _is.getType<_iah46kd8.RxCache?>,
          _is.getType<List<String>>,
          _is.getType<List<_ius4lr2t.Patient>>,
          _is.getType<List<_ibi54gyh.ScanHistoryEntry>>,
          _is.getType<List<_in6mynjk.Question>>,
          _is.getType<List<_ikd8eydh.PlanItemInput>>,
          _is.getType<List<_iwji8ji8.PlanItemRow>>,
          _is.getType<List<_ity9sy6e.SafetyFlagDto>>,
          _is.getType<Map<String, String>>,
          _is.getType<List<_i6sqb1u1.DoseEvent>>,
          _is.getType<List<_ibr7zz4s.Alert>>,
          _is.getType<List<_inn18lhr.CareLink>>,
          _is.getType<List<_il2iv5s5.PatientSummary>>,
          _is.getType<List<_idqaewx9.FlaggedScan>>,
          _is.getType<List<String>>,
          _is.getType<List<_iivzcrlo.Question>>,
          _is.getType<List<_iqpgzd1p.RxHit>>,
          _is.getType<List<_i9qt9sig.ScanHistoryEntry>>,
          _is.getType<List<_i6w934wy.ScheduleView>>,
        ],
        modules: const [
          _iais.Protocol.new,
          _iacs.Protocol.new,
          _isp.Protocol.new,
        ],
        classNames: const [
          'Alert',
          'AuditLog',
          'BottleScan',
          'CareLink',
          'CareRole',
          'DischargePlan',
          'DoseEvent',
          'DoseSchedule',
          'DoseState',
          'AccessDeniedException',
          'FlaggedScan',
          'MeView',
          'PatientSummary',
          'PcpSummary',
          'PlanDraftInput',
          'PlanItemInput',
          'PlanView',
          'ReconOutcome',
          'RxHit',
          'SafetyFlagDto',
          'ScanHistoryEntry',
          'ScanInput',
          'ScheduleView',
          'LinkStatus',
          'Patient',
          'PlanItemRow',
          'PlanStatus',
          'Question',
          'QuestionStatus',
          'ReconRow',
          'RxCache',
        ],
      );

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    ..._ownTableDefinitions,
    ..._iais.Protocol().getOwnTableDefinitions(),
    ..._iacs.Protocol().getOwnTableDefinitions(),
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static List<_isp.TableDefinition> get _ownTableDefinitions => [
    _isp.TableDefinition(
      name: 'alert',
      dartName: 'Alert',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'patientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'type',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sev',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'dedupeKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'recipientsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sentAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'ackAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'alert_fk_0',
          columns: ['patientId'],
          referenceTable: 'patient',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'alert_dedupe_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'dedupeKey',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'audit_log',
      dartName: 'AuditLog',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'actorUserId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'action',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'entity',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'entityId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'at',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'audit_entity_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'entity',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'entityId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'bottle_scan',
      dartName: 'BottleScan',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'patientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'ndc11',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'rxcui',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'ingsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'strength',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'form',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sigRaw',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sigJson',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'ocrText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'conf',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'confirmed',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'classIdsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'',
        ),
        _isp.ColumnDefinition(
          name: 'setAside',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'scannedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'bottle_scan_fk_0',
          columns: ['patientId'],
          referenceTable: 'patient',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'bottle_scan_patient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'patientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'care_link',
      dartName: 'CareLink',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'patientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CareRole',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:LinkStatus',
          columnDefault: '\'pending\'',
        ),
        _isp.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'care_link_fk_0',
          columns: ['patientId'],
          referenceTable: 'patient',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'care_link_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'care_link_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'discharge_plan',
      dartName: 'DischargePlan',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'patientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'avs_scan\'',
        ),
        _isp.ColumnDefinition(
          name: 'dischargeDate',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PlanStatus',
          columnDefault: '\'draft\'',
        ),
        _isp.ColumnDefinition(
          name: 'allergiesJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'',
        ),
        _isp.ColumnDefinition(
          name: 'unrecognizedJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'',
        ),
        _isp.ColumnDefinition(
          name: 'verifiedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'verifiedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'discharge_plan_fk_0',
          columns: ['patientId'],
          referenceTable: 'patient',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'discharge_plan_patient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'patientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dose_event',
      dartName: 'DoseEvent',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'scheduleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'dueAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'state',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:DoseState',
        ),
        _isp.ColumnDefinition(
          name: 'loggedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'dose_event_fk_0',
          columns: ['scheduleId'],
          referenceTable: 'dose_schedule',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dose_event_schedule_due_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'scheduleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'dueAt',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'dose_schedule',
      dartName: 'DoseSchedule',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'planItemId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'slotsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'prn',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _isp.ColumnDefinition(
          name: 'active',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'true',
        ),
        _isp.ColumnDefinition(
          name: 'suspendedUntil',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'dose_schedule_fk_0',
          columns: ['planItemId'],
          referenceTable: 'plan_item',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'dose_schedule_item_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'planItemId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'patient',
      dartName: 'Patient',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'userId',
          columnType: _isp.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _isp.ColumnDefinition(
          name: 'firstName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'Patient\'',
        ),
        _isp.ColumnDefinition(
          name: 'lang',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'en\'',
        ),
        _isp.ColumnDefinition(
          name: 'birthYear',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'utcOffsetMin',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'allergiesJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'patient_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'plan_item',
      dartName: 'PlanItemRow',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'planId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'itemKey',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'action',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'name',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'rxcui',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'ingsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'scd',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'strength',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'form',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'route',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'sigRaw',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sigJson',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'holdUntil',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'holdNote',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'src',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'conf',
          columnType: _isp.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _isp.ColumnDefinition(
          name: 'classIdsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'plan_item_fk_0',
          columns: ['planId'],
          referenceTable: 'discharge_plan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'plan_item_plan_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'planId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'question',
      dartName: 'Question',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'patientId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'source',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'linkedReconId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'askedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:QuestionStatus',
          columnDefault: '\'open\'',
        ),
        _isp.ColumnDefinition(
          name: 'answer',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'answeredBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'answeredAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'question_fk_0',
          columns: ['patientId'],
          referenceTable: 'patient',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'question_patient_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'patientId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'recon',
      dartName: 'ReconRow',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'scanId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'planItemId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'itemKey',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'reason',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'sev',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'flagsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'[]\'',
        ),
        _isp.ColumnDefinition(
          name: 'paramsJson',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'{}\'',
        ),
        _isp.ColumnDefinition(
          name: 'ruleVersion',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedNote',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedBy',
          columnType: _isp.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'recon_fk_0',
          columns: ['scanId'],
          referenceTable: 'bottle_scan',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'recon_scan_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'scanId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'rx_cache',
      dartName: 'RxCache',
      schema: 'public',
      module: 'medbridge',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'key',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'json',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'fetchedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'rx_cache_key_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
  ];

  static String? getClassNameFromObjectJson(dynamic data) =>
      _is.ProtocolDeserialization.readClassName(data);

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    final rawDataClassName = _is.ProtocolDeserialization.readClassName(data);
    final dataClassName = rawDataClassName;
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _iqmz6gj4.Alert) {
      return _iqmz6gj4.Alert.fromJson(data) as T;
    }
    if (t == _itixckla.AuditLog) {
      return _itixckla.AuditLog.fromJson(data) as T;
    }
    if (t == _ifld0q78.BottleScan) {
      return _ifld0q78.BottleScan.fromJson(data) as T;
    }
    if (t == _ilhcsb3l.CareLink) {
      return _ilhcsb3l.CareLink.fromJson(data) as T;
    }
    if (t == _ipgwqulm.CareRole) {
      return _ipgwqulm.CareRole.fromJson(data) as T;
    }
    if (t == _iun0pa6x.DischargePlan) {
      return _iun0pa6x.DischargePlan.fromJson(data) as T;
    }
    if (t == _i6sqb1u1.DoseEvent) {
      return _i6sqb1u1.DoseEvent.fromJson(data) as T;
    }
    if (t == _iqv8gzde.DoseSchedule) {
      return _iqv8gzde.DoseSchedule.fromJson(data) as T;
    }
    if (t == _ivb9e1ub.DoseState) {
      return _ivb9e1ub.DoseState.fromJson(data) as T;
    }
    if (t == _i62njew3.AccessDeniedException) {
      return _i62njew3.AccessDeniedException.fromJson(data) as T;
    }
    if (t == _ix0j9q1o.FlaggedScan) {
      return _ix0j9q1o.FlaggedScan.fromJson(data) as T;
    }
    if (t == _iu86wh6v.MeView) {
      return _iu86wh6v.MeView.fromJson(data) as T;
    }
    if (t == _iwqcihyo.PatientSummary) {
      return _iwqcihyo.PatientSummary.fromJson(data) as T;
    }
    if (t == _iy7eu2en.PcpSummary) {
      return _iy7eu2en.PcpSummary.fromJson(data) as T;
    }
    if (t == _i09ss2f2.PlanDraftInput) {
      return _i09ss2f2.PlanDraftInput.fromJson(data) as T;
    }
    if (t == _ikd8eydh.PlanItemInput) {
      return _ikd8eydh.PlanItemInput.fromJson(data) as T;
    }
    if (t == _iytyh6s9.PlanView) {
      return _iytyh6s9.PlanView.fromJson(data) as T;
    }
    if (t == _irkzenra.ReconOutcome) {
      return _irkzenra.ReconOutcome.fromJson(data) as T;
    }
    if (t == _i25f6c9t.RxHit) {
      return _i25f6c9t.RxHit.fromJson(data) as T;
    }
    if (t == _ity9sy6e.SafetyFlagDto) {
      return _ity9sy6e.SafetyFlagDto.fromJson(data) as T;
    }
    if (t == _ibi54gyh.ScanHistoryEntry) {
      return _ibi54gyh.ScanHistoryEntry.fromJson(data) as T;
    }
    if (t == _i84iv1s5.ScanInput) {
      return _i84iv1s5.ScanInput.fromJson(data) as T;
    }
    if (t == _itg4xv15.ScheduleView) {
      return _itg4xv15.ScheduleView.fromJson(data) as T;
    }
    if (t == _i1hij6nc.LinkStatus) {
      return _i1hij6nc.LinkStatus.fromJson(data) as T;
    }
    if (t == _ius4lr2t.Patient) {
      return _ius4lr2t.Patient.fromJson(data) as T;
    }
    if (t == _iwji8ji8.PlanItemRow) {
      return _iwji8ji8.PlanItemRow.fromJson(data) as T;
    }
    if (t == _iqzysob1.PlanStatus) {
      return _iqzysob1.PlanStatus.fromJson(data) as T;
    }
    if (t == _in6mynjk.Question) {
      return _in6mynjk.Question.fromJson(data) as T;
    }
    if (t == _ixi4rbc4.QuestionStatus) {
      return _ixi4rbc4.QuestionStatus.fromJson(data) as T;
    }
    if (t == _i4zxqgb9.ReconRow) {
      return _i4zxqgb9.ReconRow.fromJson(data) as T;
    }
    if (t == _iah46kd8.RxCache) {
      return _iah46kd8.RxCache.fromJson(data) as T;
    }
    if (t == _is.getType<_iqmz6gj4.Alert?>()) {
      return (data != null ? _iqmz6gj4.Alert.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itixckla.AuditLog?>()) {
      return (data != null ? _itixckla.AuditLog.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifld0q78.BottleScan?>()) {
      return (data != null ? _ifld0q78.BottleScan.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ilhcsb3l.CareLink?>()) {
      return (data != null ? _ilhcsb3l.CareLink.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ipgwqulm.CareRole?>()) {
      return (data != null ? _ipgwqulm.CareRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iun0pa6x.DischargePlan?>()) {
      return (data != null ? _iun0pa6x.DischargePlan.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6sqb1u1.DoseEvent?>()) {
      return (data != null ? _i6sqb1u1.DoseEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqv8gzde.DoseSchedule?>()) {
      return (data != null ? _iqv8gzde.DoseSchedule.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ivb9e1ub.DoseState?>()) {
      return (data != null ? _ivb9e1ub.DoseState.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i62njew3.AccessDeniedException?>()) {
      return (data != null
              ? _i62njew3.AccessDeniedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_ix0j9q1o.FlaggedScan?>()) {
      return (data != null ? _ix0j9q1o.FlaggedScan.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iu86wh6v.MeView?>()) {
      return (data != null ? _iu86wh6v.MeView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwqcihyo.PatientSummary?>()) {
      return (data != null ? _iwqcihyo.PatientSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iy7eu2en.PcpSummary?>()) {
      return (data != null ? _iy7eu2en.PcpSummary.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i09ss2f2.PlanDraftInput?>()) {
      return (data != null ? _i09ss2f2.PlanDraftInput.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ikd8eydh.PlanItemInput?>()) {
      return (data != null ? _ikd8eydh.PlanItemInput.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iytyh6s9.PlanView?>()) {
      return (data != null ? _iytyh6s9.PlanView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_irkzenra.ReconOutcome?>()) {
      return (data != null ? _irkzenra.ReconOutcome.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i25f6c9t.RxHit?>()) {
      return (data != null ? _i25f6c9t.RxHit.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ity9sy6e.SafetyFlagDto?>()) {
      return (data != null ? _ity9sy6e.SafetyFlagDto.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ibi54gyh.ScanHistoryEntry?>()) {
      return (data != null ? _ibi54gyh.ScanHistoryEntry.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i84iv1s5.ScanInput?>()) {
      return (data != null ? _i84iv1s5.ScanInput.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_itg4xv15.ScheduleView?>()) {
      return (data != null ? _itg4xv15.ScheduleView.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i1hij6nc.LinkStatus?>()) {
      return (data != null ? _i1hij6nc.LinkStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ius4lr2t.Patient?>()) {
      return (data != null ? _ius4lr2t.Patient.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iwji8ji8.PlanItemRow?>()) {
      return (data != null ? _iwji8ji8.PlanItemRow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iqzysob1.PlanStatus?>()) {
      return (data != null ? _iqzysob1.PlanStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_in6mynjk.Question?>()) {
      return (data != null ? _in6mynjk.Question.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixi4rbc4.QuestionStatus?>()) {
      return (data != null ? _ixi4rbc4.QuestionStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i4zxqgb9.ReconRow?>()) {
      return (data != null ? _i4zxqgb9.ReconRow.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iah46kd8.RxCache?>()) {
      return (data != null ? _iah46kd8.RxCache.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_ius4lr2t.Patient>) {
      return (data as List)
              .map((e) => deserialize<_ius4lr2t.Patient>(e))
              .toList()
          as T;
    }
    if (t == List<_ibi54gyh.ScanHistoryEntry>) {
      return (data as List)
              .map((e) => deserialize<_ibi54gyh.ScanHistoryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_in6mynjk.Question>) {
      return (data as List)
              .map((e) => deserialize<_in6mynjk.Question>(e))
              .toList()
          as T;
    }
    if (t == List<_ikd8eydh.PlanItemInput>) {
      return (data as List)
              .map((e) => deserialize<_ikd8eydh.PlanItemInput>(e))
              .toList()
          as T;
    }
    if (t == List<_iwji8ji8.PlanItemRow>) {
      return (data as List)
              .map((e) => deserialize<_iwji8ji8.PlanItemRow>(e))
              .toList()
          as T;
    }
    if (t == List<_ity9sy6e.SafetyFlagDto>) {
      return (data as List)
              .map((e) => deserialize<_ity9sy6e.SafetyFlagDto>(e))
              .toList()
          as T;
    }
    if (t == Map<String, String>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<String>(v)),
          )
          as T;
    }
    if (t == List<_i6sqb1u1.DoseEvent>) {
      return (data as List)
              .map((e) => deserialize<_i6sqb1u1.DoseEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ibr7zz4s.Alert>) {
      return (data as List).map((e) => deserialize<_ibr7zz4s.Alert>(e)).toList()
          as T;
    }
    if (t == List<_inn18lhr.CareLink>) {
      return (data as List)
              .map((e) => deserialize<_inn18lhr.CareLink>(e))
              .toList()
          as T;
    }
    if (t == List<_il2iv5s5.PatientSummary>) {
      return (data as List)
              .map((e) => deserialize<_il2iv5s5.PatientSummary>(e))
              .toList()
          as T;
    }
    if (t == List<_idqaewx9.FlaggedScan>) {
      return (data as List)
              .map((e) => deserialize<_idqaewx9.FlaggedScan>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_iivzcrlo.Question>) {
      return (data as List)
              .map((e) => deserialize<_iivzcrlo.Question>(e))
              .toList()
          as T;
    }
    if (t == List<_iqpgzd1p.RxHit>) {
      return (data as List).map((e) => deserialize<_iqpgzd1p.RxHit>(e)).toList()
          as T;
    }
    if (t == List<_i9qt9sig.ScanHistoryEntry>) {
      return (data as List)
              .map((e) => deserialize<_i9qt9sig.ScanHistoryEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i6w934wy.ScheduleView>) {
      return (data as List)
              .map((e) => deserialize<_i6w934wy.ScheduleView>(e))
              .toList()
          as T;
    }
    final modules = deserializationMetadata.modulesForDeserialization(
      t,
      className: rawDataClassName,
    );
    for (final module in modules) {
      try {
        return module.deserialize<T>(data, t);
      } on _is.DeserializationTypeNotFoundException catch (_) {}
    }

    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _iqmz6gj4.Alert => 'Alert',
      _itixckla.AuditLog => 'AuditLog',
      _ifld0q78.BottleScan => 'BottleScan',
      _ilhcsb3l.CareLink => 'CareLink',
      _ipgwqulm.CareRole => 'CareRole',
      _iun0pa6x.DischargePlan => 'DischargePlan',
      _i6sqb1u1.DoseEvent => 'DoseEvent',
      _iqv8gzde.DoseSchedule => 'DoseSchedule',
      _ivb9e1ub.DoseState => 'DoseState',
      _i62njew3.AccessDeniedException => 'AccessDeniedException',
      _ix0j9q1o.FlaggedScan => 'FlaggedScan',
      _iu86wh6v.MeView => 'MeView',
      _iwqcihyo.PatientSummary => 'PatientSummary',
      _iy7eu2en.PcpSummary => 'PcpSummary',
      _i09ss2f2.PlanDraftInput => 'PlanDraftInput',
      _ikd8eydh.PlanItemInput => 'PlanItemInput',
      _iytyh6s9.PlanView => 'PlanView',
      _irkzenra.ReconOutcome => 'ReconOutcome',
      _i25f6c9t.RxHit => 'RxHit',
      _ity9sy6e.SafetyFlagDto => 'SafetyFlagDto',
      _ibi54gyh.ScanHistoryEntry => 'ScanHistoryEntry',
      _i84iv1s5.ScanInput => 'ScanInput',
      _itg4xv15.ScheduleView => 'ScheduleView',
      _i1hij6nc.LinkStatus => 'LinkStatus',
      _ius4lr2t.Patient => 'Patient',
      _iwji8ji8.PlanItemRow => 'PlanItemRow',
      _iqzysob1.PlanStatus => 'PlanStatus',
      _in6mynjk.Question => 'Question',
      _ixi4rbc4.QuestionStatus => 'QuestionStatus',
      _i4zxqgb9.ReconRow => 'ReconRow',
      _iah46kd8.RxCache => 'RxCache',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('medbridge.', '');
    }

    switch (data) {
      case _iqmz6gj4.Alert():
        return 'Alert';
      case _itixckla.AuditLog():
        return 'AuditLog';
      case _ifld0q78.BottleScan():
        return 'BottleScan';
      case _ilhcsb3l.CareLink():
        return 'CareLink';
      case _ipgwqulm.CareRole():
        return 'CareRole';
      case _iun0pa6x.DischargePlan():
        return 'DischargePlan';
      case _i6sqb1u1.DoseEvent():
        return 'DoseEvent';
      case _iqv8gzde.DoseSchedule():
        return 'DoseSchedule';
      case _ivb9e1ub.DoseState():
        return 'DoseState';
      case _i62njew3.AccessDeniedException():
        return 'AccessDeniedException';
      case _ix0j9q1o.FlaggedScan():
        return 'FlaggedScan';
      case _iu86wh6v.MeView():
        return 'MeView';
      case _iwqcihyo.PatientSummary():
        return 'PatientSummary';
      case _iy7eu2en.PcpSummary():
        return 'PcpSummary';
      case _i09ss2f2.PlanDraftInput():
        return 'PlanDraftInput';
      case _ikd8eydh.PlanItemInput():
        return 'PlanItemInput';
      case _iytyh6s9.PlanView():
        return 'PlanView';
      case _irkzenra.ReconOutcome():
        return 'ReconOutcome';
      case _i25f6c9t.RxHit():
        return 'RxHit';
      case _ity9sy6e.SafetyFlagDto():
        return 'SafetyFlagDto';
      case _ibi54gyh.ScanHistoryEntry():
        return 'ScanHistoryEntry';
      case _i84iv1s5.ScanInput():
        return 'ScanInput';
      case _itg4xv15.ScheduleView():
        return 'ScheduleView';
      case _i1hij6nc.LinkStatus():
        return 'LinkStatus';
      case _ius4lr2t.Patient():
        return 'Patient';
      case _iwji8ji8.PlanItemRow():
        return 'PlanItemRow';
      case _iqzysob1.PlanStatus():
        return 'PlanStatus';
      case _in6mynjk.Question():
        return 'Question';
      case _ixi4rbc4.QuestionStatus():
        return 'QuestionStatus';
      case _i4zxqgb9.ReconRow():
        return 'ReconRow';
      case _iah46kd8.RxCache():
        return 'RxCache';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Alert') {
      return deserialize<_iqmz6gj4.Alert>(data['data']);
    }
    if (dataClassName == 'AuditLog') {
      return deserialize<_itixckla.AuditLog>(data['data']);
    }
    if (dataClassName == 'BottleScan') {
      return deserialize<_ifld0q78.BottleScan>(data['data']);
    }
    if (dataClassName == 'CareLink') {
      return deserialize<_ilhcsb3l.CareLink>(data['data']);
    }
    if (dataClassName == 'CareRole') {
      return deserialize<_ipgwqulm.CareRole>(data['data']);
    }
    if (dataClassName == 'DischargePlan') {
      return deserialize<_iun0pa6x.DischargePlan>(data['data']);
    }
    if (dataClassName == 'DoseEvent') {
      return deserialize<_i6sqb1u1.DoseEvent>(data['data']);
    }
    if (dataClassName == 'DoseSchedule') {
      return deserialize<_iqv8gzde.DoseSchedule>(data['data']);
    }
    if (dataClassName == 'DoseState') {
      return deserialize<_ivb9e1ub.DoseState>(data['data']);
    }
    if (dataClassName == 'AccessDeniedException') {
      return deserialize<_i62njew3.AccessDeniedException>(data['data']);
    }
    if (dataClassName == 'FlaggedScan') {
      return deserialize<_ix0j9q1o.FlaggedScan>(data['data']);
    }
    if (dataClassName == 'MeView') {
      return deserialize<_iu86wh6v.MeView>(data['data']);
    }
    if (dataClassName == 'PatientSummary') {
      return deserialize<_iwqcihyo.PatientSummary>(data['data']);
    }
    if (dataClassName == 'PcpSummary') {
      return deserialize<_iy7eu2en.PcpSummary>(data['data']);
    }
    if (dataClassName == 'PlanDraftInput') {
      return deserialize<_i09ss2f2.PlanDraftInput>(data['data']);
    }
    if (dataClassName == 'PlanItemInput') {
      return deserialize<_ikd8eydh.PlanItemInput>(data['data']);
    }
    if (dataClassName == 'PlanView') {
      return deserialize<_iytyh6s9.PlanView>(data['data']);
    }
    if (dataClassName == 'ReconOutcome') {
      return deserialize<_irkzenra.ReconOutcome>(data['data']);
    }
    if (dataClassName == 'RxHit') {
      return deserialize<_i25f6c9t.RxHit>(data['data']);
    }
    if (dataClassName == 'SafetyFlagDto') {
      return deserialize<_ity9sy6e.SafetyFlagDto>(data['data']);
    }
    if (dataClassName == 'ScanHistoryEntry') {
      return deserialize<_ibi54gyh.ScanHistoryEntry>(data['data']);
    }
    if (dataClassName == 'ScanInput') {
      return deserialize<_i84iv1s5.ScanInput>(data['data']);
    }
    if (dataClassName == 'ScheduleView') {
      return deserialize<_itg4xv15.ScheduleView>(data['data']);
    }
    if (dataClassName == 'LinkStatus') {
      return deserialize<_i1hij6nc.LinkStatus>(data['data']);
    }
    if (dataClassName == 'Patient') {
      return deserialize<_ius4lr2t.Patient>(data['data']);
    }
    if (dataClassName == 'PlanItemRow') {
      return deserialize<_iwji8ji8.PlanItemRow>(data['data']);
    }
    if (dataClassName == 'PlanStatus') {
      return deserialize<_iqzysob1.PlanStatus>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_in6mynjk.Question>(data['data']);
    }
    if (dataClassName == 'QuestionStatus') {
      return deserialize<_ixi4rbc4.QuestionStatus>(data['data']);
    }
    if (dataClassName == 'ReconRow') {
      return deserialize<_i4zxqgb9.ReconRow>(data['data']);
    }
    if (dataClassName == 'RxCache') {
      return deserialize<_iah46kd8.RxCache>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      return _iais.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(19),
      });
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      return _iacs.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(20),
      });
    }
    if (dataClassName.startsWith('serverpod.')) {
      return _isp.Protocol().deserializeByClassName({
        ...data,
        'className': dataClassName.substring(10),
      });
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('medbridge', this);
    _iacs.Protocol().registerHostProtocol('medbridge', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _iqmz6gj4.Alert:
        return _iqmz6gj4.Alert.t;
      case _itixckla.AuditLog:
        return _itixckla.AuditLog.t;
      case _ifld0q78.BottleScan:
        return _ifld0q78.BottleScan.t;
      case _ilhcsb3l.CareLink:
        return _ilhcsb3l.CareLink.t;
      case _iun0pa6x.DischargePlan:
        return _iun0pa6x.DischargePlan.t;
      case _i6sqb1u1.DoseEvent:
        return _i6sqb1u1.DoseEvent.t;
      case _iqv8gzde.DoseSchedule:
        return _iqv8gzde.DoseSchedule.t;
      case _ius4lr2t.Patient:
        return _ius4lr2t.Patient.t;
      case _iwji8ji8.PlanItemRow:
        return _iwji8ji8.PlanItemRow.t;
      case _in6mynjk.Question:
        return _in6mynjk.Question.t;
      case _i4zxqgb9.ReconRow:
        return _i4zxqgb9.ReconRow.t;
      case _iah46kd8.RxCache:
        return _iah46kd8.RxCache.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  List<_isp.TableDefinition> getOwnTableDefinitions() => _ownTableDefinitions;

  @override
  String getModuleName() => 'medbridge';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
