import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/session.dart';

abstract class Test extends Session {
  late int _currentQuestionCounter;
  Test(String uuid, FieldList fieldList, int currentQuestionCounter,
      int triesNumber, Duration elapsedTime)
      : super(uuid, fieldList, triesNumber, elapsedTime) {
    /////////////////////////////////////////////////////////////////////////
    // _currentQuestionCounter validation
    if (currentQuestionCounter < 0) {
      throw ArgumentError("_currentQuestionCounter cannot be negative");
    }
    this._currentQuestionCounter = currentQuestionCounter;
  }

  int get currentQuestionCounter => _currentQuestionCounter;

  increaseCurrentQuestionCounterByOne() {
    this._currentQuestionCounter++;
  }

  @override
  bool checkAnAnswer(String userAnswer) {
    throw UnimplementedError();
  }
}
