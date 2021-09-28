class Entry {
  late final String _id;
  late String _answer;
  Entry(String uuid, String answer) {
    /////////////////////////////////////////////////////////////////////////
    // _id validation
    final regexp = RegExp(
        "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
    if (!regexp.hasMatch(uuid)) {
      throw ArgumentError("_id must be a valid UUID");
    }
    this._id = uuid;
    /////////////////////////////////////////////////////////////////////////
    // _answer validation
    if (answer.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}(\s*\S)*\s{0}$");
      if (!regExp.hasMatch(answer)) {
        throw ArgumentError(
            "_answer cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("_answer cannot be an empty String");
    }
    this._answer = answer;
  }

  String get id => _id;
  String get answer => _answer;

  set answer(String answer) {
    /////////////////////////////////////////////////////////////////////////
    // _answer validation
    if (answer.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}(\s*\S)*\s{0}$");
      if (!regExp.hasMatch(answer)) {
        throw ArgumentError(
            "firstName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("firstName cannot be an empty String");
    }
    this._answer = answer;
  }
}