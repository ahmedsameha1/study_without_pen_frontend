import 'dart:math';

import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:study_without_pen_by_flutter/utilities/compare_utility.dart';
import 'package:uuid/uuid.dart';

abstract class Session extends HasId {
  late FieldList _fieldList;
  late int _currentQuestionCounter;
  late Set<TextEntry> _entries;
  late Map<String, List<String>> _hints;
  late int _triesNumber;
  int _triesCounter = 0;
  late Duration _elapsedTime;
  bool _isCompleted = false;
  bool _lastCheckedAnswerResult = false;
  bool _shouldCheckAnAnswer = true;
  int _currentHintCounter = 0;
  Session(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime)
      : super(uuid) {
    this._fieldList = fieldList;
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
    /////////////////////////////////////////////////////////////////////////
    // _hints validation
    // TODO prevent null values in hints map
    if (hints.length != _entries.length) {
      throw ArgumentError("_hints must match _entries in length");
    }
    entries.forEach((element) {
      if (!hints.containsKey(element.id)) {
        throw ArgumentError("hints doesn't match entries id ids");
      }
    });
    this._hints = hints;
    /////////////////////////////////////////////////////////////////////////
    // _triesNumber validation
    if (triesNumber < 1) {
      throw ArgumentError("_triesNumber cannot be smaller than one");
    }
    this._triesNumber = triesNumber;
    this._elapsedTime = elapsedTime;
  }

  FieldList get fieldList => _fieldList;
  int get currentQuestionCounter => _currentQuestionCounter;
  Set<TextEntry> get entries => _entries;
  Map<String, List<String>> get hints => _hints;
  TextEntry get currentEntry => entries.elementAt(_currentQuestionCounter);
  int get triesNumber => _triesNumber;
  Duration get elapsedTime => _elapsedTime;
  int get triesCounter => _triesCounter;
  bool get isCompleted => _isCompleted;

  bool get lastCheckedAnswerResult {
    if (triesCounter < 1) {
      throw StateError("there is not any checks of answers");
    }
    return _lastCheckedAnswerResult;
  }

  String? get hint {
    if (!_shouldCheckAnAnswer) {
      throw StateError("Call next() first!");
    }
    if (hints[currentEntry.id] == null || hints[currentEntry.id]!.length == 0) {
      return null;
    } else {
      if (hints[currentEntry.id]!.length > _currentHintCounter) {
        return hints[currentEntry.id]![_currentHintCounter++];
      } else {
        resetCurrentHintCounterToZero();
        return hints[currentEntry.id]![_currentHintCounter++];
      }
    }
  }

  bool get shouldCheckAnAnswer => _shouldCheckAnAnswer;

  set elapsedTime(Duration elapsedTime) {
    if (elapsedTime.compareTo(this._elapsedTime) <= 0) {
      throw ArgumentError(
          "_elapsedTime cannot be set to be smaller than or equal the current value");
    }
    this._elapsedTime = elapsedTime;
  }

  set lastCheckedAnswerResult(bool lastCheckedAnswerResult) {
    this._lastCheckedAnswerResult = lastCheckedAnswerResult;
  }

  resetCurrentQuestionCounterToZero() {
    this._currentQuestionCounter = 0;
  }

  increaseCurrentQuestionCounterByOne() {
    this._currentQuestionCounter++;
  }

  switchShouldCheckAnAnswer() {
    this._shouldCheckAnAnswer = !this._shouldCheckAnAnswer;
  }

  increaseTriesCounterByOne() {
    this._triesCounter++;
  }

  resetTriesCounterToZero() {
    this._triesCounter = 0;
  }

  setSessionCompleted() {
    this._isCompleted = true;
  }

  resetCurrentHintCounterToZero() {
    _currentHintCounter = 0;
  }

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
    switchShouldCheckAnAnswer();
  }

  next() {
    if (isCompleted) {
      throw StateError("session has been completed");
    }
    if (shouldCheckAnAnswer) {
      throw StateError("Call checkAnAnswer() first!");
    }
    switchShouldCheckAnAnswer();
  }
}

