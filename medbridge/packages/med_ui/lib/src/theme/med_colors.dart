import 'package:material_ui/material_ui.dart';

/// Semantic color slots (tier 2). Widgets read these, never raw colors.
///
/// Brand navy/teal is for chrome only (app bar, primary buttons). Severity
/// colors are a separate palette and never reuse teal, so teal can't be
/// misread as "OK" (A13.1).
@immutable
class MedColors extends ThemeExtension<MedColors> {
  /// Creates the slot set.
  const MedColors({
    required this.surface,
    required this.surfaceRaised,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.hairline,
    required this.brand,
    required this.onBrand,
    required this.brandAccent,
    required this.focus,
    required this.ok,
    required this.okContainer,
    required this.info,
    required this.infoContainer,
    required this.amber,
    required this.amberContainer,
    required this.red,
    required this.redContainer,
  });

  /// Page background.
  final Color surface;

  /// Card background.
  final Color surfaceRaised;

  /// Body text.
  final Color onSurface;

  /// Secondary text.
  final Color onSurfaceMuted;

  /// Borders and dividers.
  final Color hairline;

  /// Brand navy: app bar, primary buttons.
  final Color brand;

  /// Text on [brand].
  final Color onBrand;

  /// Brand teal: chrome accents only, never status.
  final Color brandAccent;

  /// Keyboard focus ring.
  final Color focus;

  /// Severity "ok" foreground.
  final Color ok;

  /// Severity "ok" container.
  final Color okContainer;

  /// Severity "info" foreground.
  final Color info;

  /// Severity "info" container.
  final Color infoContainer;

  /// Severity "amber" foreground.
  final Color amber;

  /// Severity "amber" container.
  final Color amberContainer;

  /// Severity "red" foreground.
  final Color red;

  /// Severity "red" container.
  final Color redContainer;

  /// The slots from the nearest theme. Asserts if the theme was not built
  /// with `buildMedTheme` — never falls back to an unverified palette.
  static MedColors of(BuildContext context) {
    final ext = Theme.of(context).extension<MedColors>();
    assert(
      ext != null,
      'MedColors missing. Build ThemeData via buildMedTheme().',
    );
    return ext!;
  }

  /// Foreground/background pairs that must pass contrast checks.
  List<(String, Color, Color)> get contrastPairs => [
    ('body', onSurface, surface),
    ('body-raised', onSurface, surfaceRaised),
    ('muted', onSurfaceMuted, surface),
    ('brand', onBrand, brand),
    ('ok', ok, okContainer),
    ('info', info, infoContainer),
    ('amber', amber, amberContainer),
    ('red', red, redContainer),
    ('red-on-surface', red, surface),
  ];

  @override
  MedColors copyWith({Color? surface, Color? onSurface}) => MedColors(
    surface: surface ?? this.surface,
    surfaceRaised: surfaceRaised,
    onSurface: onSurface ?? this.onSurface,
    onSurfaceMuted: onSurfaceMuted,
    hairline: hairline,
    brand: brand,
    onBrand: onBrand,
    brandAccent: brandAccent,
    focus: focus,
    ok: ok,
    okContainer: okContainer,
    info: info,
    infoContainer: infoContainer,
    amber: amber,
    amberContainer: amberContainer,
    red: red,
    redContainer: redContainer,
  );

  @override
  MedColors lerp(MedColors? other, double t) {
    if (other == null) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t) ?? b;
    return MedColors(
      surface: l(surface, other.surface),
      surfaceRaised: l(surfaceRaised, other.surfaceRaised),
      onSurface: l(onSurface, other.onSurface),
      onSurfaceMuted: l(onSurfaceMuted, other.onSurfaceMuted),
      hairline: l(hairline, other.hairline),
      brand: l(brand, other.brand),
      onBrand: l(onBrand, other.onBrand),
      brandAccent: l(brandAccent, other.brandAccent),
      focus: l(focus, other.focus),
      ok: l(ok, other.ok),
      okContainer: l(okContainer, other.okContainer),
      info: l(info, other.info),
      infoContainer: l(infoContainer, other.infoContainer),
      amber: l(amber, other.amber),
      amberContainer: l(amberContainer, other.amberContainer),
      red: l(red, other.red),
      redContainer: l(redContainer, other.redContainer),
    );
  }
}
