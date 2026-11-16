import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_ui/med_ui.dart';

double contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

void main() {
  final palettes = {
    'light': Palettes.light,
    'dark': Palettes.dark,
    'highContrast': Palettes.highContrast,
  };
  for (final p in palettes.entries) {
    group('${p.key} palette (A13.2 #8)', () {
      for (final (name, fg, bg) in p.value.contrastPairs) {
        test('$name ≥ 4.5:1 floor', () {
          expect(contrast(fg, bg), greaterThanOrEqualTo(4.5));
        });
      }
      test('body text ≥ 7:1', () {
        expect(
          contrast(p.value.onSurface, p.value.surface),
          greaterThanOrEqualTo(7),
        );
      });
    });
  }

  test('status colors never reuse brand teal', () {
    for (final p in palettes.values) {
      for (final s in [p.ok, p.info, p.amber, p.red]) {
        expect(s, isNot(p.brandAccent));
      }
    }
  });
}
