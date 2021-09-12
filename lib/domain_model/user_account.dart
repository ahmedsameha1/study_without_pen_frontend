class UserAccount {
  late final String _id;
  late String _firstName;
  String? _middleNames;
  late String _lastName;
  late DateTime _birthDay;
  Gender _gender = Gender.UNSPECIFIED;

  UserAccount(String _id, String _firstName, String? _middleNames,
      String _lastName, DateTime _birthDay, Gender _gender) {
    /////////////////////////////////////////////////////////////////////////
    // id validation
    if (_id.isNotEmpty) {
      RegExp regExp = RegExp(r"^\S+$");
      if (!regExp.hasMatch(_id)) {
        throw ArgumentError("id cannot contain any whitespace character");
      }
    } else {
      throw ArgumentError("id cannot be an empty String");
    }
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
    /////////////////////////////////////////////////////////////////////////
    // birthDay validation
    final now = DateTime.now();
    if (_birthDay.isAtSameMomentAs(now) || _birthDay.isAfter(now)) {
      throw ArgumentError("birthDay cannot be after now");
    }
    this._id = _id;
    this._firstName = _firstName;
    this._middleNames = _middleNames;
    this._lastName = _lastName;
    this._birthDay = _birthDay;
    this._gender = _gender;
  }

  String get id => _id;
  String get firstName => _firstName;
  String? get middleNames => _middleNames;
  String get lastName => _lastName;
  DateTime get birthDay => _birthDay;
  Gender get gender => _gender;

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
    this._firstName = _firstName;
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
    this._middleNames = _middleNames;
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
    this._lastName = _lastName;
  }

  set birthDay(DateTime _birthDay) {
    final now = DateTime.now();
    if (_birthDay.isAtSameMomentAs(now) || _birthDay.isAfter(now)) {
      throw ArgumentError("birthDay cannot be after now");
    }
    this._birthDay = _birthDay;
  }

  set gender(Gender _gender) {
    this._gender = _gender;
  }
}

enum Gender { MALE, FEMALE, UNSPECIFIED }
/*
  String _email;
  bool _isEmailVerified;
  final DateTime _createdAt;
  DateTime _modifiedAt;
  DateTime _lastSignInTime;
  DateTime _lastSignOutTime;
  String _socialMediaAddress;
*/
/*
      this._email,
      this._isEmailVerified,
      this._createdAt,
      this._modifiedAt,
      this._lastSignInTime,
      this._lastSignOutTime,
      this._socialMediaAddress

   */

/*
  String get socialMediaAddress => _socialMediaAddress;

  DateTime get lastSignOutTime => _lastSignOutTime;

  DateTime get lastSignInTime => _lastSignInTime;

  DateTime get modifiedAt => _modifiedAt;

  DateTime get createdAt => _createdAt;

  bool get isEmailVerified => _isEmailVerified;

  String get email => _email;


  String get fullName => "$_firstName ${_middleName != null? _middleName: ""} $_lastName";

   */
