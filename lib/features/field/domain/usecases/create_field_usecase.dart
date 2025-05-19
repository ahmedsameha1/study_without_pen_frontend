import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

import '../../data/repositories/field_repository.dart';

class CreateFieldUseCase {
  CreateFieldUseCase(this._repository);
  final FieldRepository _repository;
  Future<int> call(String userAccountId, String name, int color) {
    final now = clock.now();
    FieldEntity fieldEntity =
        FieldEntity(null, userAccountId, name, now, now, 0, color);
    return _repository.create(fieldEntity);
  }
}
