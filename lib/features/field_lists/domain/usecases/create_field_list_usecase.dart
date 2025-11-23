import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';

class CreateFieldListUsecase {
  CreateFieldListUsecase(this._fieldListsRepository);
  FieldListsRepository _fieldListsRepository;
  Future<int> call(String fieldId, String fieldListName, CheckType checkType,
      bool readAnswer, int color) {
    return Future.value(1);
  }
}
