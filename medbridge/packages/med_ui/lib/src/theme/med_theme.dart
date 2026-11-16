import 'package:material_ui/material_ui.dart';
import 'package:med_ui/src/theme/med_dims.dart';
import 'package:med_ui/src/theme/palettes.dart';

/// The three theme variants (A13.1).
enum MedThemeVariant {
  /// Light (default).
  light,

  /// Dark.
  dark,

  /// High contrast.
  highContrast,
}

/// The bundled font (Atkinson Hyperlegible, Braille Institute, OFL).
const medFontFamily = 'AtkinsonHyperlegible';

/// Builds the full [ThemeData] for [variant]. Body text 18 sp, headings
/// 24 / 28; the system text scale is never clamped.
ThemeData buildMedTheme(MedThemeVariant variant) {
  final c = switch (variant) {
    MedThemeVariant.light => Palettes.light,
    MedThemeVariant.dark => Palettes.dark,
    MedThemeVariant.highContrast => Palettes.highContrast,
  };
  const d = MedDims();
  final brightness = variant == MedThemeVariant.dark
      ? Brightness.dark
      : Brightness.light;
  final scheme = ColorScheme(
    brightness: brightness,
    primary: c.brand,
    onPrimary: c.onBrand,
    secondary: c.brandAccent,
    onSecondary: c.onBrand,
    surface: c.surface,
    onSurface: c.onSurface,
    surfaceContainerHighest: c.surfaceRaised,
    surfaceContainer: c.surfaceRaised,
    onSurfaceVariant: c.onSurfaceMuted,
    outline: c.hairline,
    error: c.red,
    onError: c.surfaceRaised,
  );
  const tabular = [FontFeature.tabularFigures()];
  final text =
      const TextTheme(
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 1.35,
        ),
        bodyLarge: TextStyle(fontSize: 18, height: 1.45, fontFeatures: tabular),
        bodyMedium: TextStyle(
          fontSize: 18,
          height: 1.45,
          fontFeatures: tabular,
        ),
        bodySmall: TextStyle(fontSize: 16, height: 1.4, fontFeatures: tabular),
        labelLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        labelMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ).apply(
        bodyColor: c.onSurface,
        displayColor: c.onSurface,
        fontFamily: medFontFamily,
      );
  final border = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(d.radius),
  );
  final strong = variant == MedThemeVariant.highContrast;
  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    fontFamily: medFontFamily,
    textTheme: text,
    scaffoldBackgroundColor: c.surface,
    materialTapTargetSize: MaterialTapTargetSize.padded,
    visualDensity: VisualDensity.standard,
    extensions: [c, d],
    appBarTheme: AppBarTheme(
      backgroundColor: c.brand,
      foregroundColor: c.onBrand,
      titleTextStyle: text.titleLarge?.copyWith(color: c.onBrand),
    ),
    cardTheme: CardThemeData(
      color: c.surfaceRaised,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: border.copyWith(
        side: BorderSide(
          color: c.hairline,
          width: strong ? d.strongBorderWidth : d.borderWidth,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: c.brand,
        foregroundColor: c.onBrand,
        minimumSize: Size(d.minTarget, d.bigButtonHeight),
        textStyle: text.labelLarge,
        shape: border,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: c.brand,
        minimumSize: Size(d.minTarget, d.bigButtonHeight),
        side: BorderSide(color: c.brand, width: d.strongBorderWidth),
        textStyle: text.labelLarge,
        shape: border,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: c.brand,
        minimumSize: Size(d.minTarget, d.minTarget),
        textStyle: text.labelLarge,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: c.surfaceRaised,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(d.radius)),
      labelStyle: text.bodyLarge,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: c.surfaceRaised,
      indicatorColor: c.infoContainer,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: WidgetStatePropertyAll(text.labelMedium),
    ),
    focusColor: c.focus.withValues(alpha: 0.24),
  );
}
