import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'med_localizations_en.dart';
import 'med_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of MedL10n
/// returned by `MedL10n.of(context)`.
///
/// Applications need to include `MedL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n_gen/med_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: MedL10n.localizationsDelegates,
///   supportedLocales: MedL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the MedL10n.supportedLocales
/// property.
abstract class MedL10n {
  MedL10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static MedL10n of(BuildContext context) {
    return Localizations.of<MedL10n>(context, MedL10n)!;
  }

  static const LocalizationsDelegate<MedL10n> delegate = _MedL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'MedBridge'**
  String get appName;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Discharge meds, made clear.'**
  String get tagline;

  /// No description provided for @tabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabToday;

  /// No description provided for @tabScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get tabScan;

  /// No description provided for @tabMyMeds.
  ///
  /// In en, this message translates to:
  /// **'My meds'**
  String get tabMyMeds;

  /// No description provided for @tabQuestions.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get tabQuestions;

  /// No description provided for @statusKeep.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get statusKeep;

  /// No description provided for @statusChanged.
  ///
  /// In en, this message translates to:
  /// **'Changed'**
  String get statusChanged;

  /// No description provided for @statusStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get statusStop;

  /// No description provided for @statusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get statusNew;

  /// No description provided for @statusHold.
  ///
  /// In en, this message translates to:
  /// **'Hold'**
  String get statusHold;

  /// No description provided for @statusDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get statusDuplicate;

  /// No description provided for @statusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get statusUnknown;

  /// No description provided for @sevOk.
  ///
  /// In en, this message translates to:
  /// **'All good'**
  String get sevOk;

  /// No description provided for @sevInfo.
  ///
  /// In en, this message translates to:
  /// **'For your information'**
  String get sevInfo;

  /// No description provided for @sevAmber.
  ///
  /// In en, this message translates to:
  /// **'Check this'**
  String get sevAmber;

  /// No description provided for @sevRed.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get sevRed;

  /// No description provided for @msgLowConfidence.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read this clearly. Add it to your questions.'**
  String get msgLowConfidence;

  /// No description provided for @msgPlanStop.
  ///
  /// In en, this message translates to:
  /// **'Your care team stopped this medicine. Don\'t take it. Set it aside.'**
  String get msgPlanStop;

  /// No description provided for @msgPlanHold.
  ///
  /// In en, this message translates to:
  /// **'Pause this medicine until {when}.'**
  String msgPlanHold(String when);

  /// No description provided for @msgNewDirections.
  ///
  /// In en, this message translates to:
  /// **'Same medicine, new directions: {sig}'**
  String msgNewDirections(String sig);

  /// No description provided for @msgOldStrength.
  ///
  /// In en, this message translates to:
  /// **'Your dose changed. Don\'t use this bottle until a pharmacist confirms.'**
  String get msgOldStrength;

  /// No description provided for @msgMatch.
  ///
  /// In en, this message translates to:
  /// **'Keep taking this as before: {sig}'**
  String msgMatch(String sig);

  /// No description provided for @msgMismatch.
  ///
  /// In en, this message translates to:
  /// **'This bottle doesn\'t match your plan. Ask your pharmacist before taking.'**
  String get msgMismatch;

  /// No description provided for @msgNewMed.
  ///
  /// In en, this message translates to:
  /// **'This is a new medicine: {sig}'**
  String msgNewMed(String sig);

  /// No description provided for @msgNewMedMismatch.
  ///
  /// In en, this message translates to:
  /// **'This doesn\'t match the new medicine on your plan. Ask your pharmacist.'**
  String get msgNewMedMismatch;

  /// No description provided for @msgDuplicate.
  ///
  /// In en, this message translates to:
  /// **'This may do the same job as {planMed}. Don\'t take both. Ask your care team.'**
  String msgDuplicate(String planMed);

  /// No description provided for @msgNotOnPlan.
  ///
  /// In en, this message translates to:
  /// **'This isn\'t on your discharge plan. Ask before taking it.'**
  String get msgNotOnPlan;

  /// No description provided for @msgComboPartial.
  ///
  /// In en, this message translates to:
  /// **'This bottle has more than one medicine. Ask your pharmacist before taking.'**
  String get msgComboPartial;

