import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

class CreateFieldListUsecase {
  CreateFieldListUsecase(this._fieldListsRepository);
  final FieldListsRepository _fieldListsRepository;
  Future<int> call(
    String fieldId,
    String fieldListName,
    CheckType checkType,
    bool readAnswer,
    int color,
  ) {
    final now = clock.now();
    FieldListEntity fieldListEntity = FieldListEntity(
      fieldId: fieldId,
      name: fieldListName,
      checkType: checkType.index,
      doesReadAnswer: readAnswer,
      color: color,
      creationAt: now,
      lastModificationAt: now,
    );
    return _fieldListsRepository.create(fieldListEntity);
  }
}
