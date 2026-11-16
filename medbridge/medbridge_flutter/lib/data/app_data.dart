import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:med_core/med_core.dart' as core;
import 'package:medbridge_client/medbridge_client.dart';

import 'adapters.dart';
import 'med_repository.dart';

/// Who is signed in (null until loaded or when signed out).
class MeNotifier extends AsyncNotifier<MeView?> {
  @override
  Future<MeView?> build() => ref.read(repositoryProvider).me();

  Future<void> register(String role, String firstName, String lang) async {
    state = await AsyncValue.guard(
      () => ref.read(repositoryProvider).register(role, firstName, lang),
    );
  }
}

final meProvider = AsyncNotifierProvider<MeNotifier, MeView?>(MeNotifier.new);

/// The patient being viewed: own profile, or (caregiver mode) a linked one.
class ActivePatient {
  const ActivePatient({required this.name, this.patientId, this.isCaregiver = false});

  /// `null` means "my own profile" (the server resolves it).
  final int? patientId;
  final String name;
  final bool isCaregiver;
}

/// Caregiver's chosen patient when linked to more than one.
class SelectedPatientNotifier extends Notifier<int?> {
  @override
  int? build() => null;
  void select(int? id) => state = id;
}

final selectedPatientProvider = NotifierProvider<SelectedPatientNotifier, int?>(
  SelectedPatientNotifier.new,
);

final activePatientProvider = Provider<ActivePatient?>((ref) {
  final me = ref.watch(meProvider).value;
  if (me == null) return null;
  if (me.patient != null) return ActivePatient(name: me.patient!.firstName);
  if (me.linkedPatients.isEmpty) return null;
  final chosen = ref.watch(selectedPatientProvider);
  final p = me.linkedPatients.firstWhere(
    (x) => x.id == chosen,
    orElse: () => me.linkedPatients.first,
  );
  return ActivePatient(patientId: p.id, name: p.firstName, isCaregiver: true);
});

/// The newest plan for the active patient.
final planProvider = FutureProvider<PlanView?>((ref) {
  final ap = ref.watch(activePatientProvider);
  if (ap == null) return null;
  return ref.read(repositoryProvider).plan(patientId: ap.patientId);
});

/// The plan as med_core sees it (for closed-set scans and sig rendering).
final corePlanProvider = Provider<core.Plan?>((ref) {
  final v = ref.watch(planProvider).value;
  return v == null ? null : planToCore(v);
});

final historyProvider = FutureProvider<List<ScanHistoryEntry>>((ref) {
  final ap = ref.watch(activePatientProvider);
  if (ap == null) return const [];
  return ref.read(repositoryProvider).history(patientId: ap.patientId);
});

final scheduleProvider = FutureProvider<List<ScheduleView>>((ref) {
  final ap = ref.watch(activePatientProvider);
  if (ap == null) return const [];
  return ref.read(repositoryProvider).schedule(patientId: ap.patientId);
});

final questionsProvider = FutureProvider<List<Question>>((ref) {
  final ap = ref.watch(activePatientProvider);
  if (ap == null) return const [];
  return ref.read(repositoryProvider).questions(patientId: ap.patientId);
});

final linksProvider = FutureProvider<List<CareLink>>(
  (ref) => ref.read(repositoryProvider).links(),
);

/// Re-fetches everything that depends on the server after a write.
void refreshAll(WidgetRef ref) {
  ref
    ..invalidate(planProvider)
    ..invalidate(historyProvider)
    ..invalidate(scheduleProvider)
    ..invalidate(questionsProvider);
}
