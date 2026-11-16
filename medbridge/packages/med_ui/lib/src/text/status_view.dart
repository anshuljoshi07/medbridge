import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/src/l10n_gen/med_localizations.dart';
import 'package:med_ui/src/theme/med_colors.dart';

/// Severity → icon, word and color. Color is derived last and never the only
/// signal (A13.2 #2).
extension SeverityView on Severity {
  /// Distinct glyph per severity (shape, not just color).
  IconData get icon => switch (this) {
    Severity.ok => Icons.check_circle,
    Severity.info => Icons.info,
    Severity.amber => Icons.help,
    Severity.red => Icons.report,
  };

  /// The word.
  String label(MedL10n l) => switch (this) {
    Severity.ok => l.sevOk,
    Severity.info => l.sevInfo,
    Severity.amber => l.sevAmber,
    Severity.red => l.sevRed,
  };

  /// Foreground color slot.
  Color fg(MedColors c) => switch (this) {
    Severity.ok => c.ok,
    Severity.info => c.info,
    Severity.amber => c.amber,
    Severity.red => c.red,
  };

  /// Container color slot.
  Color bg(MedColors c) => switch (this) {
    Severity.ok => c.okContainer,
    Severity.info => c.infoContainer,
    Severity.amber => c.amberContainer,
    Severity.red => c.redContainer,
  };

  /// Parses a stored name; unknown values are treated as amber (ask).
  static Severity parse(String name) => Severity.values.firstWhere(
    (s) => s.name == name,
    orElse: () => Severity.amber,
  );
}

/// Status → glyph and UI label (A8.1).
extension ReconStatusView on ReconStatus {
  /// Distinct glyph per status.
  IconData get icon => switch (this) {
    ReconStatus.keep => Icons.check_circle,
    ReconStatus.changed => Icons.change_circle,
    ReconStatus.stop => Icons.block,
    ReconStatus.newMed => Icons.fiber_new,
    ReconStatus.hold => Icons.pause_circle,
    ReconStatus.duplicate => Icons.content_copy,
    ReconStatus.unknown => Icons.help,
  };

  /// UI label: Continue / Changed / Stop / New / Hold / Duplicate / Unknown.
  String label(MedL10n l) => switch (this) {
    ReconStatus.keep => l.statusKeep,
    ReconStatus.changed => l.statusChanged,
    ReconStatus.stop => l.statusStop,
    ReconStatus.newMed => l.statusNew,
    ReconStatus.hold => l.statusHold,
    ReconStatus.duplicate => l.statusDuplicate,
    ReconStatus.unknown => l.statusUnknown,
  };

  /// Parses a stored name; unknown values are treated as Unknown.
  static ReconStatus parse(String name) => ReconStatus.values.firstWhere(
    (s) => s.name == name,
    orElse: () => ReconStatus.unknown,
  );
}

/// The one-sentence patient instruction for a result (A8.2 "Patient sees").
///
/// [sigText] is the plain-language rendering of the plan sig, or `null`
/// when unsupported (then "Ask your pharmacist" is shown instead).
String patientMessage(
  MedL10n l,
  String reason,
  Map<String, String> params, {
  String? sigText,
}) {
  final sig = sigText ?? l.askPharmacist;
  final planMed = params['planMed'] ?? '';
  final when = params['date'] ?? params['condition'] ?? l.untilFollowUp;
  return switch (reason.split(':').first) {
    'LOW_CONFIDENCE' => l.msgLowConfidence,
    'PLAN_STOP' => l.msgPlanStop,
    'PLAN_HOLD' => l.msgPlanHold(when.replaceFirst('until ', '')),
    'NEW_DIRECTIONS' => l.msgNewDirections(sig),
    'OLD_STRENGTH_BOTTLE' => l.msgOldStrength,
    'MATCH' => l.msgMatch(sig),
    'STRENGTH_MISMATCH' || 'FORM_MISMATCH' => l.msgMismatch,
    'NEW_MED' => l.msgNewMed(sig),
    'NEW_MED_MISMATCH' => l.msgNewMedMismatch,
    'SAME_CLASS_AS' => l.msgDuplicate(planMed),
    'COMBO_PARTIAL' => l.msgComboPartial,
    'SIG_UNSUPPORTED' => l.msgSigUnsupported,
    _ => l.msgNotOnPlan,
  };
}
