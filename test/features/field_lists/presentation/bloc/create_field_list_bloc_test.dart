import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_bloc.dart';

class MockCreateFieldListUsecase extends Mock
    implements CreateFieldListUsecase {}

void main() {
  String fieldId = "woeghweo";
  String fieldListName = "field list name";
  CheckType checkType = CheckType.NON_STRICT_IGNORE_CASE;
  bool readAnswer = false;
  int color = Colors.white.toARGB32();
  late CreateFieldListUsecase createFieldListUsecase;
  setUp(() {
    createFieldListUsecase = MockCreateFieldListUsecase();
    when(() => createFieldListUsecase.call(
            fieldId, fieldListName, checkType, readAnswer, color))
        .thenAnswer((_) => Future.value(1));
  });

  CreateFieldListBloc buildBloc() {
    return CreateFieldListBloc(createFieldListUsecase);
  }
}
