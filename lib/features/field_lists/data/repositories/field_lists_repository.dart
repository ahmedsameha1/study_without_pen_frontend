import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

abstract class FieldListsRepository {
  Future<int> create(FieldListEntity fieldEntity);
  Stream<List<FieldListEntity>> watch(String fieldId);
}
