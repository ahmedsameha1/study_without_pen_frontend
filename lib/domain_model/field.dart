import 'dart:ui';

import 'package:clock/clock.dart';

class Field {
  static const int NAME_MAXIMUM_LENGTH = 64;
  static const int COLOR_MAXIMUM = 0xffffffff;
  late final String _id;
  late String _name;
  late String _userAccountId;
  Color _color = Color(0xffffffff);
  DateTime _createdAt = clock.now();

  Field(String uuid, String name, String userAccountId,
      {DateTime? createdAt, Color color = const Color(0xffffffff)}) {
    if (createdAt == null) createdAt = clock.now();
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
    /*
    There is no validation for _userAccountId because it should come from the Firebase
    Authentication System
    */
    this._userAccountId = userAccountId;
    /////////////////////////////////////////////////////////////////////////
    // _color validation
    this._color = color;
    /////////////////////////////////////////////////////////////////////////
    // _createdAt validation
    if (createdAt.isAfter(clock.now())) {
      throw ArgumentError("_createdAt cannot be in the future");
    }
    this._createdAt = createdAt;
  }

  String get id => _id;
  String get name => _name;
  String get userAccountId => _userAccountId;
  Color get color => _color;
  DateTime get createdAt => _createdAt;

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

  set color(Color color) {
    this._color = color;
  }
}
