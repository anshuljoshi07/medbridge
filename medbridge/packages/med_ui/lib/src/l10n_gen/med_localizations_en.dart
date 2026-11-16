// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'med_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class MedL10nEn extends MedL10n {
  MedL10nEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MedBridge';

  @override
  String get tagline => 'Discharge meds, made clear.';

  @override
  String get tabToday => 'Today';

  @override
  String get tabScan => 'Scan';

  @override
  String get tabMyMeds => 'My meds';

  @override
  String get tabQuestions => 'Questions';

  @override
  String get statusKeep => 'Continue';

  @override
  String get statusChanged => 'Changed';

  @override
  String get statusStop => 'Stop';

  @override
  String get statusNew => 'New';

  @override
  String get statusHold => 'Hold';

  @override
  String get statusDuplicate => 'Duplicate';

  @override
  String get statusUnknown => 'Unknown';

  @override
  String get sevOk => 'All good';

  @override
  String get sevInfo => 'For your information';

  @override
  String get sevAmber => 'Check this';

  @override
  String get sevRed => 'Needs attention';

  @override
  String get msgLowConfidence =>
      'We couldn\'t read this clearly. Add it to your questions.';

  @override
  String get msgPlanStop =>
      'Your care team stopped this medicine. Don\'t take it. Set it aside.';

  @override
  String msgPlanHold(String when) {
    return 'Pause this medicine until $when.';
  }

  @override
  String msgNewDirections(String sig) {
    return 'Same medicine, new directions: $sig';
  }

  @override
  String get msgOldStrength =>
      'Your dose changed. Don\'t use this bottle until a pharmacist confirms.';

  @override
  String msgMatch(String sig) {
    return 'Keep taking this as before: $sig';
  }

  @override
  String get msgMismatch =>
      'This bottle doesn\'t match your plan. Ask your pharmacist before taking.';

  @override
  String msgNewMed(String sig) {
    return 'This is a new medicine: $sig';
  }

  @override
  String get msgNewMedMismatch =>
      'This doesn\'t match the new medicine on your plan. Ask your pharmacist.';

  @override
  String msgDuplicate(String planMed) {
    return 'This may do the same job as $planMed. Don\'t take both. Ask your care team.';
  }

  @override
  String get msgNotOnPlan =>
      'This isn\'t on your discharge plan. Ask before taking it.';

  @override
  String get msgComboPartial =>
      'This bottle has more than one medicine. Ask your pharmacist before taking.';

  @override
  String get msgSigUnsupported =>
      'These directions are complex. Ask your pharmacist how to take it.';

  @override
  String get askPharmacist => 'Ask your pharmacist';

  @override
  String get fromYourPapers => 'From your discharge papers:';

  @override
  String get readAloud => 'Read aloud';

  @override
  String get addToQuestions => 'Add to my questions';

  @override
  String get scanNext => 'Scan next';

  @override
  String get setAside => 'I\'ve set this bottle aside';

  @override
  String get emptyToday =>
      'Let\'s set up your medicines. Scan your discharge papers to start.';

  @override
  String get scanPapers => 'Scan discharge papers';

  @override
  String get scanHint => 'Hold the bottle in the box. Turn it slowly.';

  @override
  String get lowConfidenceRead =>
      'We couldn\'t read this clearly. Try again, or type it in.';

  @override
  String get markedTaken => 'Marked as taken.';

  @override
  String get undo => 'Undo';

  @override
  String missedPrompt(String time) {
    return 'You haven\'t marked your $time medicines. Take them now, or skip?';
  }

  @override
  String get offline =>
      'You\'re offline. Everything still works on this phone.';

  @override
  String get savedOnPhone => 'Saved on this phone';

  @override
  String get stopShort => 'Don\'t take this. Your care team stopped it.';

  @override
  String needsAttention(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count medicines need attention',
      one: '1 medicine needs attention',
    );
    return '$_temp0';
  }

  @override
  String get review => 'Review';

  @override
  String get nextDose => 'Next dose';

  @override
  String get taken => 'Taken';

  @override
  String get skip => 'Skip';

  @override
  String get skipped => 'Skipped';

  @override
  String takenOfTotal(int taken, int total) {
    return '$taken of $total taken today';
  }

  @override
  String get slotMorning => 'Morning';

  @override
  String get slotNoon => 'Noon';

  @override
  String get slotAfternoon => 'Afternoon';

  @override
  String get slotEvening => 'Evening';

  @override
  String get slotBedtime => 'Bedtime';

  @override
  String asNeededMax(int n) {
    return 'As needed, no more than $n a day';
  }

  @override
  String get asNeeded => 'As needed';

  @override
  String get reviewPlan => 'Review your plan';

  @override
  String get looksRight => 'Looks right';

  @override
  String get checkThis => 'Check this';

  @override
  String get linesWeCouldntRead => 'Lines we couldn\'t read';

  @override
  String get chipNew => 'New';

  @override
  String get chipChanged => 'Changed';

  @override
  String get chipKeep => 'Keep taking';

  @override
  String get chipPaused => 'Paused';

  @override
  String get chipStopped => 'Stopped';

  @override
  String get isThisYourMedicine => 'Is this your medicine?';

  @override
  String get yes => 'Yes';

  @override
  String get notThisOne => 'Not this one';

  @override
  String get whichOne => 'Which medicine is this?';

  @override
  String get neither => 'Neither';

  @override
  String get typeItInstead => 'Type it instead';

  @override
  String bottlesChecked(int checked, int total) {
    return '$checked of $total bottles checked';
  }

  @override
  String get scanned => 'Scanned ✓';

  @override
  String get notScannedYet => 'Not scanned yet';

  @override
  String get pickUpFromPharmacy => 'Pick up from pharmacy';

  @override
  String get addedForYou => 'Added for you';

  @override
  String get addQuestion => 'Add a question';

  @override
  String get shareWithDoctor => 'Share with my doctor';

  @override
  String get answered => 'Answered';

  @override
  String get waitingForAnswer => 'Waiting for an answer';

  @override
  String get careTeam => 'Care team';

  @override
  String get invite => 'Invite';

  @override
  String get remove => 'Remove';

  @override
  String inviteCodeIs(String code) {
    return 'Share this code: $code';
  }

  @override
  String get enterInviteCode => 'Enter an invite code';

  @override
  String viewingMeds(String name) {
    return 'Viewing $name\'s medicines';
  }

  @override
  String get settings => 'Settings';

  @override
  String get textSize => 'Text size';

  @override
  String get language => 'Language';

  @override
  String get speechRate => 'Read-aloud speed';

  @override
  String get theme => 'Theme';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeHighContrast => 'High contrast';

  @override
  String get signOut => 'Sign out';

  @override
  String get signIn => 'Sign in';

  @override
  String stepOf(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get whoAreYou => 'Who is using MedBridge?';

  @override
  String get rolePatient => 'I\'m the patient';

  @override
  String get roleCaregiver => 'I help someone';

  @override
  String get yourFirstName => 'Your first name';

  @override
  String get textSizePreview => 'This is how text will look.';

  @override
  String get cameraPrimer =>
      'We use the camera only to read labels. Photos are never saved.';

  @override
  String get notificationPrimer =>
      'We\'ll remind you when it\'s time for your medicines. Reminders never show medicine names unless you choose.';

  @override
  String get allergiesOptional => 'Any allergies? (optional)';

  @override
  String get continueLabel => 'Continue';

  @override
  String get back => 'Back';

  @override
  String get done => 'Done';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get tryAgain => 'Try again';

  @override
  String get addPage => 'Add page';

  @override
  String pages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
    );
    return '$_temp0';
  }

  @override
  String get pasteOrType => 'Type or paste the text from your papers';

  @override
  String get useSampleR => 'Use the sample papers (R. Doe)';

  @override
  String get pendingTranslatorReview =>
      'Spanish text is a draft pending medical-translator review.';

  @override
  String get verified => 'Checked by a pharmacist';

  @override
  String get unverified => 'Not yet checked by a pharmacist';

  @override
  String get errorGeneric =>
      'Something went wrong. Your plan still works on this phone.';

  @override
  String get noInternet => 'No internet. Your plan still works on this phone.';

  @override
  String get highRiskBadge => 'High-alert medicine';

  @override
  String interactionBanner(String detail) {
    return 'May interact with another medicine: $detail';
  }

  @override
  String get allergyBlock =>
      'Allergy alert. Don\'t take this until your care team says it\'s safe.';

  @override
  String get lasaBadge => 'Name looks like another medicine';

  @override
  String get writeStopOnCap => 'Tip: write STOP on the cap.';

  @override
  String get untilFollowUp => 'your follow-up visit';

  @override
  String get dashPatients => 'Patients';

  @override
  String get dashFlags => 'Flagged scans';

  @override
  String get dashInbox => 'Questions';

  @override
  String get dashVerify => 'Verify plan';

  @override
  String get dashSummary => 'Summary';

  @override
  String redCount(int n) {
    return '$n red';
  }

  @override
  String amberCount(int n) {
    return '$n amber';
  }

  @override
  String get answer => 'Answer';

  @override
  String get verify => 'Verify';

  @override
  String get resolve => 'Mark reviewed';

  @override
  String get density => 'Compact rows';

  @override
  String get sessionExpired => 'Signed out after 15 minutes idle.';
}
