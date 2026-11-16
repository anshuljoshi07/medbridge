import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';
import 'package:medbridge_client/medbridge_client.dart';

import '../../data/app_data.dart';
import '../../data/med_repository.dart';
import '../home/state_views.dart';

/// Care team (F7, A13.4): invite by code, list with role + Remove; accept a
/// code (caregivers, or a deep link /invite/:code).
class CareTeamScreen extends ConsumerStatefulWidget {
  const CareTeamScreen({this.inviteCode, super.key});
  final String? inviteCode;

  @override
  ConsumerState<CareTeamScreen> createState() => _CareTeamScreenState();
}

class _CareTeamScreenState extends ConsumerState<CareTeamScreen> {
  late final _code = TextEditingController(text: widget.inviteCode ?? '');
  String? _message;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _invite(CareRole role) async {
    final l = MedL10n.of(context);
    final link = await ref.read(repositoryProvider).createInvite(role);
    ref.invalidate(linksProvider);
    if (!mounted) return;
    setState(() => _message = l.inviteCodeIs(link.inviteCode));
    await Clipboard.setData(ClipboardData(text: link.inviteCode));
  }

  Future<void> _accept() async {
    final l = MedL10n.of(context);
    try {
      await ref.read(repositoryProvider).acceptInvite(_code.text);
      ref
        ..invalidate(meProvider)
        ..invalidate(linksProvider);
      refreshAll(ref);
      if (mounted) setState(() => _message = l.done);
    } on Exception catch (e) {
      if (mounted) setState(() => _message = ErrorView.messageFor(e, l));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = MedL10n.of(context);
    final d = MedDims.of(context);
    final me = ref.watch(meProvider).value;
    final isPatient = me?.patient != null;
    final links = ref.watch(linksProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l.careTeam)),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: d.maxContentWidth),
          child: ListView(
            padding: EdgeInsetsDirectional.all(d.gapM),
            children: [
              if (isPatient) ...[
                BigButton(label: '${l.invite}: ${l.roleCaregiver}', icon: Icons.person_add, onPressed: () => _invite(CareRole.caregiver)),
                SizedBox(height: d.gapS),
                BigButton(label: '${l.invite}: pharmacist', icon: Icons.local_pharmacy, secondary: true, onPressed: () => _invite(CareRole.pharmacist)),
                SizedBox(height: d.gapS),
                BigButton(label: '${l.invite}: doctor', icon: Icons.medical_services, secondary: true, onPressed: () => _invite(CareRole.pcp)),
              ] else ...[
                TextField(controller: _code, decoration: InputDecoration(labelText: l.enterInviteCode), textCapitalization: TextCapitalization.characters),
                SizedBox(height: d.gapS),
                BigButton(label: l.continueLabel, onPressed: _accept),
              ],
              if (_message != null) Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: d.gapM),
                child: Semantics(liveRegion: true, child: SelectableText(_message!, style: Theme.of(context).textTheme.titleLarge)),
              ),
              SizedBox(height: d.gapM),
              links.when(
                loading: () => const SizedBox.shrink(),
                error: (e, _) => ErrorView(error: e, onRetry: () => ref.invalidate(linksProvider)),
                data: (list) => Column(
                  children: [
                    for (final link in list)
                      Card(
                        child: ListTile(
                          minTileHeight: d.minTarget,
                          title: Text(link.role.name),
                          subtitle: Text(link.status == LinkStatus.pending ? link.inviteCode : link.status.name),
                          trailing: isPatient ? TextButton(onPressed: () async {
                            await ref.read(repositoryProvider).revoke(link.id!);
                            ref.invalidate(linksProvider);
                          }, child: Text(l.remove)) : null,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
