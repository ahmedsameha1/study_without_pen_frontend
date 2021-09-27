import 'dart:ui';

class FieldList {
  static const int NAME_MAXIMUM_LENGTH = 64;
  static const int QUESTION_AREA_SIZE_DEFAULT = 1;
  static const int MINIMUM_QUESTION_AREA_SIZE = 1;
  static const int ANSWER_AREA_SIZE_DEFAULT = 1;
  static const int MINIMUM_ANSWER_AREA_SIZE = 1;
  static const SortBy SORT_BY_DEFAULT = SortBy.CREATION_DATE_DESC;
  static const CheckType CHECK_TYPE_DEFAULT = CheckType.NON_STRICT_IGNORE_CASE;
  static const TestTextSize TEST_TEXT_SIZE_DEFAULT = TestTextSize.NORMAL;
  static const bool IS_INFO_BAR_SHOWN_DEFAULT = true;
  static const bool DOES_READ_ANSWER_DEFAULT = false;
  static const int USAGE_COUNT_DEFAULT = 0;
  static const int? EMULATION_NUMBER_OF_QUESTIONS_DEFAULT = null;
  static const List<int> EMULATION_DAYS_DEFAULT = [
    DateTime.monday,
    DateTime.tuesday,
    DateTime.wednesday,
    DateTime.thursday,
    DateTime.friday,
    DateTime.saturday,
    DateTime.sunday
  ];
  static const Duration? TESTS_READING_QUESTION_LETTER_DURATION_DEFAULT = null;
  static const Duration? TESTS_FINDING_ANSWER_DURATION_DEFAULT = null;
  static const Duration? TESTS_TYPING_ANSWER_LETTER_DURATION_DEFAULT = null;
  static const Duration?
      STUDY_TILL_CORRECT_READING_QUESTION_LETTER_DURATION_DEFAULT = null;
  static const Duration? STUDY_TILL_CORRECT_FINDING_ANSWER_DURATION_DEFAULT =
      null;
  late final String _id;
  late String _name;
  late String _fieldId;
  Locale? _locale;
  CheckType _checkType = CHECK_TYPE_DEFAULT;
  SortBy _sortBy = SORT_BY_DEFAULT;
  Color _color = Color(0xffffffff);
  int _questionAreaSize = QUESTION_AREA_SIZE_DEFAULT;
  int _answerAreaSize = ANSWER_AREA_SIZE_DEFAULT;
  TestTextSize _testTextSize = TEST_TEXT_SIZE_DEFAULT;
  bool _isInfoBarShown = IS_INFO_BAR_SHOWN_DEFAULT;
  bool _doesReadAnswer = DOES_READ_ANSWER_DEFAULT;
  int _usageCount = USAGE_COUNT_DEFAULT;
  int? _emulationNumberOfQuestions = EMULATION_NUMBER_OF_QUESTIONS_DEFAULT;
  List<int> _emulationDays = EMULATION_DAYS_DEFAULT;
  Duration? _testsReadingQuestionLetterDuration =
      TESTS_READING_QUESTION_LETTER_DURATION_DEFAULT;
  Duration? _testsFindingAnswerDuration = TESTS_FINDING_ANSWER_DURATION_DEFAULT;
  Duration? _testsTypingAnswerLetterDuration =
      TESTS_TYPING_ANSWER_LETTER_DURATION_DEFAULT;
  Duration? _studyTillCorrectReadingQuestionLetterDuration =
      STUDY_TILL_CORRECT_READING_QUESTION_LETTER_DURATION_DEFAULT;
  Duration? _studyTillCorrectFindingAnswerDuration =
      STUDY_TILL_CORRECT_FINDING_ANSWER_DURATION_DEFAULT;

