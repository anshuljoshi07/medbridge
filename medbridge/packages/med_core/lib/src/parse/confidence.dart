import 'package:med_core/src/domain/rule_set.dart';

/// What the confirm screen does with a read (A7.3).
enum ConfBand {
  /// ≥ confHigh: confirm screen pre-filled.
  prefill,

  /// confFloor..confHigh: confirm with the doubtful field highlighted.
  highlight,

  /// < confFloor: Unknown (`LOW_CONFIDENCE`).
  unknown,
}

/// Read confidence: `min(nameScore, strengthScore)` minus penalties, clamped
/// to 0..1 and rounded to 2 decimals so device and server agree exactly.
double readConfidence({
  required double nameScore,
  required RuleConfig config,
  double strengthScore = 1,
  bool zeroRisk = false,
  bool missingStrength = false,
  bool singleFrame = false,
}) {
  var c = nameScore < strengthScore ? nameScore : strengthScore;
  if (zeroRisk) c -= config.penaltyZeroRisk;
  if (missingStrength) c -= config.penaltyMissingStrength;
  if (singleFrame) c -= config.penaltySingleFrame;
  return (c.clamp(0.0, 1.0) * 100).round() / 100;
}

/// The [ConfBand] for confidence [c].
ConfBand confBand(double c, RuleConfig config) => c >= config.confHigh
    ? ConfBand.prefill
    : c >= config.confFloor
    ? ConfBand.highlight
    : ConfBand.unknown;
