/// What the discharge plan says to do with a medicine.
///
/// Names avoid Dart keywords (A8.1).
enum PlanAction {
  /// Continue taking as before ("CONTINUE taking").
  keep,

  /// Same medicine, new directions or strength ("CHANGE how you take").
  change,

  /// Stop taking ("STOP taking").
  stop,

  /// A new medicine ("START taking").
  start,

  /// Pause until a date or condition.
  hold,
}

/// The outcome of reconciling one scanned bottle against the plan.
enum ReconStatus {
  /// Continue — the bottle matches a `keep` plan item.
  keep,

  /// Changed — new directions, a different strength, or a mismatch.
  changed,

  /// Stop — the plan stopped this medicine.
  stop,

  /// New — the bottle matches a `start` plan item.
  newMed,

  /// Hold — the plan paused this medicine.
  hold,

  /// Duplicate class — may do the same job as another plan medicine.
  duplicate,

  /// Unknown — not on the plan, unreadable, or unsupported.
  unknown,
}

/// How urgent a result is. Declared in ascending order so `index` compares.
enum Severity {
  /// Nothing to do.
  ok,

  /// Informational.
  info,

  /// Needs a check.
  amber,

  /// Needs action now.
  red;

  /// The more severe of this and [other]. Overlays use this so they can only
  /// raise severity, never lower it (A8.4 #6).
  Severity atLeast(Severity other) => index >= other.index ? this : other;
}

/// Features of a sig that are detected but deliberately not supported (A6.5),
/// plus the [zeroRisk] notation warning.
enum SigFlag {
  /// A taper or multiple dose blocks.
  taper,

  /// Not daily: weekly, every other day, weekday names.
  nonDaily,

  /// Sliding-scale dosing.
  slidingScale,

  /// Half-tablet dosing.
  halfTab,

  /// A liquid volume dose (mL, tsp, tbsp).
  liquidVolume,

  /// A dose range ("1-2").
  rangeDose,

  /// A trailing zero or missing leading zero: 10x error risk. Supported, but
  /// forces confirmation.
  zeroRisk;

  /// Whether this flag makes the sig unsupported (everything but [zeroRisk]).
  bool get isUnsupported => this != zeroRisk;

  /// The stable code used in `SIG_UNSUPPORTED:{code}` reasons.
  String get code => switch (this) {
    taper => 'TAPER',
    nonDaily => 'NON_DAILY',
    slidingScale => 'SLIDING_SCALE',
    halfTab => 'HALF_TAB',
    liquidVolume => 'LIQUID_VOLUME',
    rangeDose => 'RANGE_DOSE',
    zeroRisk => 'ZERO_RISK',
  };
}

/// Route of administration.
enum DoseRoute {
  /// By mouth.
  oral,

  /// Under the tongue.
  sublingual,

  /// Inhaled.
  inhalation,

  /// On the skin.
  topical,

  /// Through the skin (patch).
  transdermal,

  /// Under the skin (injection).
  subcutaneous,

  /// In the eye.
  ophthalmic,
}

/// Which eye, for ophthalmic routes.
enum EyeSide {
  /// Right eye (OD).
  right,

  /// Left eye (OS).
  left,

  /// Both eyes (OU).
  both,
}

/// A time-of-day slot on the daily schedule.
enum DoseSlot {
  /// Morning.
  morning,

  /// Noon.
  noon,

  /// Afternoon (used by q8h).
  afternoon,

  /// Evening.
  evening,

  /// Bedtime.
  bedtime,
}

/// Timing relative to food.
enum FoodTiming {
  /// Before meals (AC).
  before,

  /// After meals (PC).
  after,

  /// With food.
  withFood,
}

/// A UI language with plain-language templates.
enum Lang {
  /// English.
  en,

  /// Spanish (draft, pending translator review).
  es,
}

/// The kind of safety overlay that raised a [Severity] (A8.3).
enum SafetyKind {
  /// Look-alike / sound-alike names.
  lasa,

  /// High-alert medicine.
  highRisk,

  /// Drug–drug interaction.
  interaction,

  /// Patient allergy.
  allergy,
}
