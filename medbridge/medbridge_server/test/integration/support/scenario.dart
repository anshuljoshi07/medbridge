import 'dart:convert';
import 'dart:io';

import 'package:med_core/med_core.dart' as core;
import 'package:medbridge_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../test_tools/serverpod_test_tools.dart';

const _coreDir = '../packages/med_core';

/// The shipped RxNorm lexicon.
final core.Lexicon lexicon = core.Lexicon.fromTsv(
  File('$_coreDir/assets/lexicon.tsv').readAsStringSync(),
);

/// Creates an auth user with [roles] and returns its id.
Future<UuidValue> createUser(Session session, Set<String> roles) async {
  final user = await AuthUser.db.insertRow(
    session,
    AuthUser(scopeNames: roles, createdAt: DateTime.now()),
  );
  return user.id!;
}

/// A session builder authenticated as [userId].
TestSessionBuilder as(TestSessionBuilder base, UuidValue userId) =>
    base.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userId.toString(),
        {},
      ),
    );

/// The R. Doe AVS (B10), parsed by the real med_core parser.
core.PlanDraft rDoeDraft() {
  final fx = _fixture('avs/rdoe_clean.json');
  return core.parseAvs(
    [for (final l in (fx['lines']! as List)) core.OcrLine('$l')],
    lexicon,
    core.ShippedRules.avsRules,
    core.ShippedRules.sigRules,
    core.ShippedRules.ruleSet.config,
  );
}

/// Converts a parsed draft into the upload payload.
PlanDraftInput toInput(core.PlanDraft d) => PlanDraftInput(
  items: [
    for (final i in d.items)
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
  ],
  allergies: d.allergies.toList(),
  unrecognized: [for (final l in d.unrecognized) l.text],
);

/// A confirmed scan built from a label fixture via the real label parser.
ScanInput scanFromLabel(String name, core.Plan ctx) {
  final fx = _fixture('labels/$name.json');
  final frames = [
    for (final f in (fx['frames']! as List).cast<List<Object?>>())
      core.OcrFrame([for (final l in f) core.OcrLine('$l')]),
  ];
  final d = core.parseLabel(
    frames,
    lexicon,
    ctx,
    core.ShippedRules.ruleSet,
    core.ShippedRules.sigRules,
  );
  return ScanInput(
    rxcui: d.rxcui,
    name: '${d.name} ${d.strength?.display ?? ''}'.trim(),
    ings: d.ings.toList(),
    strength: d.strength?.display,
    form:
        '${d.form.base.name} ${d.form.release == core.Release.extended ? 'ER' : ''}',
    sigRaw: d.sigRaw,
    conf: d.conf,
    confirmed: true,
    classIds: d.classIds.toList(),
    ocrText: d.lines.join('\n'),
  );
}

Map<String, Object?> _fixture(String path) =>
    (jsonDecode(File('$_coreDir/test/fixtures/$path').readAsStringSync())
            as Map)
        .cast<String, Object?>();
