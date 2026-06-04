import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/create_field_bloc.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/create_field_event.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/create_field_state.dart';
import 'package:uuid/uuid.dart';

class MockCreateFieldUseCase extends Mock implements CreateFieldUsecase {}

void main() {
  late CreateFieldUsecase createFieldUseCase;
  late CreateFieldBloc createFieldCubit;
  String name = "";
  int color = 0xff520404;
  String userAccountId = const Uuid().v4();
  name = 'field name';

  CreateFieldBloc buildBloc() =>
      CreateFieldBloc(createFieldUseCase, userAccountId);

  test('has the correct initial state', () {
    createFieldUseCase = MockCreateFieldUseCase();
    createFieldCubit = CreateFieldBloc(createFieldUseCase, userAccountId);
    expect(
      createFieldCubit.state,
      CreateFieldState(userAccountId: userAccountId),
    );
  });

  blocTest<CreateFieldBloc, CreateFieldState>(
    'When calling CreateFieldUsecase.call() throws an AssertionError',
    seed: () => CreateFieldState(
      userAccountId: userAccountId,
      name: name,
      color: color,
    ),
    setUp: () {
      createFieldUseCase = MockCreateFieldUseCase();
      when(() => createFieldUseCase.call(userAccountId, name, color)).thenThrow(
        AssertionError('Field name must be between 1 and 64 characters'),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldSubmitted()),
    expect: () => [
      CreateFieldState(
        status: CreateFieldStatus.loading,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.validationFailure,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.initial,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
    ],
  );

  blocTest<CreateFieldBloc, CreateFieldState>(
    'when calling CreateFieldUsecase.call() throws an error other than AssertionError 1',
    seed: () => CreateFieldState(
      userAccountId: userAccountId,
      name: name,
      color: color,
    ),
    setUp: () {
      createFieldUseCase = MockCreateFieldUseCase();
      when(() => createFieldUseCase.call(userAccountId, name, color)).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'Error from database'),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldSubmitted()),
    expect: () => [
      CreateFieldState(
        status: CreateFieldStatus.loading,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.persistenceFailure,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.initial,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
    ],
  );

  blocTest<CreateFieldBloc, CreateFieldState>(
    'when calling CreateFieldUsecase.call() throws an error other than AssertionError 2',
    seed: () => CreateFieldState(
      userAccountId: userAccountId,
      name: name,
      color: color,
    ),
    setUp: () {
      createFieldUseCase = MockCreateFieldUseCase();
      when(
        () => createFieldUseCase.call(userAccountId, name, color),
      ).thenAnswer((_) => Future.error('Oops!'));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldSubmitted()),
    expect: () => [
      CreateFieldState(
        status: CreateFieldStatus.loading,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.persistenceFailure,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.initial,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
    ],
  );

  blocTest<CreateFieldBloc, CreateFieldState>(
    'when calling CreateFieldUsecase.call() return a future of int',
    seed: () => CreateFieldState(
      userAccountId: userAccountId,
      name: name,
      color: color,
    ),
    setUp: () {
      createFieldUseCase = MockCreateFieldUseCase();
      when(
        () => createFieldUseCase.call(userAccountId, name, color),
      ).thenAnswer((_) => Future.value(1));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldSubmitted()),
    expect: () => [
      CreateFieldState(
        status: CreateFieldStatus.loading,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.success,
        userAccountId: userAccountId,
        name: name,
        color: color,
      ),
      CreateFieldState(
        status: CreateFieldStatus.initial,
        userAccountId: userAccountId,
      ),
    ],
  );

  blocTest<CreateFieldBloc, CreateFieldState>(
    'CreateFieldNameChanged',
    seed: () => CreateFieldState(
      status: CreateFieldStatus.initial,
      userAccountId: userAccountId,
      name: 'nam',
      color: color,
    ),
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldNameChanged('name')),
    expect: () => [
      CreateFieldState(
        status: CreateFieldStatus.initial,
        userAccountId: userAccountId,
        name: 'name',
        color: color,
      ),
    ],
  );

  blocTest<CreateFieldBloc, CreateFieldState>(
    'CreateFieldColorChanged',
    seed: () => CreateFieldState(
      status: CreateFieldStatus.initial,
      userAccountId: userAccountId,
      name: 'name',
      color: 0x00000000,
    ),
    build: buildBloc,
    act: (bloc) => bloc.add(const CreateFieldColorChanged(0xFFAABBCC)),
    expect: () => [
      CreateFieldState(
        status: CreateFieldStatus.initial,
        userAccountId: userAccountId,
        name: 'name',
        color: 0xFFAABBCC,
      ),
    ],
  );
}