  /// No description provided for @msgSigUnsupported.
  ///
  /// In en, this message translates to:
  /// **'These directions are complex. Ask your pharmacist how to take it.'**
  String get msgSigUnsupported;

  /// No description provided for @askPharmacist.
  ///
  /// In en, this message translates to:
  /// **'Ask your pharmacist'**
  String get askPharmacist;

  /// No description provided for @fromYourPapers.
  ///
  /// In en, this message translates to:
  /// **'From your discharge papers:'**
  String get fromYourPapers;

  /// No description provided for @readAloud.
  ///
  /// In en, this message translates to:
  /// **'Read aloud'**
  String get readAloud;

  /// No description provided for @addToQuestions.
  ///
  /// In en, this message translates to:
  /// **'Add to my questions'**
  String get addToQuestions;

  /// No description provided for @scanNext.
  ///
  /// In en, this message translates to:
  /// **'Scan next'**
  String get scanNext;

  /// No description provided for @setAside.
  ///
  /// In en, this message translates to:
  /// **'I\'ve set this bottle aside'**
  String get setAside;

  /// No description provided for @emptyToday.
  ///
  /// In en, this message translates to:
  /// **'Let\'s set up your medicines. Scan your discharge papers to start.'**
  String get emptyToday;

  /// No description provided for @scanPapers.
  ///
  /// In en, this message translates to:
  /// **'Scan discharge papers'**
  String get scanPapers;

  /// No description provided for @scanHint.
  ///
  /// In en, this message translates to:
  /// **'Hold the bottle in the box. Turn it slowly.'**
  String get scanHint;

  /// No description provided for @lowConfidenceRead.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'t read this clearly. Try again, or type it in.'**
  String get lowConfidenceRead;

  /// No description provided for @markedTaken.
  ///
  /// In en, this message translates to:
  /// **'Marked as taken.'**
  String get markedTaken;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @missedPrompt.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t marked your {time} medicines. Take them now, or skip?'**
  String missedPrompt(String time);

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'You\'re offline. Everything still works on this phone.'**
  String get offline;

  /// No description provided for @savedOnPhone.
  ///
  /// In en, this message translates to:
  /// **'Saved on this phone'**
  String get savedOnPhone;

  /// No description provided for @stopShort.
  ///
  /// In en, this message translates to:
  /// **'Don\'t take this. Your care team stopped it.'**
  String get stopShort;

  /// No description provided for @needsAttention.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 medicine needs attention} other{{count} medicines need attention}}'**
  String needsAttention(int count);

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @nextDose.
  ///
  /// In en, this message translates to:
  /// **'Next dose'**
  String get nextDose;

  /// No description provided for @taken.
  ///
  /// In en, this message translates to:
  /// **'Taken'**
  String get taken;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @skipped.
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get skipped;

  /// No description provided for @takenOfTotal.
  ///
  /// In en, this message translates to:
  /// **'{taken} of {total} taken today'**
  String takenOfTotal(int taken, int total);

  /// No description provided for @slotMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get slotMorning;

  /// No description provided for @slotNoon.
  ///
  /// In en, this message translates to:
  /// **'Noon'**
  String get slotNoon;

  /// No description provided for @slotAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Afternoon'**
  String get slotAfternoon;

  /// No description provided for @slotEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get slotEvening;

  /// No description provided for @slotBedtime.
  ///
  /// In en, this message translates to:
  /// **'Bedtime'**
  String get slotBedtime;

  /// No description provided for @asNeededMax.
  ///
  /// In en, this message translates to:
  /// **'As needed, no more than {n} a day'**
  String asNeededMax(int n);

  /// No description provided for @asNeeded.
  ///
  /// In en, this message translates to:
  /// **'As needed'**
  String get asNeeded;

  /// No description provided for @reviewPlan.
  ///
  /// In en, this message translates to:
  /// **'Review your plan'**
  String get reviewPlan;

  /// No description provided for @looksRight.
  ///
  /// In en, this message translates to:
  /// **'Looks right'**
  String get looksRight;

  /// No description provided for @checkThis.
  ///
  /// In en, this message translates to:
  /// **'Check this'**
  String get checkThis;

  /// No description provided for @linesWeCouldntRead.
  ///
  /// In en, this message translates to:
  /// **'Lines we couldn\'t read'**
  String get linesWeCouldntRead;

