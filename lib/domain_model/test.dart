import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/session.dart';

abstract class Test extends Session {
  Test(String uuid, FieldList fieldList, int currentQuestionCounter,
      int triesNumber, Duration elapsedTime)
      : super(
            uuid, fieldList, currentQuestionCounter, triesNumber, elapsedTime);
}
