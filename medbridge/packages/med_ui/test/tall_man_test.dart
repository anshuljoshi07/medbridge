import 'package:flutter_test/flutter_test.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

String render(List<TallManPart> parts) => parts.map((p) => p.text).join();

void main() {
  final rules = ShippedRules.ruleSet;
  test('A13.4 example: hydrOXYzine / hydrALAZINE', () {
    expect(render(tallMan('hydroxyzine', rules)), 'hydrOXYzine');
    expect(render(tallMan('hydralazine', rules)), 'hydrALAZINE');
    expect(tallMan('hydroxyzine', rules)[1], (text: 'OXY', emphasized: true));
  });
  test('names without a partner are unchanged', () {
    expect(tallMan('losartan', rules), [(text: 'losartan', emphasized: false)]);
  });
  test('algorithmic fallback capitalizes the differing middle', () {
    expect(render(tallManAgainst('cefotaxime', 'cefoxitin')), 'cefoTAXIME');
  });
}
