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
  String get nonso_verifyEmailAddress => 'Check your email inbox to verify your email address';

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
  String get nonso_resetCodeSent => 'Check your email inbox to reset your password';

  @override
  String get nonso_nameValidationError => 'Enter your name';

  @override
  String nonso_failed(String exceptionCode) {
    return 'Failure: $exceptionCode';
  }

  @override
  String get nonso_success => 'Success: Check your email to verify your email address';

  @override
  String nonso_passwordValidationError(int passwordMinimumLength) {
    return 'Password needs to be at least $passwordMinimumLength characters';
  }

  @override
  String get nonso_confirmPasswordValidationError => 'This doesn\'t match the given password';

  @override
  String get createField => 'Create Field';

  @override
  String get fieldName => 'Field Name';

  @override
  String get selectColor => 'Select Color';

  @override
  String get ok => 'Ok';

  @override
  String get cancel => 'Cancel';

  @override
  String fieldNameValidationError(int fieldNameMinimumLength, int fieldNameMaximumLength) {
    return 'Field name must be between $fieldNameMinimumLength and $fieldNameMaximumLength characters';
  }

  @override
  String get fieldHasBeenCreated => 'Field has been created';
}
