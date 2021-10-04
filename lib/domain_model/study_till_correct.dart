import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/session.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:study_without_pen_by_flutter/utilities/compare_utility.dart';
import 'package:uuid/uuid.dart';

abstract class StudyTillCorrect extends Session {
  late final List<TextEntry> _entries;
  StudyTillCorrect(String uuid, FieldList fieldList, List<TextEntry> entries,
      int currentQuestionCounter, int triesNumber, Duration elapsedTime)
      : super(
            uuid, fieldList, currentQuestionCounter, triesNumber, elapsedTime) {
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

  List<TextEntry> get entries => _entries;

  @override
  bool checkAnAnswer(String userAnswer) {
    switch (fieldList.checkType) {
      case CheckType.DO_NOT_IGNORE_CASE:
        return userAnswer == entries[currentQuestionCounter].answer;
      case CheckType.NON_STRICT_IGNORE_CASE:
        return CompareUtility.nonStrictCompareIgnoreCase(
            entries[currentQuestionCounter].answer, userAnswer);
      case CheckType.NON_STRICT_DO_NOT_IGNORE_CASE:
        return CompareUtility.nonStrictCompare(
            entries[currentQuestionCounter].answer, userAnswer);
      case CheckType.IGNORE_CASE:
        return userAnswer.toLowerCase() ==
            entries[currentQuestionCounter].answer.toLowerCase();
    }
  }
}
