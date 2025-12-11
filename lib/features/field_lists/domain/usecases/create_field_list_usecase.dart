import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';

class CreateFieldListUsecase {
  CreateFieldListUsecase(this._fieldListsRepository);
  final FieldListsRepository _fieldListsRepository;
  Future<int> call(
    String fieldId,
    String fieldListName,
    CheckType checkType,
    bool readAnswer,
    int color,
  ) async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(1);
  }
}
