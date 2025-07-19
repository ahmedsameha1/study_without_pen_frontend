import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';

class WatchFieldUsecase {
  final FieldRepository _fieldRepository;

  WatchFieldUsecase(this._fieldRepository);
  call(String fieldId) {
    _fieldRepository.watchField(fieldId);
  }
}
