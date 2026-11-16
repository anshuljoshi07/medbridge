import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/src/l10n_gen/med_localizations.dart';
import 'package:med_ui/src/text/status_view.dart';
import 'package:med_ui/src/theme/med_colors.dart';
import 'package:med_ui/src/theme/med_dims.dart';
import 'package:med_ui/src/widgets/basics.dart';

/// The full-screen result card (A13.4 "Result", F4): large status icon and
/// word, one-sentence instruction, source quote, read-aloud and add-question.
/// Announced to screen readers via a live region (A13.5).
class StatusCard extends StatelessWidget {
  /// Creates the card.
  const StatusCard({
    required this.status,
    required this.sev,
    required this.medName,
    required this.message,
    this.sourceLine,
    this.flags = const [],
    this.onReadAloud,
    this.onAddQuestion,
    super.key,
  });

  /// The status.
  final ReconStatus status;

  /// Final severity (after overlays).
  final Severity sev;

  /// The scanned medicine's display name.
  final String medName;

  /// Plain-language instruction.
  final String message;

  /// Plan source line, if matched.
  final String? sourceLine;

  /// Overlay flag kinds to badge (LASA, high-risk, DDI, allergy).
  final List<SafetyKind> flags;

  /// Reads the message aloud.
  final VoidCallback? onReadAloud;

  /// Adds a question.
  final VoidCallback? onAddQuestion;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    final t = Theme.of(context).textTheme;
    return Semantics(
      liveRegion: true,
      container: true,
      label: '${status.label(l)}. $medName. $message',
      child: Card(
        shape: d.cardShape.copyWith(
          side: BorderSide(color: sev.fg(c), width: d.strongBorderWidth),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.all(d.gapM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Header(status: status, sev: sev),
              SizedBox(height: d.gapM),
              Text(medName, style: t.titleLarge),
              SizedBox(height: d.gapS),
              Text(message, style: t.titleMedium),
              for (final f in flags) ...[
                SizedBox(height: d.gapS),
                _FlagRow(kind: f),
              ],
              if (sourceLine != null && sourceLine!.isNotEmpty) ...[
                SizedBox(height: d.gapM),
                SourceQuote(text: sourceLine!, heading: l.fromYourPapers),
              ],
              SizedBox(height: d.gapM),
              if (onReadAloud != null)
                BigButton(
                  label: l.readAloud,
                  onPressed: onReadAloud,
                  icon: Icons.volume_up,
                  secondary: true,
                ),
              if (onAddQuestion != null) ...[
                SizedBox(height: d.gapS),
                BigButton(
                  label: l.addToQuestions,
                  onPressed: onAddQuestion,
                  icon: Icons.question_answer,
                  secondary: true,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.status, required this.sev});
  final ReconStatus status;
  final Severity sev;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    return ExcludeSemantics(
      child: Container(
        padding: EdgeInsetsDirectional.all(d.gapM),
        decoration: BoxDecoration(
          color: sev.bg(c),
          borderRadius: BorderRadius.circular(d.radius),
        ),
        child: Row(
          children: [
            Icon(status.icon, size: d.iconXl, color: sev.fg(c)),
            SizedBox(width: d.gapM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status.label(l),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: sev.fg(c),
                    ),
                  ),
                  Text(sev.label(l), style: TextStyle(color: sev.fg(c))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlagRow extends StatelessWidget {
  const _FlagRow({required this.kind});
  final SafetyKind kind;

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final (icon, text, sev) = switch (kind) {
      SafetyKind.allergy => (Icons.warning, l.allergyBlock, Severity.red),
      SafetyKind.interaction => (
        Icons.sync_problem,
        l.interactionBanner(''),
        Severity.amber,
      ),
      SafetyKind.highRisk => (
        Icons.priority_high,
        l.highRiskBadge,
        Severity.info,
      ),
      SafetyKind.lasa => (Icons.spellcheck, l.lasaBadge, Severity.amber),
    };
    final c = MedColors.of(context);
    return Row(
      children: [
        Icon(icon, color: sev.fg(c)),
        SizedBox(width: MedDims.of(context).gapS),
        Expanded(child: Text(text)),
      ],
    );
  }
}
