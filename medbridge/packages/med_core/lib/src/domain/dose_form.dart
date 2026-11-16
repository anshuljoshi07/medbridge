import 'package:meta/meta.dart';

/// The physical form of a medicine (A6.3).
enum FormBase {
  /// Tablet.
  tablet,

  /// Capsule.
  capsule,

  /// Orally disintegrating tablet.
  odt,

  /// Oral solution or suspension.
  liquid,

  /// Inhaler.
  inhaler,

  /// Transdermal patch.
  patch,

  /// Cream or ointment.
  cream,

  /// Eye drops.
  eyeDrops,

  /// Ear drops.
  earDrops,

  /// Injection pen.
  injectionPen,

  /// Not stated or not recognized.
  unknown,
}

/// The release profile. Same ingredient and strength with a different release
/// is not a match (`FORM_MISMATCH`).
enum Release {
  /// Immediate release (the default when nothing else is stated).
  immediate,

  /// Extended release: ER, XR, XL, SR, CR, LA, 24 hr.
  extended,

  /// Delayed release: DR, EC.
  delayed,
}

final _extended = RegExp(
  r'\b(er|xr|xl|sr|cr|la|extended|sustained|controlled|24 ?hr?)\b',
  caseSensitive: false,
);
final _delayed = RegExp(r'\b(dr|ec|delayed|enteric)\b', caseSensitive: false);

/// A parsed dose form: [base] plus [release].
@immutable
final class DoseForm {
  /// Creates a dose form.
  const DoseForm(this.base, this.release);

  /// Parses free text such as `metoprolol succinate ER 25 mg tablet`. Total:
  /// unrecognized text yields [FormBase.unknown].
  factory DoseForm.parse(String text) {
    final t = text.toLowerCase();
    final release = _extended.hasMatch(t)
        ? Release.extended
        : _delayed.hasMatch(t)
        ? Release.delayed
        : Release.immediate;
    return DoseForm(_baseOf(t), release);
  }

  static FormBase _baseOf(String t) {
    bool has(String p) => RegExp('\\b$p').hasMatch(t);
    if (has('odt') || has('disintegrat')) return FormBase.odt;
    if (has('eye') || has('ophth')) return FormBase.eyeDrops;
    if (has('ear') || has('otic')) return FormBase.earDrops;
    if (has('pen') || has('inject')) return FormBase.injectionPen;
    if (has('inhal') || has('puff')) return FormBase.inhaler;
    if (has('patch')) return FormBase.patch;
    if (has('cream') || has('ointment')) return FormBase.cream;
    if (has('solution') || has('suspension') || has('liquid')) {
      return FormBase.liquid;
    }
    if (has('cap')) return FormBase.capsule;
    if (has('tab')) return FormBase.tablet;
    return FormBase.unknown;
  }

  /// The base form.
  final FormBase base;

  /// The release profile.
  final Release release;

  /// Whether a bottle with this form matches a plan item with [other]. An
  /// unknown base is not evidence of a mismatch; a release difference is.
  bool sameAs(DoseForm other) {
    if (release != other.release) return false;
    if (base == FormBase.unknown || other.base == FormBase.unknown) {
      return true;
    }
    return base == other.base;
  }

  @override
  bool operator ==(Object other) =>
      other is DoseForm && other.base == base && other.release == release;

  @override
  int get hashCode => Object.hash(base, release);

  @override
  String toString() => '${base.name}/${release.name}';
}
