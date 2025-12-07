import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @materialAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Study Without Pen!'**
  String get materialAppTitle;

  /// No description provided for @nonso_register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get nonso_register;

  /// No description provided for @nonso_signInUp.
  ///
  /// In en, this message translates to:
  /// **'Sign In/Up'**
  String get nonso_signInUp;

  /// No description provided for @nonso_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get nonso_email;

  /// No description provided for @nonso_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nonso_next;

  /// No description provided for @nonso_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get nonso_cancel;

  /// No description provided for @nonso_invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'This an invalid email'**
  String get nonso_invalidEmail;

  /// No description provided for @nonso_refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh account'**
  String get nonso_refresh;

  /// No description provided for @nonso_verifyEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Check your email inbox to verify your email address'**
  String get nonso_verifyEmailAddress;

  /// No description provided for @nonso_signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get nonso_signOut;

  /// No description provided for @nonso_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get nonso_signIn;

  /// No description provided for @nonso_resendVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend verification email'**
  String get nonso_resendVerificationEmail;

  /// No description provided for @nonso_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nonso_name;

  /// No description provided for @nonso_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get nonso_password;

  /// No description provided for @nonso_confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get nonso_confirmPassword;

  /// No description provided for @nonso_forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get nonso_forgotPassword;

  /// No description provided for @nonso_resetCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Check your email inbox to reset your password'**
  String get nonso_resetCodeSent;

  /// No description provided for @nonso_nameValidationError.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nonso_nameValidationError;

  /// No description provided for @nonso_failed.
  ///
  /// In en, this message translates to:
  /// **'Failure: {exceptionCode}'**
  String nonso_failed(String exceptionCode);

  /// No description provided for @nonso_success.
  ///
  /// In en, this message translates to:
  /// **'Success: Check your email inbox to verify your email address.'**
  String get nonso_success;

  /// No description provided for @nonso_passwordValidationError.
  ///
  /// In en, this message translates to:
  /// **'Password needs to be at least {passwordMinimumLength} characters'**
  String nonso_passwordValidationError(int passwordMinimumLength);

  /// No description provided for @nonso_confirmPasswordValidationError.
  ///
  /// In en, this message translates to:
  /// **'This doesn\'t match the given password'**
  String get nonso_confirmPasswordValidationError;

  /// No description provided for @createField.
  ///
  /// In en, this message translates to:
  /// **'Create Field'**
  String get createField;

  /// No description provided for @createFieldList.
  ///
  /// In en, this message translates to:
  /// **'Create Field List'**
  String get createFieldList;

  /// No description provided for @fieldName.
  ///
  /// In en, this message translates to:
  /// **'Field Name'**
  String get fieldName;

  /// No description provided for @fieldListName.
  ///
  /// In en, this message translates to:
  /// **'Field List Name'**
  String get fieldListName;

  /// No description provided for @selectColor.
  ///
  /// In en, this message translates to:
  /// **'Select Color'**
  String get selectColor;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fieldNameValidationError.
  ///
  /// In en, this message translates to:
  /// **'Field name must be between {fieldNameMinimumLength} and {fieldNameMaximumLength} characters'**
  String fieldNameValidationError(
    int fieldNameMinimumLength,
    int fieldNameMaximumLength,
  );

  /// No description provided for @fieldListNameValidationError.
  ///
  /// In en, this message translates to:
  /// **'Field list name must be between {fieldListNameMinimumLength} and {fieldListNameMaximumLength} characters'**
  String fieldListNameValidationError(
    int fieldListNameMinimumLength,
    int fieldListNameMaximumLength,
  );

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @creationError.
  ///
  /// In en, this message translates to:
  /// **'Error while creation'**
  String get creationError;

  /// No description provided for @noFields.
  ///
  /// In en, this message translates to:
  /// **'Currently, there are no fields!'**
  String get noFields;

  /// No description provided for @failureLoadingFields.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading the fields!'**
  String get failureLoadingFields;

  /// No description provided for @failureLoadingData.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while loading the data!'**
  String get failureLoadingData;

  /// No description provided for @noFieldLists.
  ///
  /// In en, this message translates to:
  /// **'Currently, there are no lists!'**
  String get noFieldLists;

  /// No description provided for @selectCheckType.
  ///
  /// In en, this message translates to:
  /// **'Select check type'**
  String get selectCheckType;

  /// No description provided for @howAppCheckAnswers.
  ///
  /// In en, this message translates to:
  /// **'How app checks your answers'**
  String get howAppCheckAnswers;

  /// No description provided for @nonStrictIgnoreCase.
  ///
  /// In en, this message translates to:
  /// **'Do not check letter case or space'**
  String get nonStrictIgnoreCase;

  /// No description provided for @ignoreCase.
  ///
  /// In en, this message translates to:
  /// **'Do not check letter case'**
  String get ignoreCase;

  /// No description provided for @nonStrictDoNotIgnoreCase.
  ///
  /// In en, this message translates to:
  /// **'Do not check space'**
  String get nonStrictDoNotIgnoreCase;

  /// No description provided for @doNotIgnoreCase.
  ///
  /// In en, this message translates to:
  /// **'Check both letter case and space'**
  String get doNotIgnoreCase;

  /// No description provided for @readAnswer.
  ///
  /// In en, this message translates to:
  /// **'Read answer'**
  String get readAnswer;

  /// No description provided for @whenAnsweredCorrectly.
  ///
  /// In en, this message translates to:
  /// **'When you answer correctly!'**
  String get whenAnsweredCorrectly;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
