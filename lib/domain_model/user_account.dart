import 'package:clock/clock.dart';

class UserAccount {
  late final String _id;
  late String _firstName;
  String? _middleNames;
  late String _lastName;
  late DateTime _birthDay;
  Gender _gender = Gender.UNSPECIFIED;
  String? _email;
  late bool _isEmailVerified;
  DateTime? _createdAt;
  DateTime? _lasModificationAt;
  DateTime? _lastSignInAt;
  DateTime? _lastSignOutAt;

  UserAccount(
      String _id,
      String _firstName,
      String? _middleNames,
      String _lastName,
      DateTime _birthDay,
      Gender _gender,
      String? _email,
      bool _isEmailVerified,
      DateTime? _createdAt,
      DateTime? _lastModificationAt,
      DateTime? _lastSignInAt,
      DateTime? _lastSignOutAt) {
    final now = clock.now();
    /*
    There is no validation for _id because it should come from the Firebase
    Authentication System
    */
    this._id = _id;
    /////////////////////////////////////////////////////////////////////////
    // firstName validation
    if (_firstName.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}([^\S\r\n]*\S)*\s{0}$");
      if (!regExp.hasMatch(_firstName)) {
        throw ArgumentError(
            "firstName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("firstName cannot be an empty String");
    }
    this._firstName = _firstName;
    /////////////////////////////////////////////////////////////////////////
    // middleNames validation
    if (_middleNames != null && _middleNames.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}([^\S\r\n]*\S)*\s{0}$");
      if (!regExp.hasMatch(_middleNames)) {
        throw ArgumentError(
            "middleNames cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else if (_middleNames != null) {
      throw ArgumentError("middleNames cannot be an empty String");
    }
    this._middleNames = _middleNames;
    /////////////////////////////////////////////////////////////////////////
    // lastName validation
    if (_lastName.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}([^\S\r\n]*\S)*\s{0}$");
      if (!regExp.hasMatch(_lastName)) {
        throw ArgumentError(
            "lastName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("lastName cannot be an empty String");
    }
    this._lastName = _lastName;
    /////////////////////////////////////////////////////////////////////////
    // birthDay validation
    if (_birthDay.isAtSameMomentAs(now) || _birthDay.isAfter(now)) {
      throw ArgumentError("birthDay cannot be after now");
    }
    this._birthDay = _birthDay;
    this._gender = _gender;
    /*
    There is no validation for email because it should come from the Firebase
    Authentication System
    */
    this._email = _email;
    this._isEmailVerified = _isEmailVerified;
    /*
    There is no validation for _createdAt because it should come from the Firebase
    Authentication System
    */
    this._createdAt = _createdAt;
    /////////////////////////////////////////////////////////////////////////
    // _lastModificationAt validation
    if (_lastModificationAt != null &&
        (_lastModificationAt.isAtSameMomentAs(now) ||
            _lastModificationAt.isAfter(now))) {
      throw ArgumentError("_lastModificationAt cannot be equal or after now");
    }
    this._lasModificationAt = _lastModificationAt;
    /*
    There is no validation for _lastSignInAt because it should come from the Firebase
    Authentication System
    */
    this._lastSignInAt = _lastSignInAt;
    /////////////////////////////////////////////////////////////////////////
    // _lastSignOutAt validation
    if (_lastSignOutAt != null &&
        (_lastSignOutAt.isAtSameMomentAs(now) || _lastSignOutAt.isAfter(now))) {
      throw ArgumentError("_lastSignOutAt cannot be equal or after now");
    }
    this._lastSignOutAt = _lastSignOutAt;
  }

  String get id => _id;
  String get firstName => _firstName;
  String? get middleNames => _middleNames;
  String get lastName => _lastName;
  DateTime get birthDay => _birthDay;
  Gender get gender => _gender;
  String? get email => _email;
  bool get isEmailVerified => _isEmailVerified;
  DateTime? get createdAt => _createdAt;
  DateTime? get lastModificationAt => _lasModificationAt;
  DateTime? get lastSignInAt => _lastSignInAt;
  DateTime? get lastSignOutAt => _lastSignOutAt;
  String get fullName =>
      "$_firstName${_middleNames != null ? " ${_middleNames}" : ""} $_lastName";

  set firstName(String _firstName) {
    if (_firstName.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}([^\S\r\n]*\S)*\s{0}$");
      if (!regExp.hasMatch(_firstName)) {
        throw ArgumentError(
            "firstName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("firstName cannot be an empty String");
    }
    if (_firstName != this._firstName) {
      this._firstName = _firstName;
      _lasModificationAt = clock.now();
    }
  }

  set middleNames(String? _middleNames) {
    if (_middleNames != null && _middleNames.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}([^\S\r\n]*\S)*\s{0}$");
      if (!regExp.hasMatch(_middleNames)) {
        throw ArgumentError(
            "middleNames cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else if (_middleNames != null) {
      throw ArgumentError("middleNames cannot be an empty String");
    }
    if (_middleNames != this._middleNames) {
      this._middleNames = _middleNames;
      this._lasModificationAt = clock.now();
    }
  }

  set lastName(String _lastName) {
    if (_lastName.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}([^\S\r\n]*\S)*\s{0}$");
      if (!regExp.hasMatch(_lastName)) {
        throw ArgumentError(
            "lastName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("lastName cannot be an empty String");
    }
    if (_lastName != this._lastName) {
      this._lastName = _lastName;
      this._lasModificationAt = clock.now();
    }
  }

  set birthDay(DateTime _birthDay) {
    final now = DateTime.now();
    if (_birthDay.isAtSameMomentAs(now) || _birthDay.isAfter(now)) {
      throw ArgumentError("birthDay cannot be after now");
    }
    if (_birthDay != this._birthDay) {
      this._birthDay = _birthDay;
      this._lasModificationAt = clock.now();
    }
  }

  set gender(Gender _gender) {
    if (_gender != this._gender) {
      this._gender = _gender;
      this._lasModificationAt = clock.now();
    }
  }

  set email(String? _email) {
    if (_email != this._email) {
      this._email = _email;
      this._lasModificationAt = clock.now();
    }
  }

  set isEmailVerified(bool _isEmailVerified) {
    this._isEmailVerified = _isEmailVerified;
  }

  set createdAt(DateTime? _createdAt) {
    if (_createdAt == null) {
      throw ArgumentError("_createdAt cannot be set to null");
    }
    if (this._createdAt != null) {
      throw ArgumentError(
          "_createdAt cannot be set if it has a non-null value");
    }
    this._createdAt = _createdAt;
  }

  set lastSignInAt(DateTime? _lastSignInAt) {
    if (_lastSignInAt == null) {
      throw ArgumentError("_lastSignInAt cannot be set to null");
    }
    this._lastSignInAt = _lastSignInAt;
  }

  set lastSignOutAt(DateTime? _lastSignOutAt) {
    if (_lastSignOutAt == null) {
      throw ArgumentError("_lastSignOutAt cannot be set to null");
    }
    if (_lastSignInAt != null &&
        (_lastSignOutAt.isAtSameMomentAs(_lastSignInAt!) ||
            _lastSignOutAt.isBefore(_lastSignInAt!))) {
      throw ArgumentError(
          "_lastSignOutAt cannot be set to be equal or before _lastSignInAt");
    }
    this._lastSignOutAt = _lastSignOutAt;
  }
}

enum Gender { MALE, FEMALE, UNSPECIFIED }
