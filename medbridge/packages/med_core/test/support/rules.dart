import 'dart:convert';
import 'dart:io';

import 'package:med_core/med_core.dart';

/// Reads and decodes `rules/<stem>.json` from the package root.
Map<String, Object?> readRuleFile(String stem) =>
    (jsonDecode(File('rules/$stem.json').readAsStringSync()) as Map)
        .cast<String, Object?>();

/// The shipped rule set.
final RuleSet testRules = loadRules({
  for (final stem in [
    'config',
    'lasa_pairs',
    'high_risk',
    'ddi_pairs',
    'class_groups',
  ])
    stem: readRuleFile(stem),
});

/// The shipped sig vocabulary.
final SigRules testSigRules = loadSigRules(readRuleFile('sig_abbrev'));

/// The shipped AVS headers.
final AvsRules testAvsRules = loadAvsRules(readRuleFile('avs_headers'));

/// The shipped plain-language templates.
final SigTemplates testTemplates = loadSigTemplates(
  readRuleFile('sig_templates'),
);
