import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

abstract class FieldRepository {
  Future<int> create(FieldEntity fieldEntity);
  Stream<List<FieldEntity>> watch(String userAccountId);
}
