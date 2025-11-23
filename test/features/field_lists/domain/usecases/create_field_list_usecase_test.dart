import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  CreateFieldListUsecase createFieldListUsecase =
      CreateFieldListUsecase(fieldListsRepository);
}
