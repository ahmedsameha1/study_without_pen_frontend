import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_state.dart';

class MockCreateFieldListUsecase extends Mock
    implements CreateFieldListUsecase {}

class FakeFieldList extends Fake implements FieldListEntity {}

void main() {
  String fieldId = "woeghweo";
  String fieldListName = "field list name";
  CheckType checkType = CheckType.NON_STRICT_IGNORE_CASE;
  bool readAnswer = false;
  int color = Colors.white.toARGB32();
  late CreateFieldListUsecase createFieldListUsecase;

  setUpAll(() {
    registerFallbackValue(FakeFieldList());
  });

  setUp(() {
    createFieldListUsecase = MockCreateFieldListUsecase();
  });

  CreateFieldListBloc buildBloc() {
    return CreateFieldListBloc(createFieldListUsecase, fieldId);
  }

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated name 1',
    build: buildBloc,
    act: (bloc) =>
        bloc.add(const CreateFieldListNameChanged('field list name')),
    expect: () => const [CreateFieldListState(name: 'field list name')],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated name 2',
    build: buildBloc,
    seed: () => CreateFieldListState(
      name: 'hi',
      checkType: CheckType.IGNORE_CASE,
      readAnswer: true,
      color: Colors.green.toARGB32(),
    ),
    act: (bloc) =>
        bloc.add(const CreateFieldListNameChanged('field list name')),
    expect: () => [
      CreateFieldListState(
        name: 'field list name',
        checkType: CheckType.IGNORE_CASE,
        readAnswer: true,
        color: Colors.green.toARGB32(),
      ),
    ],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated CheckType 1',
    build: buildBloc,
    act: (bloc) => bloc.add(
      const CreateFieldListCheckTypeChanged(CheckType.DO_NOT_IGNORE_CASE),
    ),
    expect: () => const [
      CreateFieldListState(checkType: CheckType.DO_NOT_IGNORE_CASE),
    ],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated CheckType 2',
    build: buildBloc,
    seed: () => CreateFieldListState(
      name: 'field list name',
      checkType: CheckType.IGNORE_CASE,
      readAnswer: true,
      color: Colors.green.toARGB32(),
    ),
    act: (bloc) => bloc.add(
      const CreateFieldListCheckTypeChanged(CheckType.DO_NOT_IGNORE_CASE),
    ),
    expect: () => [
      CreateFieldListState(
        name: 'field list name',
        checkType: CheckType.DO_NOT_IGNORE_CASE,
        readAnswer: true,
        color: Colors.green.toARGB32(),
      ),
    ],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated readAnswer 1',
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldListReadAnswerChanged(true)),
    expect: () => const [CreateFieldListState(readAnswer: true)],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated readAnswer 2',
    build: buildBloc,
    seed: () => CreateFieldListState(
      name: 'field list name',
      checkType: CheckType.IGNORE_CASE,
      readAnswer: false,
      color: Colors.green.toARGB32(),
    ),
    act: (bloc) => bloc.add(const CreateFieldListReadAnswerChanged(true)),
    expect: () => [
      CreateFieldListState(
        name: 'field list name',
        checkType: CheckType.IGNORE_CASE,
        readAnswer: true,
        color: Colors.green.toARGB32(),
      ),
    ],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated color 1',
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateFieldListColorChanged(Colors.grey.toARGB32())),
    expect: () => [CreateFieldListState(color: Colors.grey.toARGB32())],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'emits new state with updated color 2',
    build: buildBloc,
    seed: () => CreateFieldListState(
      name: 'field list name',
      checkType: CheckType.IGNORE_CASE,
      readAnswer: true,
      color: Colors.green.toARGB32(),
    ),
    act: (bloc) =>
        bloc.add(CreateFieldListColorChanged(Colors.grey.toARGB32())),
    expect: () => [
      CreateFieldListState(
        name: 'field list name',
        checkType: CheckType.IGNORE_CASE,
        readAnswer: true,
        color: Colors.grey.toARGB32(),
      ),
    ],
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'Calls the usecase with the current state when submission: succesful case',
    build: buildBloc,
    setUp: () {
      when(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
      ).thenAnswer((_) => Future.value(1));
    },
    seed: () => CreateFieldListState(
      name: fieldListName,
      checkType: checkType,
      readAnswer: readAnswer,
      color: color,
    ),
    act: (bloc) => bloc.add(CreateFieldListSubmitted()),
    expect: () => [
      CreateFieldListState(
        status: CreateFieldListStatus.loading,
        name: fieldListName,
        checkType: checkType,
        readAnswer: readAnswer,
        color: color,
      ),
      CreateFieldListState(
        status: CreateFieldListStatus.success,
        name: fieldListName,
        checkType: checkType,
        readAnswer: readAnswer,
        color: color,
      ),
    ],
    verify: (bloc) {
      verify(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
      ).called(1);
    },
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'Calls the usecase with the current state when submission: failure case 1',
    build: buildBloc,
    setUp: () {
      when(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
      ).thenThrow((_) => SqliteException(1, 'sqliteexception'));
    },
    seed: () => CreateFieldListState(
      name: fieldListName,
      checkType: checkType,
      readAnswer: readAnswer,
      color: color,
    ),
    act: (bloc) => bloc.add(CreateFieldListSubmitted()),
    expect: () => [
      CreateFieldListState(
        status: CreateFieldListStatus.loading,
        name: fieldListName,
        checkType: checkType,
        readAnswer: readAnswer,
        color: color,
      ),
      CreateFieldListState(
        status: CreateFieldListStatus.failure,
        name: fieldListName,
        checkType: checkType,
        readAnswer: readAnswer,
        color: color,
      ),
    ],
    verify: (bloc) {
      verify(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
      ).called(1);
    },
  );

  blocTest<CreateFieldListBloc, CreateFieldListState>(
    'Calls the usecase with the current state when submission: failure case 2',
    build: buildBloc,
    setUp: () {
      when(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
      ).thenAnswer((_) => Future.error(SqliteException(1, 'sqliteexception')));
    },
    seed: () => CreateFieldListState(
      name: fieldListName,
      checkType: checkType,
      readAnswer: readAnswer,
      color: color,
    ),
    act: (bloc) => bloc.add(CreateFieldListSubmitted()),
    expect: () => [
      CreateFieldListState(
        status: CreateFieldListStatus.loading,
        name: fieldListName,
        checkType: checkType,
        readAnswer: readAnswer,
        color: color,
      ),
      CreateFieldListState(
        status: CreateFieldListStatus.failure,
        name: fieldListName,
        checkType: checkType,
        readAnswer: readAnswer,
        color: color,
      ),
    ],
    verify: (bloc) {
      verify(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
      ).called(1);
    },
  );
}
