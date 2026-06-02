import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

abstract class FieldListsRepository {
  Future<int> create(FieldListEntity fieldListEntity);
  Stream<List<(FieldListEntity, int)>> watchWithEntriesCountByFieldId(
    String fieldId,
  );
  Stream<FieldListEntity> watchFieldList(String fieldListId);
}
