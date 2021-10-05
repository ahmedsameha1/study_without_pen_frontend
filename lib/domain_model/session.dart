import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';

abstract class Session extends HasId {
  late FieldList _fieldList;
  late int _triesNumber;
  late Duration _elapsedTime;
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

  set elapsedTime(Duration elapsedTime) {
    if (elapsedTime.compareTo(this._elapsedTime) <= 0) {
      throw ArgumentError(
          "_elapsedTime cannot be set to be smaller than or equal the current value");
    }
    this._elapsedTime = elapsedTime;
  }

  bool checkAnAnswer(String userAnswer);
}
