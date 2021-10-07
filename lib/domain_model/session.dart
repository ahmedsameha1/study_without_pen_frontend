import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';

abstract class Session extends HasId {
  late FieldList _fieldList;
  late int _triesNumber;
  int _triesCounter = 0;
  late Duration _elapsedTime;
  bool _isCompleted = false;
  bool _lastCheckedAnswerResult = false;
  bool _shouldCheckAnAnswer = true;
  Session(
      String uuid, FieldList fieldList, int triesNumber, Duration elapsedTime)
      : super(uuid) {
    this._fieldList = fieldList;
    /////////////////////////////////////////////////////////////////////////
    // _triesNumber validation
    if (triesNumber < 1) {
      throw ArgumentError("_triesNumber cannot be smaller than one");
    }
    this._triesNumber = triesNumber;
    this._elapsedTime = elapsedTime;
  }

  FieldList get fieldList => _fieldList;
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

  checkAnAnswer(String userAnswer);
  next();
}
