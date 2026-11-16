import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:med_core/med_core.dart';
import 'package:med_ui/med_ui.dart';

Widget host(
  Widget child, {
  required Locale locale,
  double scale = 1,
  MedThemeVariant v = MedThemeVariant.light,
}) => MaterialApp(
  theme: buildMedTheme(v),
  locale: locale,
  supportedLocales: MedL10n.supportedLocales,
  localizationsDelegates: medLocalizationsDelegates,
  home: MediaQuery(
    data: MediaQueryData(
      size: const Size(390, 844),
      textScaler: TextScaler.linear(scale),
    ),
    child: Scaffold(body: SingleChildScrollView(child: child)),
  ),
);

void main() {
  const sev = {
    ReconStatus.keep: Severity.ok,
    ReconStatus.changed: Severity.red,
    ReconStatus.stop: Severity.red,
    ReconStatus.newMed: Severity.info,
    ReconStatus.hold: Severity.amber,
    ReconStatus.duplicate: Severity.red,
    ReconStatus.unknown: Severity.amber,
  };
  for (final locale in const [Locale('en'), Locale('es')]) {
    for (final scale in const [1.0, 2.0]) {
      for (final variant in MedThemeVariant.values) {
        testWidgets(
          'StatusCard all 7 statuses: ${locale.languageCode} ×$scale ${variant.name}',
          (t) async {
            for (final s in ReconStatus.values) {
              await t.pumpWidget(
                host(
                  Builder(
                    builder: (c) => StatusCard(
                      status: s,
                      sev: sev[s]!,
                      medName: 'metoprolol succinate ER 50 mg',
                      message: patientMessage(
                        MedL10n.of(c),
                        'OLD_STRENGTH_BOTTLE',
                        const {},
                      ),
                      sourceLine:
                          'metoprolol succinate ER 25 mg tablet — Take 1 tab PO daily',
                      flags: const [SafetyKind.highRisk],
                      onReadAloud: () {},
                      onAddQuestion: () {},
                    ),
                  ),
                  locale: locale,
                  scale: scale,
                  v: variant,
                ),
              );
              expect(t.takeException(), isNull, reason: '${s.name} overflowed');
              // Every status is icon + word: the word is in the semantics label.
              final l = MedL10n.of(t.element(find.byType(StatusCard)));
              expect(find.bySemanticsLabel(RegExp(s.label(l))), findsWidgets);
            }
          },
        );
      }
    }
  }

  testWidgets('buttons meet 48 dp targets and big buttons are 56 dp', (
    t,
  ) async {
    await t.pumpWidget(
      host(
        BigButton(label: 'Looks right', onPressed: () {}),
        locale: const Locale('en'),
      ),
    );
    expect(
      t.getSize(find.byType(FilledButton)).height,
      greaterThanOrEqualTo(56),
    );
    await expectLater(t, meetsGuideline(androidTapTargetGuideline));
    await expectLater(t, meetsGuideline(labeledTapTargetGuideline));
  });

  testWidgets('LASA choice shows both names and Neither', (t) async {
    String? picked = 'x';
    await t.pumpWidget(
      host(
        ChoiceCompare(
          a: 'hydroxyzine',
          b: 'hydralazine',
          rules: ShippedRules.ruleSet,
          onPick: (v) => picked = v,
        ),
        locale: const Locale('en'),
      ),
    );
    expect(find.bySemanticsLabel('hydroxyzine'), findsOneWidget);
    await t.tap(find.text('Neither'));
    expect(picked, isNull);
  });
}
