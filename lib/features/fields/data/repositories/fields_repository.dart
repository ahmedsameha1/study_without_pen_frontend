import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

abstract class FieldsRepository {
  Future<int> create(FieldEntity fieldEntity);
  Stream<FieldEntity?> watchField(String fieldId);
  Future<void> giveUserTheUserlessData(String userAccountId);
  Stream<List<(FieldEntity, int)>> watchWithFieldListsCountByUserAccountId(
    String userAccountId,
  );
}
