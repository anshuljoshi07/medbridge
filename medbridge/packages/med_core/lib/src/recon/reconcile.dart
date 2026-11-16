import 'package:med_core/src/domain/enums.dart';
import 'package:med_core/src/domain/plan.dart';
import 'package:med_core/src/domain/plan_item.dart';
import 'package:med_core/src/domain/recon.dart';
import 'package:med_core/src/domain/rule_set.dart';
import 'package:med_core/src/domain/scan.dart';

/// Reconciles one bottle [s] against plan [p] using the A8.2 rule table,
/// top to bottom, first match wins.
///
/// Pure, total and deterministic: no I/O, no clock, exactly one status and
/// reason for every input, stamped with `r.version`. Never outputs a dose.
ReconResult reconcile(Plan p, Scan s, RuleSet r) {
  ReconResult out(
    ReconStatus status,
    String reason,
    Severity sev, {
    PlanItem? item,
  }) => ReconResult(
    status: status,
    reason: reason,
    sev: sev,
    ruleVersion: r.version,
    itemId: item?.id,
    params: item == null ? const {} : _params(item),
  );

  // Row 0.
  if (!s.confirmed || s.conf < r.config.confFloor) {
    return out(ReconStatus.unknown, 'LOW_CONFIDENCE', Severity.amber);
  }
  final matches = [
    for (final item in p.items)
      if (item.ings.any(s.ings.contains)) item,
  ];
  if (matches.isNotEmpty) {
    final exact = matches.where((i) => _sameProduct(i, s)).toList();
    if (exact.isNotEmpty) return _ingredientRow(exact.first, s, out);
    final results = [for (final i in matches) _ingredientRow(i, s, out)];
    return results.reduce((a, b) => b.sev.index > a.sev.index ? b : a);
  }
  // Row 9: same ATC-4 class or same curated group as an active plan item.
  final scanGroups = {...r.groupsFor(s.classIds), ...s.groupIds};
  for (final item in p.items.where((i) => i.isActive)) {
    final sameClass = item.classIds.any(s.classIds.contains);
    final sameGroup = r.groupsFor(item.classIds).any(scanGroups.contains);
    if (sameClass || sameGroup) {
      return out(
        ReconStatus.duplicate,
        'SAME_CLASS_AS:${item.id}',
        Severity.red,
        item: item,
      );
    }
  }
  // Row 10.
  return out(
    ReconStatus.unknown,
    'NOT_ON_PLAN',
    r.isHighRisk(s.ings) ? Severity.red : Severity.amber,
  );
}

typedef _Out =
    ReconResult Function(
      ReconStatus status,
      String reason,
      Severity sev, {
      PlanItem? item,
    });

/// Rows 1–8 plus `SIG_UNSUPPORTED` and `COMBO_PARTIAL`, for an item that
/// shares at least one ingredient with the scan.
ReconResult _ingredientRow(PlanItem item, Scan s, _Out out) {
  switch (item.action) {
    case PlanAction.stop:
      return out(ReconStatus.stop, 'PLAN_STOP', Severity.red, item: item);
    case PlanAction.hold:
      return out(ReconStatus.hold, 'PLAN_HOLD', Severity.amber, item: item);
    case PlanAction.keep || PlanAction.change || PlanAction.start:
      break;
  }
  final unsupported = item.sig?.firstUnsupported;
  if (unsupported != null) {
    return out(
      ReconStatus.unknown,
      'SIG_UNSUPPORTED:${unsupported.code}',
      Severity.amber,
      item: item,
    );
  }
  if (!_sameIngredients(item, s)) {
    return out(ReconStatus.changed, 'COMBO_PARTIAL', Severity.red, item: item);
  }
  final same = _sameProduct(item, s);
  return switch (item.action) {
    PlanAction.change when same => out(
      ReconStatus.changed,
      'NEW_DIRECTIONS',
      Severity.amber,
      item: item,
    ),
    PlanAction.change => out(
      ReconStatus.changed,
      'OLD_STRENGTH_BOTTLE',
      Severity.red,
      item: item,
    ),
    PlanAction.keep when same => out(
      ReconStatus.keep,
      'MATCH',
      Severity.ok,
      item: item,
    ),
    PlanAction.keep => out(
      ReconStatus.changed,
      _mismatchReason(item, s),
      Severity.red,
      item: item,
    ),
    PlanAction.start when same => out(
      ReconStatus.newMed,
      'NEW_MED',
      Severity.info,
      item: item,
    ),
    PlanAction.start || PlanAction.stop || PlanAction.hold => out(
      ReconStatus.changed,
      'NEW_MED_MISMATCH',
      Severity.red,
      item: item,
    ),
  };
}

bool _sameIngredients(PlanItem item, Scan s) =>
    item.ings.length == s.ings.length && item.ings.containsAll(s.ings);

/// SCD equality when both are resolved; otherwise strength and form must
/// both be known and equal. Missing data is never treated as a match.
bool _sameProduct(PlanItem item, Scan s) {
  if (!_sameIngredients(item, s)) return false;
  if (item.scd != null && s.scd != null) return item.scd == s.scd;
  final a = item.strength;
  final b = s.strength;
  if (a == null || b == null) return false;
  return a.sameAs(b) && item.form.sameAs(s.form);
}

String _mismatchReason(PlanItem item, Scan s) {
  final a = item.strength;
  final b = s.strength;
  final strengthSame = a != null && b != null && a.sameAs(b);
  return strengthSame ? 'FORM_MISMATCH' : 'STRENGTH_MISMATCH';
}

Map<String, String> _params(PlanItem item) => {
  'planMed': item.name,
  if (item.holdUntil != null)
    'date': item.holdUntil!.toIso8601String().substring(0, 10),
  if (item.holdNote != null) 'condition': item.holdNote!,
};
