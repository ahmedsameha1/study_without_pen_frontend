// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get materialAppTitle => 'Study Without Pen!';

  @override
  String get nonso_register => 'Register';

  @override
  String get nonso_signInUp => 'Sign In/Up';

  @override
  String get nonso_email => 'Email';

  @override
  String get nonso_next => 'Next';

  @override
  String get nonso_cancel => 'Cancel';

  @override
  String get nonso_invalidEmail => 'This an invalid email';

  @override
  String get nonso_refresh => 'Refresh account';

  @override
  String get nonso_verifyEmailAddress =>
      'Check your email inbox to verify your email address';

  @override
  String get nonso_signOut => 'Sign out';

  @override
  String get nonso_signIn => 'Sign in';

  @override
  String get nonso_resendVerificationEmail => 'Resend verification email';

  @override
  String get nonso_name => 'Name';

  @override
  String get nonso_password => 'Password';

  @override
  String get nonso_confirmPassword => 'Confirm Password';

  @override
  String get nonso_forgotPassword => 'Forgot password?';

  @override
  String get nonso_resetCodeSent =>
      'Check your email inbox to reset your password';

  @override
  String get nonso_nameValidationError => 'Enter your name';

  @override
  String nonso_failed(String exceptionCode) {
    return 'Failure: $exceptionCode';
  }

  @override
  String get nonso_success =>
      'Success: Check your email inbox to verify your email address.';

  @override
  String nonso_passwordValidationError(int passwordMinimumLength) {
    return 'Password needs to be at least $passwordMinimumLength characters';
  }

  @override
  String get nonso_confirmPasswordValidationError =>
      'This doesn\'t match the given password';

  @override
  String get createField => 'Create Field';

  @override
  String get createFieldList => 'Create Field List';

  @override
  String get createEntry => 'Create Entry';

  @override
  String get fieldName => 'Field Name';

  @override
  String get fieldListName => 'Field List Name';

  @override
  String get selectColor => 'Select Color';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String fieldNameValidationError(
    int fieldNameMinimumLength,
    int fieldNameMaximumLength,
  ) {
    return 'Field name must be between $fieldNameMinimumLength and $fieldNameMaximumLength characters';
  }

  @override
  String fieldListNameValidationError(
    int fieldListNameMinimumLength,
    int fieldListNameMaximumLength,
  ) {
    return 'Field list name must be between $fieldListNameMinimumLength and $fieldListNameMaximumLength characters';
  }

  @override
  String questionValidationError(
    int questionMinimumLength,
    int questionMaximumLength,
  ) {
    return 'Question must be between $questionMinimumLength and $questionMaximumLength characters';
  }

  @override
  String answerValidationError(
    int answerMinimumLength,
    int answerMaximumLength,
  ) {
    return 'Answer must be between $answerMinimumLength and $answerMaximumLength characters';
  }

  @override
  String orderValidationError(int orderMinimumLength, int orderMaximumLength) {
    return 'Order must be between $orderMinimumLength and $orderMaximumLength';
  }

  @override
  String scoreDescription(int numberOfDisplayedEntries, int numberOfEntries) {
    return '$numberOfDisplayedEntries/$numberOfEntries entries ordered by score descendingly';
  }

  @override
  String strugglingDescription(
    int numberOfDisplayedEntries,
    int numberOfEntries,
  ) {
    return '$numberOfDisplayedEntries/$numberOfEntries entries with a 60%+ wrongness rate';
  }

  @override
  String todayDescription(int numberOfDisplayedEntries, int numberOfEntries) {
    return '$numberOfDisplayedEntries/$numberOfEntries entries created today';
  }

  @override
  String unseenDescription(int numberOfDisplayedEntries, int numberOfEntries) {
    return '$numberOfDisplayedEntries/$numberOfEntries entries from previous days yet to be studied';
  }

  @override
  String browseDescription(int numberOfDisplayedEntries, int numberOfEntries) {
    return '$numberOfDisplayedEntries/$numberOfEntries entries indexed by order and alphabet';
  }

  @override
  String searchDescription(String searchText) {
    return 'Search result for \"$searchText\"';
  }

  @override
  String get defaultSearchDescription => 'Search result is displyed here';

  @override
  String get created => 'Created';

  @override
  String get creationError => 'Error while creation';

  @override
  String get noFields => 'Currently, there are no fields!';

  @override
  String get noEntries => 'Currently, there are no entries!';

  @override
  String get failureLoadingFields =>
      'An error occurred while loading the fields!';

  @override
  String get failureLoadingData => 'An error occurred while loading the data!';

  @override
  String get failureLoadingEntries =>
      'An error occurred while loading entries!';

  @override
  String get failureLoadingSearchResult =>
      'An error occurred while loading search result!';

  @override
  String get noFieldLists => 'Currently, there are no lists!';

  @override
  String get selectCheckType => 'Select check type';

  @override
  String get howAppCheckAnswers => 'How app checks your answers';

  @override
  String get nonStrictIgnoreCase => 'Do not check letter case or space';

  @override
  String get ignoreCase => 'Do not check letter case';

  @override
  String get nonStrictDoNotIgnoreCase => 'Do not check space';

  @override
  String get doNotIgnoreCase => 'Check both letter case and space';

  @override
  String get readAnswer => 'Read answer';

  @override
  String get whenAnsweredCorrectly => 'When you answer correctly!';

  @override
  String get question => 'Question';

  @override
  String get answer => 'Answer';

  @override
  String get low => 'Low';

  @override
  String get normal => 'Normal';

  @override
  String get important => 'Important';

  @override
  String get vital => 'Vital';

  @override
  String get order => 'Order';

  @override
  String get optional => 'Optional';

  @override
  String get create => 'Create';

  @override
  String get duplicatedEntry => 'Failure: already exists!';

  @override
  String get score => 'Score';

  @override
  String get struggling => 'Struggling';

  @override
  String get today => 'Today';

  @override
  String get unseen => 'Unseen';

  @override
  String get browse => 'Browse';

  @override
  String get search => 'Search';

  @override
  String get wrongness => 'Wrongness';

  @override
  String get study => 'Study';

  @override
  String get test => 'Test';

  @override
  String get mastered => 'Mastered';

  @override
  String get needsFocus => 'Needs Focus';

  @override
  String get enterYourAnswer => 'Enter your answer';

  @override
  String get check => 'Check';

  @override
  String get signOut => 'Sign out';

  @override
  String get about => 'About';
}
