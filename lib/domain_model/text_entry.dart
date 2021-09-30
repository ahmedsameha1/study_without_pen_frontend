import 'package:study_without_pen_by_flutter/domain_model/entry.dart';

class TextEntry extends Entry {
  late String _question;
  TextEntry(String uuid, String question, String answer, String fieldListId,
      DateTime createdAt)
      : super(uuid, answer, fieldListId, createdAt) {
    /////////////////////////////////////////////////////////////////////////
    // _question validation
    if (question.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}(\s*\S)*\s{0}$");
      if (!regExp.hasMatch(question)) {
        throw ArgumentError(
            "_question cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("_question cannot be an empty String");
    }
    this._question = question;
  }

  String get question => _question;

  set question(String question) {
    /////////////////////////////////////////////////////////////////////////
    // _question validation
    if (question.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}(\s*\S)*\s{0}$");
      if (!regExp.hasMatch(question)) {
        throw ArgumentError(
            "question cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("question cannot be an empty String");
    }
    this._question = question;
  }
}
