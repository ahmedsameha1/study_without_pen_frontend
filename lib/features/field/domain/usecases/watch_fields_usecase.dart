import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

class WatchFieldsUsecase {
  WatchFieldsUsecase(this._repository);
  final FieldRepository _repository;
  Stream<List<FieldEntity>> call(String userAccountId) {
    return _repository.watch(userAccountId);
  }
}