  /// No description provided for @chipNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get chipNew;

  /// No description provided for @chipChanged.
  ///
  /// In en, this message translates to:
  /// **'Changed'**
  String get chipChanged;

  /// No description provided for @chipKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep taking'**
  String get chipKeep;

  /// No description provided for @chipPaused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get chipPaused;

  /// No description provided for @chipStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get chipStopped;

  /// No description provided for @isThisYourMedicine.
  ///
  /// In en, this message translates to:
  /// **'Is this your medicine?'**
  String get isThisYourMedicine;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @notThisOne.
  ///
  /// In en, this message translates to:
  /// **'Not this one'**
  String get notThisOne;

  /// No description provided for @whichOne.
  ///
  /// In en, this message translates to:
  /// **'Which medicine is this?'**
  String get whichOne;

  /// No description provided for @neither.
  ///
  /// In en, this message translates to:
  /// **'Neither'**
  String get neither;

  /// No description provided for @typeItInstead.
  ///
  /// In en, this message translates to:
  /// **'Type it instead'**
  String get typeItInstead;

  /// No description provided for @bottlesChecked.
  ///
  /// In en, this message translates to:
  /// **'{checked} of {total} bottles checked'**
  String bottlesChecked(int checked, int total);

  /// No description provided for @scanned.
  ///
  /// In en, this message translates to:
  /// **'Scanned ✓'**
  String get scanned;

  /// No description provided for @notScannedYet.
  ///
  /// In en, this message translates to:
  /// **'Not scanned yet'**
  String get notScannedYet;

  /// No description provided for @pickUpFromPharmacy.
  ///
  /// In en, this message translates to:
  /// **'Pick up from pharmacy'**
  String get pickUpFromPharmacy;

  /// No description provided for @addedForYou.
  ///
  /// In en, this message translates to:
  /// **'Added for you'**
  String get addedForYou;

  /// No description provided for @addQuestion.
  ///
  /// In en, this message translates to:
  /// **'Add a question'**
  String get addQuestion;

  /// No description provided for @shareWithDoctor.
  ///
  /// In en, this message translates to:
  /// **'Share with my doctor'**
  String get shareWithDoctor;

  /// No description provided for @answered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get answered;

  /// No description provided for @waitingForAnswer.
  ///
  /// In en, this message translates to:
  /// **'Waiting for an answer'**
  String get waitingForAnswer;

  /// No description provided for @careTeam.
  ///
  /// In en, this message translates to:
  /// **'Care team'**
  String get careTeam;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @inviteCodeIs.
  ///
  /// In en, this message translates to:
  /// **'Share this code: {code}'**
  String inviteCodeIs(String code);

  /// No description provided for @enterInviteCode.
  ///
  /// In en, this message translates to:
  /// **'Enter an invite code'**
  String get enterInviteCode;

  /// No description provided for @viewingMeds.
  ///
  /// In en, this message translates to:
  /// **'Viewing {name}\'s medicines'**
  String viewingMeds(String name);

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @textSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get textSize;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @speechRate.
  ///
  /// In en, this message translates to:
  /// **'Read-aloud speed'**
  String get speechRate;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeHighContrast.
  ///
  /// In en, this message translates to:
  /// **'High contrast'**
  String get themeHighContrast;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get signIn;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String stepOf(int step, int total);

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose your language'**
  String get chooseLanguage;

  /// No description provided for @whoAreYou.
  ///
  /// In en, this message translates to:
  /// **'Who is using MedBridge?'**
  String get whoAreYou;

  /// No description provided for @rolePatient.
  ///
  /// In en, this message translates to:
  /// **'I\'m the patient'**
  String get rolePatient;

  /// No description provided for @roleCaregiver.
  ///
  /// In en, this message translates to:
  /// **'I help someone'**
  String get roleCaregiver;

  /// No description provided for @yourFirstName.
  ///
  /// In en, this message translates to:
  /// **'Your first name'**
  String get yourFirstName;

  /// No description provided for @textSizePreview.
  ///
  /// In en, this message translates to:
  /// **'This is how text will look.'**
  String get textSizePreview;

  /// No description provided for @cameraPrimer.
  ///
  /// In en, this message translates to:
  /// **'We use the camera only to read labels. Photos are never saved.'**
  String get cameraPrimer;

