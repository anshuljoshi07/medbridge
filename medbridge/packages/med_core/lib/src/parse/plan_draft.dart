import 'package:med_core/src/domain/plan_item.dart';
import 'package:med_core/src/parse/ocr_types.dart';
import 'package:meta/meta.dart';

/// What the AVS parser extracted, before the patient confirms (A7.1).
@immutable
final class PlanDraft {
  /// Creates a draft.
  const PlanDraft({
    required this.items,
    required this.unrecognized,
    required this.allergies,
  });

  /// Parsed items, each with its source line(s) and confidence.
  final List<PlanItem> items;

  /// Lines in medication sections that could not be parsed. Never dropped:
  /// the review screen shows them under "Lines we couldn't read".
  final List<OcrLine> unrecognized;

  /// Lower-case allergy terms, including class group keys.
  final Set<String> allergies;
}
