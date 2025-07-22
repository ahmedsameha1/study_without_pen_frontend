import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

class WatchFieldsUsecase {
  WatchFieldsUsecase(this._repository);
  final FieldsRepository _repository;
  Stream<List<FieldEntity>> call(String userAccountId) {
    return _repository.watch(userAccountId);
  }
}
