class Field {
  static const int NAME_MAXIMUM_LENGTH = 64;
  static const int COLOR_MAXIMUM = 0xffffffff;
  late final String _id;
  late String _name;
  late String _userAccountId;
  int? _color;

  Field(String uuid, String name, String userAccountId, [int? color]) {
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
    if (color != null && (color > COLOR_MAXIMUM || color < 0x00000000)) {
      throw ArgumentError(
          "_color must be equal or smaller than 0xffffffff and must be equal or greater than 0x00000000");
    }
    this._color = color;
  }

  String get id => _id;
  String get name => _name;
  String get userAccountId => _userAccountId;
  int? get color => _color;

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

  set color(int? color) {
    /////////////////////////////////////////////////////////////////////////
    // _color validation
    if (color != null && (color > COLOR_MAXIMUM || color < 0x00000000)) {
      throw ArgumentError(
          "_color must be equal or smaller than 0xffffffff and must be equal or greater than 0x00000000");
    }
    this._color = color;
  }
}
