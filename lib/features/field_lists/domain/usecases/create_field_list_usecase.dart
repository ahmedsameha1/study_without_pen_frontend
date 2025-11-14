import 'package:study_without_pen_by_flutter/database/app_database.dart';

class CreateFieldListUsecase {
  Future<int> call(String fieldId, String fieldListName, CheckType checkType,
      bool readAnswer, int color) {
    return Future.value(1);
  }
}
