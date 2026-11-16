import 'dart:convert';

import 'package:med_core/med_core.dart' as core;
import 'package:medbridge_client/medbridge_client.dart';

List<String> _list(String json) => [
  for (final v in (jsonDecode(json) as List)) '$v',
];

/// Server row → med_core item (mirrors the server adapter, same rules).
core.PlanItem itemToCore(PlanItemRow r) => core.PlanItem(
  id: r.itemKey,
  action: core.PlanAction.values.firstWhere(
    (a) => a.name == r.action,
    orElse: () => core.PlanAction.keep,
  ),
  name: r.name,
  rxcui: r.rxcui,
  ings: _list(r.ingsJson).toSet(),
  scd: r.scd,
  strength: core.Strength.tryParse(r.strength),
  form: core.DoseForm.parse('${r.form} ${r.name}'),
  sigRaw: r.sigRaw,
  sig: r.sigRaw.isEmpty
      ? null
      : core.parseSig(r.sigRaw, core.ShippedRules.sigRules),
  holdUntil: r.holdUntil,
  holdNote: r.holdNote,
  src: r.src,
  conf: r.conf,
  classIds: _list(r.classIdsJson).toSet(),
);

/// Server plan → med_core plan.
core.Plan planToCore(PlanView v) => core.Plan(
  id: '${v.plan.id}',
  items: [for (final r in v.items) itemToCore(r)],
  allergies: _list(v.plan.allergiesJson).toSet(),
  verified: v.plan.status == PlanStatus.verified,
);

/// Parsed draft → upload payload.
PlanDraftInput draftToInput(core.PlanDraft d) => PlanDraftInput(
  items: [
    for (final i in d.items)
      PlanItemInput(
        itemKey: i.id,
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
  ],
  allergies: d.allergies.toList(),
  unrecognized: [for (final l in d.unrecognized) l.text],
);

/// A confirmed label read → scan payload. [chosen] replaces the top
/// candidate after a LASA choice. Text only; no image is ever sent.
ScanInput draftToScan(core.ScanDraft d, {core.LexMatch? chosen}) {
  final entry = chosen?.entry;
  final name = entry?.name ?? d.name;
  return ScanInput(
    rxcui: entry == null ? d.rxcui : (entry.rxcui.isEmpty ? null : entry.rxcui),
    name: '$name ${d.strength?.display ?? ''}'.trim(),
    ings: (entry?.ings ?? d.ings).toList(),
    strength: d.strength?.display,
    form: '${d.form.base.name}'
        '${d.form.release == core.Release.extended ? ' ER' : ''}'
        '${d.form.release == core.Release.delayed ? ' DR' : ''}',
    sigRaw: d.sigRaw,
    conf: d.conf,
    confirmed: true,
    classIds: (entry?.atc4 ?? d.classIds).toList(),
    ocrText: d.lines.join('\n'),
  );
}

/// Severity / status names → med_core enums.
core.Severity sevOf(String s) => core.Severity.values.firstWhere(
  (v) => v.name == s,
  orElse: () => core.Severity.amber,
);

core.ReconStatus statusOf(String s) => core.ReconStatus.values.firstWhere(
  (v) => v.name == s,
  orElse: () => core.ReconStatus.unknown,
);