abstract class StudyTillCorrect extends Session {
  late Set<TextEntry> _repeatedEntries = Set<TextEntry>.identity();
  bool _shouldShowTheCorrectAnswer = false;
  int? _seed;
  StudyTillCorrect(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime,
      {int? seed})
      : super(uuid, fieldList, entries, hints, currentQuestionCounter,
            triesNumber, elapsedTime) {
    this._seed = seed;
  }

  Set<TextEntry> get repeatedEntries => Set<TextEntry>.from(_repeatedEntries);
  bool get shouldShowTheCorrectAnswer => _shouldShowTheCorrectAnswer;

  @override
  next() {
    super.next();
    if (lastCheckedAnswerResult) {
      _shouldShowTheCorrectAnswer = false;
      increaseCurrentQuestionCounterByOne();
      resetTriesCounterToZero();
      resetCurrentHintCounterToZero();
      if (currentQuestionCounter == entries.length) {
        if (_repeatedEntries.isNotEmpty) {
          resetCurrentQuestionCounterToZero();
          super._entries = Set<TextEntry>.unmodifiable(
              _repeatedEntries.toList()..shuffle(Random(_seed)));
          _repeatedEntries = Set<TextEntry>.identity();
        } else {
          setSessionCompleted();
        }
      }
    } else {
      if (triesCounter == triesNumber) {
        _repeatedEntries.add(entries.elementAt(currentQuestionCounter));
        _shouldShowTheCorrectAnswer = true;
        resetTriesCounterToZero();
      } else {
        _shouldShowTheCorrectAnswer = false;
      }
    }
  }
}

abstract class Test extends Session {
  int _wrongAnswerCounter = 0;
  Map<String, List<String>> _wrongAnswers =
      Map<String, List<String>>.identity();
  late String _lastAnswer;
  Test(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime)
      : super(uuid, fieldList, entries, hints, currentQuestionCounter,
            triesNumber, elapsedTime) {
    _entries.forEach((element) {
      _wrongAnswers[element.id] = [];
    });
  }

  Map<String, List<String>> get wrongAnswers => _wrongAnswers;
  int get wrongAnswerCounter => _wrongAnswerCounter;

  @override
  checkAnAnswer(String userAnswer) {
    super.checkAnAnswer(userAnswer);
    _lastAnswer = userAnswer;
  }

  @override
  next() {
    super.next();
    if (lastCheckedAnswerResult) {
      increaseCurrentQuestionCounterByOne();
      resetTriesCounterToZero();
      resetCurrentHintCounterToZero();
    } else {
      _wrongAnswers[entries.elementAt(currentQuestionCounter).id]!
          .add(_lastAnswer);
      if (triesCounter == triesNumber) {
        resetTriesCounterToZero();
        increaseCurrentQuestionCounterByOne();
        resetCurrentHintCounterToZero();
        _wrongAnswerCounter++;
      }
    }
    if (currentQuestionCounter == entries.length) {
      setSessionCompleted();
    }
  }
}

class AskAgainAfterTest extends StudyTillCorrect {
  AskAgainAfterTest(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime,
      {int? seed})
      : super(uuid, fieldList, entries, hints, currentQuestionCounter,
            triesNumber, elapsedTime,
            seed: seed);
}

class StudyPeriod extends StudyTillCorrect {
  StudyPeriod(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime,
      {int? seed})
      : super(uuid, fieldList, entries, hints, currentQuestionCounter,
            triesNumber, elapsedTime,
            seed: seed);
}

class EnhancedTest extends Test {
  EnhancedTest(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime)
      : super(uuid, fieldList, entries, hints, currentQuestionCounter,
            triesNumber, elapsedTime);
}

class FullyRandomTest extends Test {
  FullyRandomTest(
      String uuid,
      FieldList fieldList,
      Set<TextEntry> entries,
      Map<String, List<String>> hints,
      int currentQuestionCounter,
      int triesNumber,
      Duration elapsedTime)
      : super(uuid, fieldList, entries, hints, currentQuestionCounter,
            triesNumber, elapsedTime);
}
