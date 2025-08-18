import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

class WatchFieldListsUsecase {
  WatchFieldListsUsecase(this._fieldListsRepository);
  final FieldListsRepository _fieldListsRepository;
  Stream<List<FieldListEntity>> call(String fieldId) {
    return _fieldListsRepository.watch(fieldId);
  }
}
