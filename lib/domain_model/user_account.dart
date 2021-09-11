class UserAccount {
  late final String _id;
  late String _firstName;

  UserAccount(String _id, String _firstName) {
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
        throw ArgumentError("firstName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("firstName cannot be an empty String");
    }
    this._id = _id;
    this._firstName = _firstName;
  }

  String get id => _id;
  String get firstName => _firstName;
}

/*
  String? _middleName;
  String _lastName;
  DateTime _birthDay;
  Gender _gender;
  String _email;
  bool _isEmailVerified;
  final DateTime _createdAt;
  DateTime _modifiedAt;
  DateTime _lastSignInTime;
  DateTime _lastSignOutTime;
  String _socialMediaAddress;
*/
  /*
      this._middleName,
      this._lastName,
      this._gender,
      this._email,
      this._isEmailVerified,
      this._birthDay,
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

  Gender get gender => _gender;

  DateTime get birthDay => _birthDay;

  String get lastName => _lastName;

  String? get middleName => _middleName;




  String get fullName => "$_firstName ${_middleName != null? _middleName: ""} $_lastName";

   */