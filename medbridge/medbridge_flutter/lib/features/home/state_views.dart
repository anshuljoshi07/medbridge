import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';
import 'package:medbridge_client/medbridge_client.dart';

/// Content-shaped skeleton shown only after a 300 ms delay (A13.5).
class DelayedSkeleton extends StatefulWidget {
  const DelayedSkeleton({super.key});

  @override
  State<DelayedSkeleton> createState() => _DelayedSkeletonState();
}

class _DelayedSkeletonState extends State<DelayedSkeleton> {
  bool _show = false;
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _timer ??= Timer(MedDims.of(context).skeletonDelay, () {
      if (mounted) setState(() => _show = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_show) return const SizedBox.shrink();
    final d = MedDims.of(context);
    final c = MedColors.of(context);
    return ListView(
      padding: EdgeInsetsDirectional.all(d.gapM),
      children: [
        for (var i = 0; i < 3; i++)
          Container(
            height: d.bigButtonHeight * 2,
            margin: EdgeInsetsDirectional.only(bottom: d.gapM),
            decoration: BoxDecoration(color: c.hairline.withValues(alpha: 0.4), borderRadius: BorderRadius.circular(d.radius)),
          ),
      ],
    );
  }
}

/// Plain cause + next step, never an error code (A13.5).
class ErrorView extends StatelessWidget {
  const ErrorView({required this.error, required this.onRetry, super.key});
  final Object error;
  final VoidCallback onRetry;

  static String messageFor(Object error, MedL10n l) {
    final text = '$error'.toLowerCase();
    if (text.contains('socket') || text.contains('connection') || text.contains('xmlhttprequest') || text.contains('failed host')) {
      return l.noInternet;
    }
    if (error is AccessDeniedException) return error.message;
    return l.errorGeneric;
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    return Padding(
      padding: EdgeInsetsDirectional.all(d.gapL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(messageFor(error, l), textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: d.gapL),
          BigButton(label: l.tryAgain, onPressed: onRetry, icon: Icons.refresh),
        ],
      ),
    );
  }
}
