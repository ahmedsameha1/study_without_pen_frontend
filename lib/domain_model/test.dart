import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';

abstract class Test extends HasId {
  late String _fieldListId;
  late int _currentQuestionCounter;
  Test(String uuid, String fieldListId, int currentQuestionCounter)
      : super(uuid) {
    final regexp = RegExp(
        "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
    /////////////////////////////////////////////////////////////////////////
    // _fieldListId validation
    if (!regexp.hasMatch(fieldListId)) {
      throw ArgumentError("_fieldListId must be a valid UUID");
    }
    this._fieldListId = fieldListId;
    /////////////////////////////////////////////////////////////////////////
    // _currentQuestionCounter validation
    if (currentQuestionCounter < 0) {
      throw ArgumentError("_currentQuestionCounter cannot be negative");
    }
    this._currentQuestionCounter = currentQuestionCounter;
  }

  String get fieldListId => _fieldListId;
  int get currentQuestionCounter => _currentQuestionCounter;

  set currentQuestionCounter(int currentQuestionCounter) {
    if (currentQuestionCounter <= _currentQuestionCounter) {
      throw ArgumentError(
          "_currentQuestionCounter cannot be set to be smaller than or equal its current value");
    }
    this._currentQuestionCounter = currentQuestionCounter;
  }
}
