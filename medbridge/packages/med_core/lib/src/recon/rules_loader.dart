import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/rule_set.dart';

/// Builds a [RuleSet] from decoded rule files keyed by file stem:
/// `config`, `lasa_pairs`, `high_risk`, `ddi_pairs`, `class_groups`.
///
/// Rule files are shipped, versioned assets checked by tests, so a malformed
/// file is a build defect: this throws [FormatException] rather than guess.
RuleSet loadRules(Map<String, Object?> files) {
  final config = _map(files['config'], 'config');
  final lasa = _map(files['lasa_pairs'], 'lasa_pairs');
  final high = _map(files['high_risk'], 'high_risk');
  final ddi = _map(files['ddi_pairs'], 'ddi_pairs');
  final groups = _map(files['class_groups'], 'class_groups');
  return RuleSet(
    config: _config(config),
    lasa: [
      for (final p in _list(lasa['pairs']))
        LasaPair(
          _str(p, 'a').toLowerCase(),
          _str(p, 'b').toLowerCase(),
          tallA: _map(p, 'pair')['tallA'] as String?,
          tallB: _map(p, 'pair')['tallB'] as String?,
        ),
    ],
    highRisk: {
      for (final i in _list(high['items'])) _str(i, 'ing').toLowerCase(),
    },
    ddi: [
      for (final p in _list(ddi['pairs']))
        DdiPair(
          _str(p, 'a').toLowerCase(),
          _str(p, 'b').toLowerCase(),
          _str(p, 'sev'),
          _str(p, 'msg'),
        ),
    ],
    groups: {
      for (final e in _map(groups['groups'], 'groups').entries)
        e.key: {for (final c in _list(e.value)) c.toString()},
    },
    hasTestRows: [lasa, high, ddi].any((f) => f['test'] == true),
  );
}

/// Builds [SigRules] from decoded `sig_abbrev.json`.
SigRules loadSigRules(Map<String, Object?> json) => SigRules({
  for (final e in _map(json['tokens'], 'tokens').entries)
    e.key.toLowerCase(): SigToken(
      _str(e.value, 'field'),
      _map(e.value, e.key)['value'] ?? '',
    ),
});

/// Builds [AvsRules] from decoded `avs_headers.json`.
AvsRules loadAvsRules(Map<String, Object?> json) {
  List<String> heads(String k) => [
    for (final h in _list(json[k])) h.toString().toLowerCase(),
  ];
  return AvsRules(
    actions: {for (final a in PlanAction.values) a: heads(a.name)},
    allergies: heads('allergies'),
    endSection: heads('end'),
    allergySynonyms: {
      for (final e in _map(
        json['allergySynonyms'] ?? const <String, Object?>{},
        'allergySynonyms',
      ).entries)
        e.key.toLowerCase(): e.value.toString().toLowerCase(),
    },
  );
}

/// Builds [SigTemplates] from decoded `sig_templates.json`.
SigTemplates loadSigTemplates(Map<String, Object?> json) => SigTemplates({
  for (final lang in Lang.values)
    if (json[lang.name] != null)
      lang: {
        for (final e in _map(json[lang.name], lang.name).entries)
          e.key: e.value.toString(),
      },
});

RuleConfig _config(Map<String, Object?> c) {
  double d(String k, double fallback) =>
      (c[k] is num) ? (c[k]! as num).toDouble() : fallback;
  int i(String k, int fallback) => (c[k] is int) ? c[k]! as int : fallback;
  return RuleConfig(
    version: _str(c, 'version'),
    confFloor: d('confFloor', 0.7),
    confHigh: d('confHigh', 0.9),
    lasaDelta: d('lasaDelta', 0.05),
    missedWindowMin: i('missedWindowMin', 120),
    missedAlertN: i('missedAlertN', 2),
    penaltyZeroRisk: d('penaltyZeroRisk', 0.2),
    penaltyMissingStrength: d('penaltyMissingStrength', 0.3),
    penaltySingleFrame: d('penaltySingleFrame', 0.1),
  );
}

Map<String, Object?> _map(Object? v, String what) {
  if (v is Map) return v.cast<String, Object?>();
  throw FormatException('Rule file: "$what" must be an object');
}

List<Object?> _list(Object? v) => v is List ? v.cast<Object?>() : const [];

String _str(Object? m, String key) {
  final v = _map(m, key)[key];
  if (v is String) return v;
  throw FormatException('Rule file: "$key" must be a string');
}
