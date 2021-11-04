abstract class HasId {
  late final String _id;
  HasId(String uuid) {
    this._id = validateId(uuid);
  }

  String get id => _id;
}

abstract class HasRelationalId extends HasId {
  late final String _relationalId;
  HasRelationalId(String uuid, String relationalId) : super(uuid) {
    _relationalId = validateId(relationalId);
  }

  String get relationalId => _relationalId;
}

String validateId(String uuid) {
  /////////////////////////////////////////////////////////////////////////
  // _id validation
  final regexp = RegExp(
      "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
  if (!regexp.hasMatch(uuid)) {
    throw ArgumentError("_id must be a valid UUID");
  }
  return uuid;
}