  FieldList(String uuid, String name, String fieldId,
      {Locale? locale,
      CheckType checkType = CHECK_TYPE_DEFAULT,
      SortBy sortBy = SORT_BY_DEFAULT,
      Color color = const Color(0xffffffff),
      int questionAreaSize = QUESTION_AREA_SIZE_DEFAULT,
      int answerAreaSize = ANSWER_AREA_SIZE_DEFAULT,
      TestTextSize testTextSize = TEST_TEXT_SIZE_DEFAULT,
      bool isInfoBarShown = IS_INFO_BAR_SHOWN_DEFAULT,
      bool doesReadAnswer = DOES_READ_ANSWER_DEFAULT,
      int usageCount = USAGE_COUNT_DEFAULT,
      int? emulationNumberOfQuestions = EMULATION_NUMBER_OF_QUESTIONS_DEFAULT,
      List<int> emulationDays = EMULATION_DAYS_DEFAULT,
      Duration? testsReadingQuestionLetterDuration =
          TESTS_READING_QUESTION_LETTER_DURATION_DEFAULT,
      Duration? testsFindingAnswerDuration =
          TESTS_FINDING_ANSWER_DURATION_DEFAULT,
      Duration? testsTypingAnswerLetterDuration =
          TESTS_TYPING_ANSWER_LETTER_DURATION_DEFAULT,
      Duration? studyTillCorrectReadingQuestionLetterDuration =
          STUDY_TILL_CORRECT_READING_QUESTION_LETTER_DURATION_DEFAULT,
      Duration? studyTillCorrectFindingAnswerDuration =
          STUDY_TILL_CORRECT_FINDING_ANSWER_DURATION_DEFAULT}) {
    final regexp = RegExp(
        "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
    /////////////////////////////////////////////////////////////////////////
    // _id validation
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
    /////////////////////////////////////////////////////////////////////////
    // _fieldId validation
    if (!regexp.hasMatch(fieldId)) {
      throw ArgumentError("_id must be a valid UUID");
    }
    this._fieldId = fieldId;
    this._locale = locale;
    this._checkType = checkType;
    this._sortBy = sortBy;
    this._color = color;
    /////////////////////////////////////////////////////////////////////////
    // _questionAreaSize validation
    if (questionAreaSize < MINIMUM_QUESTION_AREA_SIZE) {
      throw ArgumentError("_questionAreaSize cannot be smaller than 1");
    }
    this._questionAreaSize = questionAreaSize;
    /////////////////////////////////////////////////////////////////////////
    // _answerAreaSize validation
    if (answerAreaSize < MINIMUM_ANSWER_AREA_SIZE) {
      throw ArgumentError("_answerAreaSize cannot be smaller than 1");
    }
    this._answerAreaSize = answerAreaSize;
    this._testTextSize = testTextSize;
    this._isInfoBarShown = isInfoBarShown;
    this._doesReadAnswer = doesReadAnswer;
    /////////////////////////////////////////////////////////////////////////
    // _usageCount validation
    if (usageCount < 0) {
      throw ArgumentError("_usageCount cannot be negative");
    }
    this._usageCount = usageCount;
    /////////////////////////////////////////////////////////////////////////
    // _emulationNumberOfQuestions validation
    if (emulationNumberOfQuestions != null && emulationNumberOfQuestions < 1) {
      throw ArgumentError(
          "_emulationNumberOfQuestions cannot be smaller than 1");
    }
    this._emulationNumberOfQuestions = emulationNumberOfQuestions;
    /////////////////////////////////////////////////////////////////////////
    // _emulationDays validation
    if (emulationDays.length > 7) {
      throw ArgumentError("_emulationDays length must be smaller than 8");
    }
    if (emulationDays.any((element) => element > 7 || element < 1)) {
      throw ArgumentError(
          "_emulationDays elements cannot be smaller than 1 or greater than 7");
    }
    if (emulationDays.toSet().length < emulationDays.length) {
      throw ArgumentError("_emulationDays cannot contain duplicated elements");
    }
    this._emulationDays = emulationDays;
    this._testsReadingQuestionLetterDuration =
        testsReadingQuestionLetterDuration;
    this._testsFindingAnswerDuration = testsFindingAnswerDuration;
    this._testsTypingAnswerLetterDuration = testsTypingAnswerLetterDuration;
    this._studyTillCorrectReadingQuestionLetterDuration =
        studyTillCorrectReadingQuestionLetterDuration;
    this._studyTillCorrectFindingAnswerDuration =
        studyTillCorrectFindingAnswerDuration;
  }

  String get id => _id;
  String get name => _name;
  String get fieldId => _fieldId;
  Locale? get locale => _locale;
  CheckType get checkType => _checkType;
  SortBy get sortBy => _sortBy;
  Color get color => _color;
  int get questionAreaSize => _questionAreaSize;
  int get answerAreaSize => _answerAreaSize;
  TestTextSize get testTextSize => _testTextSize;
  bool get isInfoBarShown => _isInfoBarShown;
  bool get doesReadAnswer => _doesReadAnswer;
  int get usageCount => _usageCount;
  int? get emulationNumberOfQuestions => _emulationNumberOfQuestions;
  List<int> get emulationDays => _emulationDays;
  Duration? get testsReadingQuestionLetterDuration =>
      _testsReadingQuestionLetterDuration;
  Duration? get testsFindingAnswerDuration => _testsFindingAnswerDuration;
  Duration? get testsTypingAnswerLetterDuration =>
      _testsTypingAnswerLetterDuration;
  Duration? get studyTillCorrectReadingQuestionLetterDuration =>
      _studyTillCorrectReadingQuestionLetterDuration;
  Duration? get studyTillCorrectFindingAnswerDuration =>
      _studyTillCorrectFindingAnswerDuration;

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

  set sortBy(SortBy sortBy) {
    this._sortBy = sortBy;
  }

  set color(Color color) {
    this._color = color;
  }

  set questionAreaSize(int questionAreaSize) {
    /////////////////////////////////////////////////////////////////////////
    // _questionAreaSize validation
    if (questionAreaSize < MINIMUM_QUESTION_AREA_SIZE) {
      throw ArgumentError("_questionAreaSize cannot be smaller than 1");
    }
    this._questionAreaSize = questionAreaSize;
  }

  set answerAreaSize(int answerAreaSize) {
    /////////////////////////////////////////////////////////////////////////
    // _answerAreaSize validation
    if (answerAreaSize < MINIMUM_ANSWER_AREA_SIZE) {
      throw ArgumentError("_answerAreaSize cannot be smaller than 1");
    }
    this._answerAreaSize = answerAreaSize;
  }

  set testTextSize(TestTextSize testTextSize) {
    this._testTextSize = testTextSize;
  }

  set isInfoBarShown(bool isInfoBarShown) {
    this._isInfoBarShown = isInfoBarShown;
  }

  set doesReadAnswer(bool doesReadAnswer) {
    this._doesReadAnswer = doesReadAnswer;
  }

  set usageCount(int usageCount) {
    /////////////////////////////////////////////////////////////////////////
    // _usageCount validation
    if (usageCount <= _usageCount) {
      throw ArgumentError(
          "_usageCount cannot be set to equal or smaller value than the current value");
    }
    this._usageCount = usageCount;
  }

  set emulationNumberOfQuestions(int? emulationNumberOfQuestions) {
    /////////////////////////////////////////////////////////////////////////
    // _emulationNumberOfQuestions validation
    if (emulationNumberOfQuestions != null && emulationNumberOfQuestions < 1) {
      throw ArgumentError(
          "_emulationNumberOfQuestions cannot be smaller than 1");
    }
    this._emulationNumberOfQuestions = emulationNumberOfQuestions;
  }

  set emulationDays(List<int> emulationDays) {
    /////////////////////////////////////////////////////////////////////////
    // _emulationDays validation
    if (emulationDays.length > 7) {
      throw ArgumentError("_emulationDays length must be smaller than 8");
    }
    if (emulationDays.any((element) => element > 7 || element < 1)) {
      throw ArgumentError(
          "_emulationDays elements cannot be smaller than 1 or greater than 7");
    }
    if (emulationDays.toSet().length < emulationDays.length) {
      throw ArgumentError("_emulationDays cannot contain duplicated elements");
    }
    this._emulationDays = emulationDays;
  }

  set testsReadingQuestionLetterDuration(
      Duration? testsReadingQuestionLetterDuration) {
    this._testsReadingQuestionLetterDuration =
        testsReadingQuestionLetterDuration;
  }

  set testsFindingAnswerDuration(Duration? testsFindingAnswerDuration) {
    this._testsFindingAnswerDuration = testsFindingAnswerDuration;
  }

  set testsTypingAnswerLetterDuration(
      Duration? testsTypingAnswerLetterDuration) {
    this._testsTypingAnswerLetterDuration = testsTypingAnswerLetterDuration;
  }

  set studyTillCorrectReadingQuestionLetterDuration(
      Duration? studyTillCorrectReadingQuestionLetterDuration) {
    this._studyTillCorrectReadingQuestionLetterDuration =
        studyTillCorrectReadingQuestionLetterDuration;
  }

  set studyTillCorrectFindingAnswerDuration(
      Duration? studyTillCorrectFindingAnswerDuration) {
    this._studyTillCorrectFindingAnswerDuration =
        studyTillCorrectFindingAnswerDuration;
  }
}

enum CheckType {
  NON_STRICT_IGNORE_CASE,
  NON_STRICT_DO_NOT_IGNORE_CASE,
  IGNORE_CASE,
  DO_NOT_IGNORE_CASE
}

enum SortBy {
  CREATION_DATE_DESC,
  ANSWER_DESC,
  QUESTION_ASC,
  ANSWER_ASC,
  DATE_DESC,
  DATE_ASC,
  QUESTION_DESC,
  CREATION_DATE_ASC,
  ORDER_ASC,
  ORDER_DESC,
  RANK_ASC,
  RANK_DESC,
  WRONGNESS_ASC,
  WRONGNESS_DESC
}

enum TestTextSize { SO_SMALL, SMALL, NORMAL, LARGE, SO_LARGE }
