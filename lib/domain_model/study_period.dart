import 'package:study_without_pen_by_flutter/domain_model/study_till_correct.dart';

class StudyPeriod extends StudyTillCorrect {
  StudyPeriod(String uuid, fieldListId, int currentQuestionCounter,
      int triesNumber, Duration elapsedTime)
      : super(uuid, fieldListId, currentQuestionCounter, triesNumber,
            elapsedTime);
}
