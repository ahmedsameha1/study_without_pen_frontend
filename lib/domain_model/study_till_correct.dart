import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/session.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:study_without_pen_by_flutter/utilities/compare_utility.dart';
import 'package:uuid/uuid.dart';

abstract class StudyTillCorrect extends Session {
  late int _currentQuestionCounter;
  late final List<TextEntry> _entries;
  StudyTillCorrect(String uuid, FieldList fieldList, List<TextEntry> entries,
      int currentQuestionCounter, int triesNumber, Duration elapsedTime)
      : super(uuid, fieldList, triesNumber, elapsedTime) {
    /////////////////////////////////////////////////////////////////////////
    // _currentQuestionCounter validation
    if (currentQuestionCounter < 0) {
      throw ArgumentError("_currentQuestionCounter cannot be negative");
    }
    this._currentQuestionCounter = currentQuestionCounter;
    /////////////////////////////////////////////////////////////////////////
    // _entries validation
    if (entries.isEmpty) {
      throw ArgumentError("_entries cannot be an empty list");
    }
    final uuid = Uuid();
    try {
      entries.add(TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
          DateTime.utc(2020, 1, 1)));
      throw ArgumentError("_entries cannot be a growable list");
    } on UnsupportedError {
      if (entries.toSet().length != entries.length) {
        throw ArgumentError("_entries has the same entry more than once");
      }
      this._entries = entries;
    }
  }

  int get currentQuestionCounter => _currentQuestionCounter;
  List<TextEntry> get entries => _entries;
  TextEntry get currentEntry => entries[currentQuestionCounter];

  resetCurrentQuestionCounterToZero() {
    this._currentQuestionCounter = 0;
  }

  increaseCurrentQuestionCounterByOne() {
    this._currentQuestionCounter++;
  }

  @override
  checkAnAnswer(String userAnswer) {
    if (!shouldCheckAnAnswer) {
      throw StateError("Call next() first!");
    }
    increaseTriesCounterByOne();
    switch (fieldList.checkType) {
      case CheckType.DO_NOT_IGNORE_CASE:
        lastCheckedAnswerResult =
            userAnswer == entries[currentQuestionCounter].answer;
        break;
      case CheckType.NON_STRICT_IGNORE_CASE:
        lastCheckedAnswerResult = CompareUtility.nonStrictCompareIgnoreCase(
            entries[currentQuestionCounter].answer, userAnswer);
        break;
      case CheckType.NON_STRICT_DO_NOT_IGNORE_CASE:
        lastCheckedAnswerResult = CompareUtility.nonStrictCompare(
            entries[currentQuestionCounter].answer, userAnswer);
        break;
      case CheckType.IGNORE_CASE:
        lastCheckedAnswerResult = userAnswer.toLowerCase() ==
            entries[currentQuestionCounter].answer.toLowerCase();
        break;
    }
    switchShouldCheckAnAnswer();
  }

  @override
  next() {
    if (isCompleted) {
      throw StateError("session has been completed");
    }
    if (shouldCheckAnAnswer) {
      throw StateError("Call checkAnAnswer() first!");
    }
    if (lastCheckedAnswerResult || triesCounter == triesNumber) {
      increaseCurrentQuestionCounterByOne();
      resetTriesCounterToZero();
      if (currentQuestionCounter == entries.length) {
        setSessionCompleted();
      }
    }
    switchShouldCheckAnAnswer();
  }
}
