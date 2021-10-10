import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_till_correct.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';

class StudyPeriod extends StudyTillCorrect {
  StudyPeriod(String uuid, FieldList fieldList, Set<TextEntry> entries,
      int currentQuestionCounter, int triesNumber, Duration elapsedTime,
      {int? seed})
      : super(uuid, fieldList, entries, currentQuestionCounter, triesNumber,
            elapsedTime,
            seed: seed);
}
