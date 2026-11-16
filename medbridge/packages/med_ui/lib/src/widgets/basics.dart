import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/src/l10n_gen/med_localizations.dart';
import 'package:med_ui/src/text/status_view.dart';
import 'package:med_ui/src/text/tall_man.dart';
import 'package:med_ui/src/theme/med_colors.dart';
import 'package:med_ui/src/theme/med_dims.dart';

/// Primary action: 56 dp tall, full width (A13.2 #3).
class BigButton extends StatelessWidget {
  /// Creates a big button. [secondary] renders the outlined variant.
  const BigButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.secondary = false,
    super.key,
  });

  /// Button text (always visible; no icon-only buttons).
  final String label;

  /// Tap handler; `null` disables the button.
  final VoidCallback? onPressed;

  /// Optional leading icon.
  final IconData? icon;

  /// Outlined variant.
  final bool secondary;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon),
          SizedBox(width: MedDims.of(context).gapS),
        ],
        Flexible(child: Text(label, textAlign: TextAlign.center)),
      ],
    );
    final style = ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size.fromHeight(MedDims.of(context).bigButtonHeight),
      ),
    );
    return SizedBox(
      width: double.infinity,
      child: secondary
          ? OutlinedButton(onPressed: onPressed, style: style, child: child)
          : FilledButton(onPressed: onPressed, style: style, child: child),
    );
  }
}

/// Severity as icon + word + color — never color alone.
class SeverityBadge extends StatelessWidget {
  /// Creates a badge for [sev], optionally labeled with [status] instead of
  /// the generic severity word.
  const SeverityBadge({required this.sev, this.status, super.key});

  /// Severity.
  final Severity sev;

  /// Status whose label and glyph to show.
  final ReconStatus? status;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    final label = status?.label(l) ?? sev.label(l);
    return Semantics(
      label: '$label. ${sev.label(l)}',
      excludeSemantics: true,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: d.gapS,
          vertical: d.gapXs,
        ),
        decoration: ShapeDecoration(
          color: sev.bg(c),
          shape: StadiumBorder(
            side: BorderSide(color: sev.fg(c), width: d.borderWidth),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(status?.icon ?? sev.icon, color: sev.fg(c), size: d.iconS),
            SizedBox(width: d.gapXs),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: sev.fg(c),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The plan source line in a quote box, so every result shows where it
/// came from.
class SourceQuote extends StatelessWidget {
  /// Creates a quote of [text] under an optional [heading].
  const SourceQuote({required this.text, this.heading, super.key});

  /// Verbatim source text.
  final String text;

  /// Heading such as "From your discharge papers:".
  final String? heading;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: d.gapXs),
            child: Text(heading!, style: t.labelMedium),
          ),
        Container(
          width: double.infinity,
          padding: EdgeInsetsDirectional.all(d.gapM),
          decoration: BoxDecoration(
            color: c.surface,
            border: BorderDirectional(
              start: BorderSide(color: c.hairline, width: d.gapXs),
            ),
          ),
          child: Text(
            text,
            style: t.bodyLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}

/// A drug name with Tall Man lettering for confusable names.
class TallManText extends StatelessWidget {
  /// Renders [name] using LASA pairs from [rules].
  const TallManText(this.name, {required this.rules, this.style, super.key});

  /// The drug name.
  final String name;

  /// Rule set holding LASA pairs.
  final RuleSet rules;

  /// Base style.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.headlineSmall;
    final parts = tallMan(name, rules);
    return Text.rich(
      TextSpan(
        children: [
          for (final p in parts)
            TextSpan(
              text: p.text,
              style: p.emphasized
                  ? base?.copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    )
                  : base,
            ),
        ],
      ),
      // Screen readers read the plain name, not spelled capitals.
      semanticsLabel: name,
    );
  }
}

/// A centered empty state with a big action.
class EmptyState extends StatelessWidget {
  /// Creates an empty state.
  const EmptyState({
    required this.message,
    required this.actionLabel,
    required this.onAction,
    this.icon = Icons.description,
    super.key,
  });

  /// The message.
  final String message;

  /// The action label.
  final String actionLabel;

  /// The action.
  final VoidCallback onAction;

  /// Illustrative icon.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final d = MedDims.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.all(d.gapL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ExcludeSemantics(
            child: Icon(
              icon,
              size: d.iconXl,
              color: MedColors.of(context).brand,
            ),
          ),
          SizedBox(height: d.gapL),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: d.gapL),
          BigButton(
            label: actionLabel,
            onPressed: onAction,
            icon: Icons.document_scanner,
          ),
        ],
      ),
    );
  }
}

/// "You're offline. Everything still works on this phone." — calm, not red.
class OfflineNote extends StatelessWidget {
  /// Creates the note.
  const OfflineNote({super.key});

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        color: c.infoContainer,
        padding: EdgeInsetsDirectional.all(d.gapS),
        child: Row(
          children: [
            Icon(Icons.cloud_off, color: c.info),
            SizedBox(width: d.gapS),
            Expanded(
              child: Text(
                MedL10n.of(context).offline,
                style: TextStyle(color: c.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Persistent caregiver-mode banner (A13.3).
class CaregiverBanner extends StatelessWidget {
  /// Creates the banner for [patientName]; [onSwitch] shows a switcher.
  const CaregiverBanner({required this.patientName, this.onSwitch, super.key});

  /// The patient's first name.
  final String patientName;

  /// Opens the patient switcher when linked to more than one patient.
  final VoidCallback? onSwitch;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    return Material(
      color: c.brandAccent,
      child: InkWell(
        onTap: onSwitch,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: d.minTarget),
          child: Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: d.gapM),
            child: Row(
              children: [
                Icon(Icons.visibility, color: c.onBrand),
                SizedBox(width: d.gapS),
                Expanded(
                  child: Text(
                    MedL10n.of(context).viewingMeds(patientName),
                    style: TextStyle(
                      color: c.onBrand,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (onSwitch != null) Icon(Icons.swap_horiz, color: c.onBrand),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
