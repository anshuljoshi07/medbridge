import 'package:med_core/med_core.dart';

import 'rules.dart';

/// ATC level-4 classes for the synthetic medicines used in tests.
const atc = {
  'lisinopril': 'C09AA',
  'benazepril': 'C09AA',
  'losartan': 'C09CA',
  'valsartan': 'C09CA',
  'metoprolol': 'C07AB',
  'atorvastatin': 'C10AA',
  'simvastatin': 'C10AA',
  'metformin': 'A10BA',
  'omeprazole': 'A02BC',
  'warfarin': 'B01AA',
  'ibuprofen': 'M01AE',
  'amoxicillin': 'J01CA',
  'hydrochlorothiazide': 'C03AA',
  'hydroxyzine': 'N05BB',
  'hydralazine': 'C02DB',
};

Set<String> _classes(Set<String> ings) => {
  for (final i in ings)
    if (atc[i] != null) atc[i]!,
};

/// A plan item built from readable text.
PlanItem item(
  String id,
  PlanAction action,
  String drugLine, {
  Set<String>? ings,
  String sig = '1 tab PO daily',
  String? holdNote,
  double conf = 0.95,
}) {
  final ingredients = ings ?? {id};
  return PlanItem(
    id: id,
    action: action,
    name: drugLine,
    ings: ingredients,
    strength: Strength.tryParse(drugLine),
    form: DoseForm.parse(drugLine),
    sigRaw: sig,
    sig: parseSig(sig, testSigRules),
    holdNote: holdNote,
    src: '$drugLine — $sig',
    conf: conf,
    classIds: _classes(ingredients),
  );
}

/// A scan built from readable label text.
Scan scan(
  String labelLine, {
  required Set<String> ings,
  double conf = 0.95,
  bool confirmed = true,
}) => Scan(
  name: labelLine,
  ings: ings,
  strength: Strength.tryParse(labelLine),
  form: DoseForm.parse(labelLine),
  conf: conf,
  confirmed: confirmed,
  classIds: _classes(ings),
);

/// A plan from [items].
Plan plan(List<PlanItem> items, {Set<String> allergies = const {}}) =>
    Plan(id: 'p1', items: items, allergies: allergies);
