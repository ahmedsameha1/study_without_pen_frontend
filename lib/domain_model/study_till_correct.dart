import 'dart:math';

import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/session.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:study_without_pen_by_flutter/utilities/compare_utility.dart';
import 'package:uuid/uuid.dart';

abstract class StudyTillCorrect extends Session {
  late int _currentQuestionCounter;
  late Set<TextEntry> _entries;
  late Set<TextEntry> _repeatedEntries = Set<TextEntry>.identity();
  bool _shouldShowTheCorrectAnswer = false;
  int? _seed;
  StudyTillCorrect(String uuid, FieldList fieldList, Set<TextEntry> entries,
      int currentQuestionCounter, int triesNumber, Duration elapsedTime,
      {int? seed})
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
    this._seed = seed;
  }

  int get currentQuestionCounter => _currentQuestionCounter;
  Set<TextEntry> get entries => _entries;
  TextEntry get currentEntry => entries.elementAt(_currentQuestionCounter);
  Set<TextEntry> get repeatedEntries => Set<TextEntry>.from(_repeatedEntries);
  bool get shouldShowTheCorrectAnswer => _shouldShowTheCorrectAnswer;

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
            userAnswer == entries.elementAt(_currentQuestionCounter).answer;
        break;
      case CheckType.NON_STRICT_IGNORE_CASE:
        lastCheckedAnswerResult = CompareUtility.nonStrictCompareIgnoreCase(
            entries.elementAt(_currentQuestionCounter).answer, userAnswer);
        break;
      case CheckType.NON_STRICT_DO_NOT_IGNORE_CASE:
        lastCheckedAnswerResult = CompareUtility.nonStrictCompare(
            entries.elementAt(_currentQuestionCounter).answer, userAnswer);
        break;
      case CheckType.IGNORE_CASE:
        lastCheckedAnswerResult = userAnswer.toLowerCase() ==
            entries.elementAt(_currentQuestionCounter).answer.toLowerCase();
        break;
    }
    if (!lastCheckedAnswerResult && triesCounter == triesNumber) {
      _repeatedEntries.add(entries.elementAt(_currentQuestionCounter));
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
    if (lastCheckedAnswerResult) {
      _shouldShowTheCorrectAnswer = false;
      increaseCurrentQuestionCounterByOne();
      resetTriesCounterToZero();
      if (currentQuestionCounter == entries.length) {
        if (_repeatedEntries.isNotEmpty) {
          resetCurrentQuestionCounterToZero();
          _entries = Set<TextEntry>.unmodifiable(
              _repeatedEntries.toList()..shuffle(Random(_seed)));
          _repeatedEntries = Set<TextEntry>.identity();
        } else {
          setSessionCompleted();
        }
      }
    } else {
      if (triesCounter == triesNumber) {
        _shouldShowTheCorrectAnswer = true;
        resetTriesCounterToZero();
      } else {
        _shouldShowTheCorrectAnswer = false;
      }
    }
    switchShouldCheckAnAnswer();
  }
}
