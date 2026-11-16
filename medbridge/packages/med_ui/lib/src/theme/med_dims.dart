import 'package:material_ui/material_ui.dart';

/// Spacing, sizes, shapes and motion slots.
@immutable
class MedDims extends ThemeExtension<MedDims> {
  /// Creates the slot set.
  const MedDims({
    this.gapXs = 4,
    this.gapS = 8,
    this.gapM = 16,
    this.gapL = 24,
    this.gapXl = 32,
    this.radius = 12,
    this.bigButtonHeight = 56,
    this.minTarget = 48,
    this.borderWidth = 1,
    this.strongBorderWidth = 2,
    this.iconS = 24,
    this.iconL = 40,
    this.iconXl = 72,
    this.maxContentWidth = 640,
    this.motionShort = const Duration(milliseconds: 150),
    this.motionMedium = const Duration(milliseconds: 250),
    this.skeletonDelay = const Duration(milliseconds: 300),
    this.undoWindow = const Duration(seconds: 5),
  });

  /// 4.
  final double gapXs;

  /// 8.
  final double gapS;

  /// 16 (also the phone side gutter).
  final double gapM;

  /// 24.
  final double gapL;

  /// 32.
  final double gapXl;

  /// Card and button corner radius.
  final double radius;

  /// Primary button height (A13.2: 56 dp, full width).
  final double bigButtonHeight;

  /// Minimum target size (A13.2: 48 dp).
  final double minTarget;

  /// Hairline border.
  final double borderWidth;

  /// Emphasis border (high-contrast, severity cards).
  final double strongBorderWidth;

  /// Inline icon.
  final double iconS;

  /// Card icon.
  final double iconL;

  /// Result-screen status icon.
  final double iconXl;

  /// Readable column width on wide screens.
  final double maxContentWidth;

  /// Short motion.
  final Duration motionShort;

  /// Medium motion.
  final Duration motionMedium;

  /// Delay before a loading skeleton appears (A13.5).
  final Duration skeletonDelay;

  /// Taken / Skip undo window (A13.2 #5).
  final Duration undoWindow;

  /// The card shape.
  RoundedRectangleBorder get cardShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

  /// The slots from the nearest theme.
  static MedDims of(BuildContext context) {
    final ext = Theme.of(context).extension<MedDims>();
    assert(
      ext != null,
      'MedDims missing. Build ThemeData via buildMedTheme().',
    );
    return ext!;
  }

  /// Motion collapsed to zero under the OS reduce-motion flag (never just
  /// "gentler"). Haptics are unaffected.
  static Duration motion(BuildContext context, Duration full) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : full;

  @override
  MedDims copyWith() => this;

  // Dimensions don't change between themes: snap deliberately.
  @override
  MedDims lerp(MedDims? other, double t) => t < 0.5 ? this : (other ?? this);
}
