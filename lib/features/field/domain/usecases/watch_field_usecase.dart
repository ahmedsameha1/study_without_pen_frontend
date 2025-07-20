import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

class WatchFieldUsecase {
  final FieldRepository _fieldRepository;

  WatchFieldUsecase(this._fieldRepository);

  Stream<FieldEntity> call(String fieldId) {
    return _fieldRepository.watchField(fieldId);
  }
}
