class Entry {
  static const int ASKED_COUNT_DEFAULT = 0;
  static const int WRONGLY_ANSWERED_COUNT_DEFAULT = 0;
  late final String _id;
  late String _answer;
  late String _fieldListId;
  int _askedCount = ASKED_COUNT_DEFAULT;
  int _wronglyAnsweredCount = WRONGLY_ANSWERED_COUNT_DEFAULT;

  Entry(String uuid, String answer, String fieldListId,
      {int askedCount = ASKED_COUNT_DEFAULT,
      int wronglyAnsweredCount = WRONGLY_ANSWERED_COUNT_DEFAULT}) {
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
    /////////////////////////////////////////////////////////////////////////
    // _fieldListId validation
    if (!regexp.hasMatch(fieldListId)) {
      throw ArgumentError("_fieldListId must be a valid UUID");
    }
    this._fieldListId = fieldListId;
    /////////////////////////////////////////////////////////////////////////
    // _askedCount validation
    if (askedCount < ASKED_COUNT_DEFAULT) {
      throw ArgumentError("_askedCount cannot be negative integer");
    }
    this._askedCount = askedCount;
    /////////////////////////////////////////////////////////////////////////
    // _wronglyAnsweredCount validation
    if (wronglyAnsweredCount < WRONGLY_ANSWERED_COUNT_DEFAULT) {
      throw ArgumentError("_wronglyAnsweredCount cannot be negative integer");
    }
    this._wronglyAnsweredCount = wronglyAnsweredCount;
  }

  String get id => _id;
  String get answer => _answer;
  String get fieldListId => _fieldListId;
  int get askedCount => _askedCount;
  int get wronglyAnsweredCount => _wronglyAnsweredCount;

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

  increaseAskedCountByOne() {
    _askedCount++;
  }

  increaseWronglyAnsweredCountByOne() {
    _wronglyAnsweredCount++;
  }
}
