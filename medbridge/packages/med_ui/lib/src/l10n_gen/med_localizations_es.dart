// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'med_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class MedL10nEs extends MedL10n {
  MedL10nEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'MedBridge';

  @override
  String get tagline => 'Sus medicinas del alta, claras.';

  @override
  String get tabToday => 'Hoy';

  @override
  String get tabScan => 'Escanear';

  @override
  String get tabMyMeds => 'Mis medicinas';

  @override
  String get tabQuestions => 'Preguntas';

  @override
  String get statusKeep => 'Continuar';

  @override
  String get statusChanged => 'Cambió';

  @override
  String get statusStop => 'Dejar';

  @override
  String get statusNew => 'Nueva';

  @override
  String get statusHold => 'Pausar';

  @override
  String get statusDuplicate => 'Duplicada';

  @override
  String get statusUnknown => 'Desconocida';

  @override
  String get sevOk => 'Todo bien';

  @override
  String get sevInfo => 'Para su información';

  @override
  String get sevAmber => 'Revise esto';

  @override
  String get sevRed => 'Requiere atención';

  @override
  String get msgLowConfidence =>
      'No pudimos leer esto bien. Agréguelo a sus preguntas.';

  @override
  String get msgPlanStop =>
      'Su equipo de salud suspendió esta medicina. No la tome. Apártela.';

  @override
  String msgPlanHold(String when) {
    return 'Pause esta medicina hasta $when.';
  }

  @override
  String msgNewDirections(String sig) {
    return 'La misma medicina, nuevas instrucciones: $sig';
  }

  @override
  String get msgOldStrength =>
      'Su dosis cambió. No use este frasco hasta que un farmacéutico lo confirme.';

  @override
  String msgMatch(String sig) {
    return 'Siga tomándola como antes: $sig';
  }

  @override
  String get msgMismatch =>
      'Este frasco no coincide con su plan. Pregunte a su farmacéutico antes de tomarla.';

  @override
  String msgNewMed(String sig) {
    return 'Esta es una medicina nueva: $sig';
  }

  @override
  String get msgNewMedMismatch =>
      'No coincide con la medicina nueva de su plan. Pregunte a su farmacéutico.';

  @override
  String msgDuplicate(String planMed) {
    return 'Puede hacer lo mismo que $planMed. No tome ambas. Pregunte a su equipo de salud.';
  }

  @override
  String get msgNotOnPlan =>
      'No está en su plan de alta. Pregunte antes de tomarla.';

  @override
  String get msgComboPartial =>
      'Este frasco tiene más de una medicina. Pregunte a su farmacéutico antes de tomarla.';

  @override
  String get msgSigUnsupported =>
      'Estas instrucciones son complejas. Pregunte a su farmacéutico cómo tomarla.';

  @override
  String get askPharmacist => 'Pregunte a su farmacéutico';

  @override
  String get fromYourPapers => 'De sus papeles del alta:';

  @override
  String get readAloud => 'Leer en voz alta';

  @override
  String get addToQuestions => 'Agregar a mis preguntas';

  @override
  String get scanNext => 'Escanear otro';

  @override
  String get setAside => 'Ya aparté este frasco';

  @override
  String get emptyToday =>
      'Preparemos sus medicinas. Escanee sus papeles del alta para empezar.';

  @override
  String get scanPapers => 'Escanear papeles del alta';

  @override
  String get scanHint =>
      'Sostenga el frasco dentro del recuadro. Gírelo despacio.';

  @override
  String get lowConfidenceRead =>
      'No pudimos leer esto bien. Intente de nuevo o escríbalo.';

  @override
  String get markedTaken => 'Marcada como tomada.';

  @override
  String get undo => 'Deshacer';

  @override
  String missedPrompt(String time) {
    return 'No ha marcado sus medicinas de las $time. ¿Tomarlas ahora u omitirlas?';
  }

  @override
  String get offline =>
      'Está sin conexión. Todo sigue funcionando en este teléfono.';

  @override
  String get savedOnPhone => 'Guardado en este teléfono';

  @override
  String get stopShort => 'No tome esto. Su equipo de salud la suspendió.';

  @override
  String needsAttention(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count medicinas requieren atención',
      one: '1 medicina requiere atención',
    );
    return '$_temp0';
  }

  @override
  String get review => 'Revisar';

  @override
  String get nextDose => 'Próxima dosis';

  @override
  String get taken => 'Tomada';

  @override
  String get skip => 'Omitir';

  @override
  String get skipped => 'Omitida';

  @override
  String takenOfTotal(int taken, int total) {
    return '$taken de $total tomadas hoy';
  }

  @override
  String get slotMorning => 'Mañana';

  @override
  String get slotNoon => 'Mediodía';

  @override
  String get slotAfternoon => 'Tarde';

  @override
  String get slotEvening => 'Noche';

  @override
  String get slotBedtime => 'Al acostarse';

  @override
  String asNeededMax(int n) {
    return 'Si es necesario, no más de $n al día';
  }

  @override
  String get asNeeded => 'Si es necesario';

  @override
  String get reviewPlan => 'Revise su plan';

  @override
  String get looksRight => 'Está bien';

  @override
  String get checkThis => 'Revise esto';

  @override
  String get linesWeCouldntRead => 'Líneas que no pudimos leer';

  @override
  String get chipNew => 'Nuevas';

  @override
  String get chipChanged => 'Cambiadas';

  @override
  String get chipKeep => 'Siga tomando';

  @override
  String get chipPaused => 'En pausa';

  @override
  String get chipStopped => 'Suspendidas';

  @override
  String get isThisYourMedicine => '¿Es esta su medicina?';

  @override
  String get yes => 'Sí';

  @override
  String get notThisOne => 'No es esta';

  @override
  String get whichOne => '¿Cuál medicina es esta?';

  @override
  String get neither => 'Ninguna';

  @override
  String get typeItInstead => 'Escribirlo';

  @override
  String bottlesChecked(int checked, int total) {
    return '$checked de $total frascos revisados';
  }

  @override
  String get scanned => 'Escaneado ✓';

  @override
  String get notScannedYet => 'Aún no escaneado';

  @override
  String get pickUpFromPharmacy => 'Recoger en la farmacia';

  @override
  String get addedForYou => 'Agregada para usted';

  @override
  String get addQuestion => 'Agregar una pregunta';

  @override
  String get shareWithDoctor => 'Compartir con mi médico';

  @override
  String get answered => 'Respondida';

  @override
  String get waitingForAnswer => 'Esperando respuesta';

  @override
  String get careTeam => 'Equipo de salud';

  @override
  String get invite => 'Invitar';

  @override
  String get remove => 'Quitar';

  @override
  String inviteCodeIs(String code) {
    return 'Comparta este código: $code';
  }

  @override
  String get enterInviteCode => 'Escriba un código de invitación';

  @override
  String viewingMeds(String name) {
    return 'Viendo las medicinas de $name';
  }

  @override
  String get settings => 'Ajustes';

  @override
  String get textSize => 'Tamaño del texto';

  @override
  String get language => 'Idioma';

  @override
  String get speechRate => 'Velocidad de lectura';

  @override
  String get theme => 'Tema';

  @override
  String get themeLight => 'Claro';

  @override
  String get themeDark => 'Oscuro';

  @override
  String get themeHighContrast => 'Alto contraste';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String stepOf(int step, int total) {
    return 'Paso $step de $total';
  }

  @override
  String get chooseLanguage => 'Elija su idioma';

  @override
  String get whoAreYou => '¿Quién usa MedBridge?';

  @override
  String get rolePatient => 'Soy el paciente';

  @override
  String get roleCaregiver => 'Ayudo a alguien';

  @override
  String get yourFirstName => 'Su nombre';

  @override
  String get textSizePreview => 'Así se verá el texto.';

  @override
  String get cameraPrimer =>
      'Usamos la cámara solo para leer etiquetas. Nunca guardamos fotos.';

  @override
  String get notificationPrimer =>
      'Le recordaremos cuando sea hora de sus medicinas. Los recordatorios no muestran nombres de medicinas a menos que usted lo elija.';

  @override
  String get allergiesOptional => '¿Alguna alergia? (opcional)';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get back => 'Atrás';

  @override
  String get done => 'Listo';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get tryAgain => 'Intentar de nuevo';

  @override
  String get addPage => 'Agregar página';

  @override
  String pages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
    );
    return '$_temp0';
  }

  @override
  String get pasteOrType => 'Escriba o pegue el texto de sus papeles';

  @override
  String get useSampleR => 'Usar los papeles de ejemplo (R. Doe)';

  @override
  String get pendingTranslatorReview =>
      'El texto en español es un borrador pendiente de revisión por un traductor médico.';

  @override
  String get verified => 'Revisado por un farmacéutico';

  @override
  String get unverified => 'Aún no revisado por un farmacéutico';

  @override
  String get errorGeneric =>
      'Algo salió mal. Su plan sigue funcionando en este teléfono.';

  @override
  String get noInternet =>
      'Sin internet. Su plan sigue funcionando en este teléfono.';

  @override
  String get highRiskBadge => 'Medicina de alto riesgo';

  @override
  String interactionBanner(String detail) {
    return 'Puede interactuar con otra medicina: $detail';
  }

  @override
  String get allergyBlock =>
      'Alerta de alergia. No la tome hasta que su equipo de salud diga que es seguro.';

  @override
  String get lasaBadge => 'El nombre se parece al de otra medicina';

  @override
  String get writeStopOnCap => 'Consejo: escriba ALTO en la tapa.';

  @override
  String get untilFollowUp => 'su próxima cita';

  @override
  String get dashPatients => 'Pacientes';

  @override
  String get dashFlags => 'Escaneos marcados';

  @override
  String get dashInbox => 'Preguntas';

  @override
  String get dashVerify => 'Verificar plan';

  @override
  String get dashSummary => 'Resumen';

  @override
  String redCount(int n) {
    return '$n rojo';
  }

  @override
  String amberCount(int n) {
    return '$n ámbar';
  }

  @override
  String get answer => 'Responder';

  @override
  String get verify => 'Verificar';

  @override
  String get resolve => 'Marcar revisado';

  @override
  String get density => 'Filas compactas';

  @override
  String get sessionExpired => 'Sesión cerrada tras 15 minutos de inactividad.';
}
