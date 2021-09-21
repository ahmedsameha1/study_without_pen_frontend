import 'dart:ui';

class FieldList {
  static const int NAME_MAXIMUM_LENGTH = 64;
  late final String _id;
  late String _name;
  Locale? _locale;
  CheckType _checkType = CheckType.NON_STRICT_IGNORE_CASE;

  FieldList(String uuid, String name,
      {Locale? locale,
      CheckType checkType = CheckType.NON_STRICT_IGNORE_CASE}) {
    /////////////////////////////////////////////////////////////////////////
    // _id validation
    final regexp = RegExp(
        "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
    if (!regexp.hasMatch(uuid)) {
      throw ArgumentError("_id must be a valid UUID");
    }
    this._id = uuid;
    /////////////////////////////////////////////////////////////////////////
    // _name validation
    if (name.isEmpty) {
      throw ArgumentError("_name cannot be empty");
    }
    if (name.length > NAME_MAXIMUM_LENGTH) {
      throw ArgumentError("_name length cannot be greater than 64 character");
    }
    this._name = name;
    this._locale = locale;
    this._checkType = checkType;
  }

  String get id => _id;
  String get name => _name;
  Locale? get locale => _locale;
  CheckType get checkType => _checkType;

  set name(String name) {
    /////////////////////////////////////////////////////////////////////////
    // _name validation
    if (name.isEmpty) {
      throw ArgumentError("_name cannot be empty");
    }
    if (name.length > NAME_MAXIMUM_LENGTH) {
      throw ArgumentError("_name length cannot be greater than 64 character");
    }
    this._name = name;
  }

  set locale(Locale? locale) {
    this._locale = locale;
  }

  set checkType(CheckType checkType) {
    this._checkType = checkType;
  }
}

enum CheckType {
  NON_STRICT_IGNORE_CASE,
  NON_STRICT_DO_NOT_IGNORE_CASE,
  IGNORE_CASE,
  DO_NOT_IGNORE_CASE
}
