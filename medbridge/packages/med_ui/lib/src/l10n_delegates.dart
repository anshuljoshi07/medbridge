import 'package:material_ui/material_ui.dart';
import 'package:med_ui/src/l10n_gen/med_localizations.dart';

/// Every localization delegate a MedBridge app needs (EN / ES).
const List<LocalizationsDelegate<Object?>> medLocalizationsDelegates = [
  MedL10n.delegate,
  ...GlobalMaterialLocalizations.delegates,
];
