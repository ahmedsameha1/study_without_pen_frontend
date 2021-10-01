import 'package:study_without_pen_by_flutter/domain_model/test.dart';

abstract class StudyTillCorrect extends Test {
  StudyTillCorrect(String uuid, String fieldListId, int currentQuestionCounter)
      : super(uuid, fieldListId, currentQuestionCounter);
}
