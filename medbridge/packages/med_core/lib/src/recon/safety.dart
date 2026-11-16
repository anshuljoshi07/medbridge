import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/plan.dart';
import 'package:med_core/src/domain/recon.dart';
import 'package:med_core/src/domain/rule_set.dart';
import 'package:med_core/src/domain/scan.dart';
import 'package:med_core/src/recon/reconcile.dart';

/// Runs the A8.3 safety overlays for [s] given its [base] result.
///
/// Overlays can raise severity, never lower it; they never advise stopping a
/// medicine. Pure and total.
List<SafetyFlag> checkSafety(ReconResult base, Plan p, Scan s, RuleSet r) {
  final taking =
      base.status != ReconStatus.stop && base.status != ReconStatus.hold;
  final others = [
    for (final i in p.items)
      if (i.isActive && i.id != base.itemId) i,
  ];
  final scanGroups = {...r.groupsFor(s.classIds), ...s.groupIds};
  final flags = <SafetyFlag>[
    for (final term in _sorted(p.allergies))
      if (s.ings.contains(term) || scanGroups.contains(term))
        SafetyFlag(SafetyKind.allergy, Severity.red, 'ALLERGY:$term'),
    if (r.isHighRisk(s.ings))
      SafetyFlag(
        SafetyKind.highRisk,
        base.status == ReconStatus.unknown ? Severity.red : Severity.info,
        'HIGH_RISK',
      ),
  ];
  final seen = <String>{};
  for (final other in others) {
    for (final a in _sorted(s.ings)) {
      for (final b in _sorted(other.ings)) {
        if (r.isLasaPair(a, b) && seen.add('LASA:$a|$b')) {
          flags.add(SafetyFlag(SafetyKind.lasa, Severity.amber, 'LASA:$a|$b'));
        }
        if (!taking) continue;
        for (final d in r.ddi) {
          final hit = (d.a == a && d.b == b) || (d.a == b && d.b == a);
          final code = 'DDI:${_pairKey(a, b)}';
          if (hit && seen.add(code)) {
            flags.add(
              SafetyFlag(
                SafetyKind.interaction,
                Severity.amber,
                code,
                detail: d.msg,
              ),
            );
          }
        }
      }
    }
  }
  return flags;
}

/// [reconcile] followed by [checkSafety]: the full result the app and server
/// both show and persist.
ReconResult reconcileWithSafety(Plan p, Scan s, RuleSet r) {
  final base = reconcile(p, s, r);
  return base.withFlags(checkSafety(base, p, s, r));
}

List<String> _sorted(Set<String> s) => s.toList()..sort();

String _pairKey(String a, String b) => a.compareTo(b) <= 0 ? '$a+$b' : '$b+$a';
