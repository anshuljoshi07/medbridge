/// MedBridge pure domain: NDC normalization, sig parsing and rendering,
/// AVS and label parsing, reconciliation and safety checks.
///
/// No Flutter, no Serverpod, no I/O: the same code runs on device and server.
library;

export 'src/domain/dose_form.dart';
export 'src/domain/enums.dart';
export 'src/domain/parsed_sig.dart';
export 'src/domain/plan.dart';
export 'src/domain/plan_item.dart';
export 'src/domain/recon.dart';
export 'src/domain/rule_set.dart';
export 'src/domain/scan.dart';
export 'src/domain/strength.dart';
export 'src/ndc/ndc.dart';
export 'src/parse/avs_parser.dart';
export 'src/parse/confidence.dart';
export 'src/parse/label_parser.dart';
export 'src/parse/lexicon.dart';
export 'src/parse/ocr_types.dart';
export 'src/parse/plan_draft.dart';
export 'src/parse/scan_draft.dart';
export 'src/parse/text_similarity.dart';
export 'src/parse/vote.dart';
export 'src/recon/reconcile.dart';
export 'src/recon/rules_loader.dart';
export 'src/recon/safety.dart';
export 'src/recon/shipped_rules.dart';
export 'src/schedule/reminder_plan.dart';
export 'src/sig/sig_flags.dart';
export 'src/sig/sig_parser.dart';
export 'src/sig/sig_render.dart';
export 'src/sig/sig_slots.dart';
export 'src/util/clock.dart';
export 'src/util/result.dart';
