import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

class FieldListsRepositoryLocal implements FieldListsRepository {
  FieldListsRepositoryLocal(this._fieldListsDao);
  final FieldListsDao _fieldListsDao;
  @override
  Stream<List<FieldListEntity>> watch(String fieldId) {
    _fieldListsDao.watchByFieldId(fieldId);
    return Stream.empty();
  }
}
