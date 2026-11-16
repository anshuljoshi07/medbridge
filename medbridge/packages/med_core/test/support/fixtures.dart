import 'dart:convert';
import 'dart:io';

import 'package:med_core/med_core.dart';

import 'builders.dart';

/// Reads and decodes a JSON fixture under `test/fixtures/`.
Map<String, Object?> readFixture(String path) =>
    (jsonDecode(File('test/fixtures/$path').readAsStringSync()) as Map)
        .cast<String, Object?>();

/// Fixture files in `test/fixtures/<dir>/`, sorted.
List<String> fixtureNames(String dir) =>
    (Directory(
          'test/fixtures/$dir',
        ).listSync().map((f) => f.uri.pathSegments.last).toList()..sort())
        .where((n) => n.endsWith('.json'))
        .toList();

/// The shipped RxNorm lexicon (`assets/lexicon.tsv`), loaded once.
final Lexicon testLexicon = Lexicon.fromTsv(
  File('assets/lexicon.tsv').readAsStringSync(),
);

/// The R. Doe plan (B10) used as closed-set context for label fixtures.
final Plan rDoePlan = plan(
  [
    item('losartan', PlanAction.start, 'losartan 50 mg tab'),
    item('lisinopril', PlanAction.stop, 'lisinopril 10 mg tab', sig: ''),
    item('metoprolol', PlanAction.change, 'metoprolol succinate ER 25 mg tab'),
    item(
      'atorvastatin',
      PlanAction.keep,
      'atorvastatin 40 mg tab',
      sig: '1 tab PO QHS',
    ),
    item(
      'metformin',
      PlanAction.hold,
      'metformin 500 mg tab',
      sig: '1 tab PO BID',
      holdNote: 'until follow-up',
    ),
  ],
  allergies: {'penicillin', 'penicillins'},
);
