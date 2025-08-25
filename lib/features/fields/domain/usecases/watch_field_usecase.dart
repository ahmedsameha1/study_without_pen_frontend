import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

class WatchFieldUsecase {
  final FieldsRepository _fieldRepository;

  WatchFieldUsecase(this._fieldRepository);

  Stream<FieldEntity?> call(String fieldId) {
    return _fieldRepository.watchField(fieldId);
  }
}
