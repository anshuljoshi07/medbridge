import 'dart:convert';

import 'package:med_core/med_core.dart' as core;

import '../generated/protocol.dart';

/// Decodes a JSON string list column.
List<String> decodeList(String json) => [
  for (final v in (jsonDecode(json) as List)) '$v',
];

/// Encodes a string iterable as a JSON column (sorted for stable diffs).
String encodeList(Iterable<String> values) =>
    jsonEncode(values.toList()..sort());

core.PlanAction _action(String name) => core.PlanAction.values.firstWhere(
  (a) => a.name == name,
  orElse: () => core.PlanAction.keep,
);

/// Adapter: database row → med_core [core.PlanItem]. The sig is re-parsed
/// from `sigRaw` with the shipped rules, so device and server agree.
extension PlanItemRowCore on PlanItemRow {
  /// The med_core view of this row.
  core.PlanItem toCore() => core.PlanItem(
    id: itemKey,
    action: _action(action),
    name: name,
    rxcui: rxcui,
    ings: decodeList(ingsJson).toSet(),
    scd: scd,
    strength: core.Strength.tryParse(strength),
    form: core.DoseForm.parse('$form $name'),
    sigRaw: sigRaw,
    sig: sigRaw.isEmpty
        ? null
        : core.parseSig(sigRaw, core.ShippedRules.sigRules),
    holdUntil: holdUntil,
    holdNote: holdNote,
    src: src,
    conf: conf,
    classIds: decodeList(classIdsJson).toSet(),
  );
}

/// Adapter: client input → database row.
PlanItemRow planItemRowFromInput(PlanItemInput i, int planId) {
  final sig = i.sigRaw.isEmpty
      ? null
      : core.parseSig(i.sigRaw, core.ShippedRules.sigRules);
  return PlanItemRow(
    planId: planId,
    itemKey: i.itemKey,
    action: _action(i.action).name,
    name: i.name,
    rxcui: i.rxcui,
    scd: i.scd,
    ingsJson: encodeList(i.ings.map((s) => s.toLowerCase())),
    strength: i.strength ?? '',
    form: i.form,
    route: sig?.route?.name,
    sigRaw: i.sigRaw,
    sigJson: sig == null ? null : jsonEncode(sig.toJson()),
    holdUntil: i.holdUntil,
    holdNote: i.holdNote,
    src: i.src,
    conf: i.conf,
    classIdsJson: encodeList(i.classIds),
  );
}

/// Adapter: plan + rows → med_core [core.Plan].
core.Plan planToCore(DischargePlan plan, List<PlanItemRow> rows) => core.Plan(
  id: '${plan.id}',
  items: [for (final r in rows) r.toCore()],
  allergies: decodeList(plan.allergiesJson).toSet(),
  verified: plan.status == PlanStatus.verified,
);

/// Adapter: client scan input → med_core [core.Scan].
core.Scan scanToCore(ScanInput s) => core.Scan(
  ndc11: s.ndc11,
  rxcui: s.rxcui,
  scd: s.scd,
  name: s.name,
  ings: {for (final i in s.ings) i.toLowerCase()},
  strength: s.strength == null ? null : core.Strength.tryParse(s.strength!),
  form: core.DoseForm.parse('${s.form} ${s.name}'),
  sigRaw: s.sigRaw,
  sig: s.sigRaw.isEmpty
      ? null
      : core.parseSig(s.sigRaw, core.ShippedRules.sigRules),
  conf: s.conf,
  confirmed: s.confirmed,
  classIds: s.classIds.toSet(),
);

/// Adapter: med_core flags → transfer objects.
List<SafetyFlagDto> flagsToDto(List<core.SafetyFlag> flags) => [
  for (final f in flags)
    SafetyFlagDto(
      kind: f.kind.name,
      sev: f.sev.name,
      code: f.code,
      detail: f.detail,
    ),
];
