import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

import '../../data/repositories/fields_repository.dart';

class CreateFieldUsecase {
  CreateFieldUsecase(this._repository);
  final FieldsRepository _repository;
  Future<int> call(String userAccountId, String name, int color) {
    final now = clock.now();
    FieldEntity fieldEntity = FieldEntity(
      null,
      userAccountId,
      name,
      now,
      now,
      0,
      color,
    );
    return _repository.create(fieldEntity);
  }
}
