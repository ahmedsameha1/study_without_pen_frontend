import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/cubit/create_field_cubit.dart';

class MockCreateFieldUseCase extends Mock implements CreateFieldUseCase {}

void main() {
  late CreateFieldUseCase createFieldUseCase;
  late CreateFieldCubit createFieldCubit;
  String name = "";
  int color = 0xff520404;
  String userId = "wofhwoef";

  test('has the correct initial state', () {
    createFieldUseCase = MockCreateFieldUseCase();
    createFieldCubit = CreateFieldCubit(createFieldUseCase);
    expect(createFieldCubit.state, StateStatus.initial);
  });

  blocTest<CreateFieldCubit, StateStatus>('''
    When calling CreateFieldUseCase.call() throws an AssertionError then the state
    should be CreateFieldState.validationFailure then CreateFieldState.initial''',
      build: () {
        createFieldUseCase = MockCreateFieldUseCase();
        when(() => createFieldUseCase.call(userId, name, color)).thenThrow(
            AssertionError('Field name must be between 1 and 64 characters'));
        return createFieldCubit = CreateFieldCubit(createFieldUseCase);
      },
      act: (cubit) => cubit.createField(userId, name, color),
      expect: () => [
            StateStatus.loading,
            StateStatus.validationFailure,
            StateStatus.initial
          ]);

  blocTest<CreateFieldCubit, StateStatus>('''
    When calling CreateFieldUseCase.call() throws an error other than AssertionError 
    then the state should be CreateFieldState.persistanceFailure then CreateFieldState.initial''',
      build: () {
        name = "field name";
        createFieldUseCase = MockCreateFieldUseCase();
        when(() => createFieldUseCase.call(userId, name, color))
            .thenThrow(SqliteException(1, 'Error from database'));
        return createFieldCubit = CreateFieldCubit(createFieldUseCase);
      },
      act: (cubit) => cubit.createField(userId, name, color),
      expect: () => [
            StateStatus.loading,
            StateStatus.persistenceFailure,
            StateStatus.initial
          ]);

  blocTest<CreateFieldCubit, StateStatus>('''
    When calling CreateFieldUseCase.call() return a future of int
    should be CreateFieldState.success''',
      build: () {
        name = "field name";
        createFieldUseCase = MockCreateFieldUseCase();
        when(() => createFieldUseCase.call(userId, name, color))
            .thenAnswer((_) => Future.value(1));
        return createFieldCubit = CreateFieldCubit(createFieldUseCase);
      },
      act: (cubit) => cubit.createField(userId, name, color),
      expect: () => [
            StateStatus.loading,
            StateStatus.success,
          ]);
}
