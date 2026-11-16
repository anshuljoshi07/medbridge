import 'package:med_core/src/domain/enums.dart';
import 'package:meta/meta.dart';

/// Tunable thresholds from `rules/config.json` (A7.3, A9.4).
@immutable
final class RuleConfig {
  /// Creates a config.
  const RuleConfig({
    required this.version,
    this.confFloor = 0.7,
    this.confHigh = 0.9,
    this.lasaDelta = 0.05,
    this.missedWindowMin = 120,
    this.missedAlertN = 2,
    this.penaltyZeroRisk = 0.2,
    this.penaltyMissingStrength = 0.3,
    this.penaltySingleFrame = 0.1,
  });

  /// Rule version stamped on every result.
  final String version;

  /// Below this confidence a read is Unknown (`LOW_CONFIDENCE`).
  final double confFloor;

  /// At or above this confidence the confirm screen is pre-filled.
  final double confHigh;

  /// Top-2 candidates closer than this force a choice screen.
  final double lasaDelta;

  /// Minutes after a due time before a dose counts as missed.
  final int missedWindowMin;

  /// Consecutive missed doses that trigger a caregiver alert.
  final int missedAlertN;

  /// Confidence penalty for `ZERO_RISK` notation.
  final double penaltyZeroRisk;

  /// Confidence penalty when no strength was read.
  final double penaltyMissingStrength;

  /// Confidence penalty for a single-frame read.
  final double penaltySingleFrame;
}

/// A look-alike / sound-alike name pair.
@immutable
final class LasaPair {
  /// Creates a pair of lower-case names, with optional curated Tall Man
  /// spellings.
  const LasaPair(this.a, this.b, {this.tallA, this.tallB});

  /// First name.
  final String a;

  /// Second name.
  final String b;

  /// ISMP Tall Man spelling of [a] (e.g. `hydrOXYzine`), if curated.
  final String? tallA;

  /// ISMP Tall Man spelling of [b] (e.g. `hydrALAZINE`), if curated.
  final String? tallB;

  /// Whether this pair is exactly {[x], [y]} in either order.
  bool matches(String x, String y) => (a == x && b == y) || (a == y && b == x);
}

/// A curated drug–drug interaction.
@immutable
final class DdiPair {
  /// Creates an interaction between lower-case ingredients [a] and [b].
  const DdiPair(this.a, this.b, this.sev, this.msg);

  /// First ingredient.
  final String a;

  /// Second ingredient.
  final String b;

  /// Source severity label, e.g. `major`.
  final String sev;

  /// Plain-language risk, e.g. "bleeding risk".
  final String msg;
}

/// Everything reconciliation and safety checks need, versioned (A9.1).
@immutable
final class RuleSet {
  /// Creates a rule set.
  const RuleSet({
    required this.config,
    this.lasa = const [],
    this.highRisk = const {},
    this.ddi = const [],
    this.groups = const {},
    this.hasTestRows = false,
  });

  /// Thresholds and the rule version.
  final RuleConfig config;

  /// Look-alike / sound-alike pairs.
  final List<LasaPair> lasa;

  /// High-alert ingredients.
  final Set<String> highRisk;

  /// Curated interactions.
  final List<DdiPair> ddi;

  /// Duplicate class groups: key → ATC level-4 ids.
  final Map<String, Set<String>> groups;

  /// Whether any loaded list still has placeholder `"test": true` rows.
  final bool hasTestRows;

  /// The rule version stamped on results.
  String get version => config.version;

  /// Group keys that contain any of [classIds].
  Set<String> groupsFor(Set<String> classIds) => {
    for (final e in groups.entries)
      if (e.value.any(classIds.contains)) e.key,
  };

  /// Whether any of [ings] is a high-alert medicine.
  bool isHighRisk(Set<String> ings) => ings.any(highRisk.contains);

  /// Whether [x] and [y] are a listed LASA pair.
  bool isLasaPair(String x, String y) => lasa.any((p) => p.matches(x, y));
}

/// One supported sig token mapping (`rules/sig_abbrev.json`).
@immutable
final class SigToken {
  /// Creates a mapping of a token to a [field] and [value].
  const SigToken(this.field, this.value);

  /// Target field: route, eye, perDay, everyH, slot, prn, food, unit.
  final String field;

  /// The value: a name, an int or a bool.
  final Object value;
}

/// The supported sig vocabulary (A6.4).
@immutable
final class SigRules {
  /// Creates sig rules from lower-case [tokens].
  const SigRules(this.tokens);

  /// Lower-case token or phrase → mapping.
  final Map<String, SigToken> tokens;

  /// Longest phrase length in words, for greedy matching.
  int get maxPhraseWords => tokens.keys.fold(
    1,
    (m, k) => k.split(' ').length > m ? k.split(' ').length : m,
  );
}

/// Section headers that set a plan item's action (`rules/avs_headers.json`).
@immutable
final class AvsRules {
  /// Creates AVS rules.
  const AvsRules({
    required this.actions,
    required this.allergies,
    this.endSection = const [],
    this.allergySynonyms = const {},
  });

  /// Header prefixes per action, lower-case.
  final Map<PlanAction, List<String>> actions;

  /// Allergy header prefixes, lower-case.
  final List<String> allergies;

  /// Header prefixes that end the medication sections.
  final List<String> endSection;

  /// Allergy words → class group keys, e.g. `penicillin` → `penicillins`.
  final Map<String, String> allergySynonyms;
}

/// Plain-language sig templates per language (A6.6).
@immutable
final class SigTemplates {
  /// Creates templates.
  const SigTemplates(this.byLang);

  /// Language → key → template.
  final Map<Lang, Map<String, String>> byLang;

  /// The template for [key] in [lang], falling back to English, then to ''.
  String get(Lang lang, String key) =>
      byLang[lang]?[key] ?? byLang[Lang.en]?[key] ?? '';

  /// Whether [lang] is still a draft pending medical-translator review.
  bool isPendingReview(Lang lang) => byLang[lang]?['_status'] != null;
}
