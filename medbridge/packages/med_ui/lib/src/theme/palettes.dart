import 'package:material_ui/material_ui.dart';
import 'package:med_ui/src/theme/med_colors.dart';

/// The three palettes (A13.1). The only place raw colors live, besides
/// primitives used here. Each passes contrast on its own (see tests).
abstract final class Palettes {
  /// Light (default).
  static const light = MedColors(
    surface: Color(0xFFF7F8FA),
    surfaceRaised: Color(0xFFFFFFFF),
    onSurface: Color(0xFF0B1A2E),
    onSurfaceMuted: Color(0xFF3B4859),
    hairline: Color(0xFFC5CDD8),
    brand: Color(0xFF12355B),
    onBrand: Color(0xFFFFFFFF),
    brandAccent: Color(0xFF0E6E6D),
    focus: Color(0xFF6A1B9A),
    ok: Color(0xFF1B5E20),
    okContainer: Color(0xFFE5F3E6),
    info: Color(0xFF0D3F8F),
    infoContainer: Color(0xFFE4EDFB),
    amber: Color(0xFF6B3F00),
    amberContainer: Color(0xFFFFF0D2),
    red: Color(0xFF9E1C14),
    redContainer: Color(0xFFFDE8E6),
  );

  /// Dark: authored by hand, not an auto-flip.
  static const dark = MedColors(
    surface: Color(0xFF0E1621),
    surfaceRaised: Color(0xFF17212E),
    onSurface: Color(0xFFEEF2F7),
    onSurfaceMuted: Color(0xFFB9C4D2),
    hairline: Color(0xFF3A4757),
    brand: Color(0xFF9CC0EA),
    onBrand: Color(0xFF0B1A2E),
    brandAccent: Color(0xFF6CCFCB),
    focus: Color(0xFFE1B3FF),
    ok: Color(0xFF9BDB9F),
    okContainer: Color(0xFF12301A),
    info: Color(0xFFA9CBFA),
    infoContainer: Color(0xFF13243F),
    amber: Color(0xFFF7C977),
    amberContainer: Color(0xFF392806),
    red: Color(0xFFFFA49C),
    redContainer: Color(0xFF3E1512),
  );

  /// High contrast: maximum separation for low vision.
  static const highContrast = MedColors(
    surface: Color(0xFFFFFFFF),
    surfaceRaised: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    onSurfaceMuted: Color(0xFF1A1A1A),
    hairline: Color(0xFF000000),
    brand: Color(0xFF001A3D),
    onBrand: Color(0xFFFFFFFF),
    brandAccent: Color(0xFF00403F),
    focus: Color(0xFF4A0072),
    ok: Color(0xFF0A3B0E),
    okContainer: Color(0xFFFFFFFF),
    info: Color(0xFF00255C),
    infoContainer: Color(0xFFFFFFFF),
    amber: Color(0xFF452800),
    amberContainer: Color(0xFFFFFFFF),
    red: Color(0xFF6E0903),
    redContainer: Color(0xFFFFFFFF),
  );
}
