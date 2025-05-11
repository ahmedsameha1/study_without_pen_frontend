import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

class FieldRepositoryLocal implements FieldRepository {
  @override
  Future<int> create(FieldEntity fieldEntity) {
    return Future.value(1);
  }
}
