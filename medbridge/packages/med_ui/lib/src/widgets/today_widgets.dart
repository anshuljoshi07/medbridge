import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/src/l10n_gen/med_localizations.dart';
import 'package:med_ui/src/text/status_view.dart';
import 'package:med_ui/src/theme/med_colors.dart';
import 'package:med_ui/src/theme/med_dims.dart';
import 'package:med_ui/src/widgets/basics.dart';

/// Pinned "N medicines need attention → Review" card (A13.4 Today).
class AttentionBanner extends StatelessWidget {
  /// Creates the banner for [count] unresolved red results.
  const AttentionBanner({
    required this.count,
    required this.onReview,
    super.key,
  });

  /// Unresolved red results.
  final int count;

  /// Opens the review list.
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    return Card(
      color: c.redContainer,
      shape: d.cardShape.copyWith(
        side: BorderSide(color: c.red, width: d.strongBorderWidth),
      ),
      child: InkWell(
        onTap: onReview,
        customBorder: d.cardShape,
        child: Padding(
          padding: EdgeInsetsDirectional.all(d.gapM),
          child: Row(
            children: [
              Icon(Severity.red.icon, color: c.red, size: d.iconL),
              SizedBox(width: d.gapM),
              Expanded(
                child: Text(
                  l.needsAttention(count),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: c.red),
                ),
              ),
              Text(
                l.review,
                style: TextStyle(color: c.red, fontWeight: FontWeight.w700),
              ),
              Icon(Icons.chevron_right, color: c.red),
            ],
          ),
        ),
      ),
    );
  }
}

/// The "Next dose" hero card with Taken / Skip.
class NextDoseCard extends StatelessWidget {
  /// Creates the card.
  const NextDoseCard({
    required this.timeLabel,
    required this.medName,
    required this.doseLabel,
    required this.onTaken,
    required this.onSkip,
    super.key,
  });

  /// e.g. "8:00 AM".
  final String timeLabel;

  /// Medicine name.
  final String medName;

  /// e.g. "1 tablet".
  final String doseLabel;

  /// Marks taken.
  final VoidCallback onTaken;

  /// Marks skipped.
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    final t = Theme.of(context).textTheme;
    return Card(
      child: Padding(
        padding: EdgeInsetsDirectional.all(d.gapM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.nextDose, style: t.labelLarge),
            SizedBox(height: d.gapXs),
            Text(timeLabel, style: t.headlineMedium),
            Text(medName, style: t.titleLarge),
            Text(doseLabel, style: t.bodyLarge),
            SizedBox(height: d.gapM),
            BigButton(label: l.taken, onPressed: onTaken, icon: Icons.check),
            SizedBox(height: d.gapS),
            BigButton(label: l.skip, onPressed: onSkip, secondary: true),
          ],
        ),
      ),
    );
  }
}

/// One medicine row in a Today slot section.
class PillRow extends StatelessWidget {
  /// Creates a row.
  const PillRow({
    required this.medName,
    required this.detail,
    required this.state,
    required this.onTaken,
    required this.onSkip,
    super.key,
  });

  /// Medicine name.
  final String medName;

  /// Plain-language directions.
  final String detail;

  /// Logged state, or `null` when not yet logged.
  final DoseState? state;

  /// Marks taken.
  final VoidCallback onTaken;

  /// Marks skipped.
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final l = MedL10n.of(context);
    final t = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical: d.gapS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(medName, style: t.titleMedium),
          Text(detail, style: t.bodyMedium?.copyWith(color: c.onSurfaceMuted)),
          SizedBox(height: d.gapS),
          switch (state) {
            DoseState.taken => _Logged(icon: Icons.check_circle, text: l.taken),
            DoseState.skipped => _Logged(
              icon: Icons.remove_circle,
              text: l.skipped,
            ),
            DoseState.missed || null => Wrap(
              spacing: d.gapS,
              runSpacing: d.gapS,
              children: [
                FilledButton.icon(
                  onPressed: onTaken,
                  icon: const Icon(Icons.check),
                  label: Text(l.taken),
                ),
                OutlinedButton(onPressed: onSkip, child: Text(l.skip)),
              ],
            ),
          },
        ],
      ),
    );
  }
}

class _Logged extends StatelessWidget {
  const _Logged({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    return Row(
      children: [
        Icon(icon, color: c.onSurfaceMuted),
        SizedBox(width: MedDims.of(context).gapXs),
        Text(text, style: TextStyle(color: c.onSurfaceMuted)),
      ],
    );
  }
}

/// A Morning / Noon / Evening / Bedtime section.
class SlotSection extends StatelessWidget {
  /// Creates a section for [slot] with [children] rows.
  const SlotSection({required this.slot, required this.children, super.key});

  /// The slot.
  final DoseSlot slot;

  /// Pill rows.
  final List<Widget> children;

  /// The localized slot name.
  static String slotLabel(MedL10n l, DoseSlot s) => switch (s) {
    DoseSlot.morning => l.slotMorning,
    DoseSlot.noon => l.slotNoon,
    DoseSlot.afternoon => l.slotAfternoon,
    DoseSlot.evening => l.slotEvening,
    DoseSlot.bedtime => l.slotBedtime,
  };

  @override
  Widget build(BuildContext context) {
    final d = MedDims.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsDirectional.all(d.gapM),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Semantics(
              header: true,
              child: Text(
                slotLabel(MedL10n.of(context), slot),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// "3 of 5 taken today" — text plus ring (no streaks, no shame).
class ProgressRingLabeled extends StatelessWidget {
  /// Creates the ring.
  const ProgressRingLabeled({
    required this.taken,
    required this.total,
    super.key,
  });

  /// Doses taken today.
  final int taken;

  /// Doses due today.
  final int total;

  @override
  Widget build(BuildContext context) {
    final c = MedColors.of(context);
    final d = MedDims.of(context);
    final label = MedL10n.of(context).takenOfTotal(taken, total);
    return Semantics(
      label: label,
      excludeSemantics: true,
      child: Row(
        children: [
          SizedBox.square(
            dimension: d.iconL,
            child: CircularProgressIndicator(
              value: total == 0 ? 0 : taken / total,
              color: c.brand,
              backgroundColor: c.hairline,
              strokeWidth: d.gapXs,
            ),
          ),
          SizedBox(width: d.gapM),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.titleMedium),
          ),
        ],
      ),
    );
  }
}

/// A plan-review filter chip (New · Changed · Keep taking · Paused · Stopped).
class PlanChip extends StatelessWidget {
  /// Creates a chip.
  const PlanChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  /// Group label.
  final String label;

  /// Items in the group.
  final int count;

  /// Whether the group is shown.
  final bool selected;

  /// Toggle.
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) => FilterChip(
    label: Text('$label ($count)'),
    selected: selected,
    onSelected: onSelected,
    materialTapTargetSize: MaterialTapTargetSize.padded,
  );
}