  /// No description provided for @notificationPrimer.
  ///
  /// In en, this message translates to:
  /// **'We\'ll remind you when it\'s time for your medicines. Reminders never show medicine names unless you choose.'**
  String get notificationPrimer;

  /// No description provided for @allergiesOptional.
  ///
  /// In en, this message translates to:
  /// **'Any allergies? (optional)'**
  String get allergiesOptional;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// No description provided for @addPage.
  ///
  /// In en, this message translates to:
  /// **'Add page'**
  String get addPage;

  /// No description provided for @pages.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page} other{{count} pages}}'**
  String pages(int count);

  /// No description provided for @pasteOrType.
  ///
  /// In en, this message translates to:
  /// **'Type or paste the text from your papers'**
  String get pasteOrType;

  /// No description provided for @useSampleR.
  ///
  /// In en, this message translates to:
  /// **'Use the sample papers (R. Doe)'**
  String get useSampleR;

  /// No description provided for @pendingTranslatorReview.
  ///
  /// In en, this message translates to:
  /// **'Spanish text is a draft pending medical-translator review.'**
  String get pendingTranslatorReview;

  /// No description provided for @verified.
  ///
  /// In en, this message translates to:
  /// **'Checked by a pharmacist'**
  String get verified;

  /// No description provided for @unverified.
  ///
  /// In en, this message translates to:
  /// **'Not yet checked by a pharmacist'**
  String get unverified;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Your plan still works on this phone.'**
  String get errorGeneric;

  /// No description provided for @noInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet. Your plan still works on this phone.'**
  String get noInternet;

  /// No description provided for @highRiskBadge.
  ///
  /// In en, this message translates to:
  /// **'High-alert medicine'**
  String get highRiskBadge;

  /// No description provided for @interactionBanner.
  ///
  /// In en, this message translates to:
  /// **'May interact with another medicine: {detail}'**
  String interactionBanner(String detail);

  /// No description provided for @allergyBlock.
  ///
  /// In en, this message translates to:
  /// **'Allergy alert. Don\'t take this until your care team says it\'s safe.'**
  String get allergyBlock;

  /// No description provided for @lasaBadge.
  ///
  /// In en, this message translates to:
  /// **'Name looks like another medicine'**
  String get lasaBadge;

  /// No description provided for @writeStopOnCap.
  ///
  /// In en, this message translates to:
  /// **'Tip: write STOP on the cap.'**
  String get writeStopOnCap;

  /// No description provided for @untilFollowUp.
  ///
  /// In en, this message translates to:
  /// **'your follow-up visit'**
  String get untilFollowUp;

  /// No description provided for @dashPatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get dashPatients;

  /// No description provided for @dashFlags.
  ///
  /// In en, this message translates to:
  /// **'Flagged scans'**
  String get dashFlags;

  /// No description provided for @dashInbox.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get dashInbox;

  /// No description provided for @dashVerify.
  ///
  /// In en, this message translates to:
  /// **'Verify plan'**
  String get dashVerify;

  /// No description provided for @dashSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get dashSummary;

  /// No description provided for @redCount.
  ///
  /// In en, this message translates to:
  /// **'{n} red'**
  String redCount(int n);

  /// No description provided for @amberCount.
  ///
  /// In en, this message translates to:
  /// **'{n} amber'**
  String amberCount(int n);

  /// No description provided for @answer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answer;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @resolve.
  ///
  /// In en, this message translates to:
  /// **'Mark reviewed'**
  String get resolve;

  /// No description provided for @density.
  ///
  /// In en, this message translates to:
  /// **'Compact rows'**
  String get density;

  /// No description provided for @sessionExpired.
  ///
  /// In en, this message translates to:
  /// **'Signed out after 15 minutes idle.'**
  String get sessionExpired;
}

class _MedL10nDelegate extends LocalizationsDelegate<MedL10n> {
  const _MedL10nDelegate();

  @override
  Future<MedL10n> load(Locale locale) {
    return SynchronousFuture<MedL10n>(lookupMedL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_MedL10nDelegate old) => false;
}

MedL10n lookupMedL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return MedL10nEn();
    case 'es':
      return MedL10nEs();
  }

  throw FlutterError(
    'MedL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
