import 'package:med_core/med_core.dart';
import 'package:test/test.dart';

import 'support/rules.dart';

void main() {
  test('embedded bundle matches rules/*.json', () {
    final shipped = ShippedRules.ruleSet;
    expect(shipped.version, testRules.version);
    expect(shipped.highRisk, testRules.highRisk);
    expect(shipped.groups.keys, testRules.groups.keys);
    expect(shipped.lasa.length, testRules.lasa.length);
    expect(ShippedRules.sigRules.tokens.keys, testSigRules.tokens.keys);
    expect(ShippedRules.avsRules.endSection, testAvsRules.endSection);
  });
}
