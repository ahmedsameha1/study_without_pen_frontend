import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';

class WatchFieldListsUsecase {
  WatchFieldListsUsecase(this._fieldListsRepository);
  final FieldListsRepository _fieldListsRepository;
  void call(String fieldId) {
    _fieldListsRepository.watch(fieldId);
  }
}
