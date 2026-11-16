import 'dart:convert';

import 'package:med_core/src/domain/rule_set.dart';
import 'package:med_core/src/recon/rules_bundle.dart';
import 'package:med_core/src/recon/rules_loader.dart';

/// The rule files shipped with this build, decoded once.
///
/// Device and server both use these, so `ruleVersion` always matches.
abstract final class ShippedRules {
  static Map<String, Object?> _file(String stem) =>
      (jsonDecode(rulesBundleJson[stem]!) as Map).cast<String, Object?>();

  /// Reconciliation and safety rules.
  static final RuleSet ruleSet = loadRules({
    for (final stem in const [
      'config',
      'lasa_pairs',
      'high_risk',
      'ddi_pairs',
      'class_groups',
    ])
      stem: _file(stem),
  });

  /// Supported sig vocabulary.
  static final SigRules sigRules = loadSigRules(_file('sig_abbrev'));

  /// AVS section headers.
  static final AvsRules avsRules = loadAvsRules(_file('avs_headers'));

  /// Plain-language templates.
  static final SigTemplates templates = loadSigTemplates(
    _file('sig_templates'),
  );
}
