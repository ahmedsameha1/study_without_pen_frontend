import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_till_correct.dart';

class AskAgainAfterTest extends StudyTillCorrect {
  AskAgainAfterTest(String uuid, FieldList fieldList, int currentQuestionCounter,
      int triesNumber, Duration elapsedTime)
      : super(uuid, fieldList, currentQuestionCounter, triesNumber,
            elapsedTime);
}
