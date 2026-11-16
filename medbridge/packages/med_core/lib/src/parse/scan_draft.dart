import 'package:med_core/src/domain/dose_form.dart';
import 'package:med_core/src/domain/parsed_sig.dart';
import 'package:med_core/src/domain/scan.dart';
import 'package:med_core/src/domain/strength.dart';
import 'package:med_core/src/parse/lexicon.dart';
import 'package:meta/meta.dart';

/// What the label parser read from a bottle, before the patient confirms.
@immutable
final class ScanDraft {
  /// Creates a draft.
  const ScanDraft({
    required this.name,
    required this.ings,
    required this.form,
    required this.conf,
    required this.frames,
    required this.lines,
    this.rxcui,
    this.classIds = const {},
    this.strength,
    this.sigRaw = '',
    this.sig,
    this.needsChoice = false,
    this.candidates = const [],
    this.qty,
    this.refills,
    this.fillDate,
    this.prescriber,
  });

  /// A draft with nothing recognized: confidence 0, so it becomes Unknown.
  const ScanDraft.empty({required int frames, required List<String> lines})
    : this(
        name: '',
        ings: const {},
        form: const DoseForm(FormBase.unknown, Release.immediate),
        conf: 0,
        frames: frames,
        lines: lines,
      );

  /// Best drug name.
  final String name;

  /// RxNorm concept id, when resolved from the lexicon.
  final String? rxcui;

  /// Ingredients of the best match.
  final Set<String> ings;

  /// ATC level-4 classes of the best match.
  final Set<String> classIds;

  /// Strength, when read.
  final Strength? strength;

  /// Dose form and release.
  final DoseForm form;

  /// Label directions as read.
  final String sigRaw;

  /// Parsed label directions.
  final ParsedSig? sig;

  /// Read confidence (A7.3).
  final double conf;

  /// Whether the LASA gate requires a forced choice between [candidates].
  final bool needsChoice;

  /// Top candidates (1 or 2), best first.
  final List<LexMatch> candidates;

  /// Quantity dispensed.
  final int? qty;

  /// Refills remaining.
  final int? refills;

  /// Fill date as printed.
  final String? fillDate;

  /// Prescriber as printed.
  final String? prescriber;

  /// Frames that contributed.
  final int frames;

  /// Consensus text lines (not images; nothing visual is kept).
  final List<String> lines;

  /// The [Scan] to reconcile once the patient answers the confirm screen.
  Scan toScan({required bool confirmed, Set<String> groupIds = const {}}) =>
      Scan(
        rxcui: rxcui,
        name: name,
        ings: ings,
        strength: strength,
        form: form,
        sigRaw: sigRaw,
        sig: sig,
        conf: conf,
        confirmed: confirmed,
        classIds: classIds,
        groupIds: groupIds,
      );
}
