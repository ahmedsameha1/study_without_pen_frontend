import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/create_field_cubit.dart';
import 'package:uuid/uuid.dart';

class MockCreateFieldUseCase extends Mock implements CreateFieldUseCase {}

void main() {
  late CreateFieldUseCase createFieldUseCase;
  late CreateFieldCubit createFieldCubit;
  DateTime creationAt = DateTime(2020, 1, 1);
  final fieldId = const Uuid().v4();
  String name = "";
  int usageCount = 0;
  int color = 0xff520404;
  String userId = "wofhwoef";

  test('has the correct initial state', () {
    createFieldUseCase = MockCreateFieldUseCase();
    createFieldCubit = CreateFieldCubit(createFieldUseCase);
    expect(createFieldCubit.state, CreateFieldState.initial);
  });

  blocTest<CreateFieldCubit, CreateFieldState>('''
    When calling CreateFieldUseCase.call() throws an ArgumentError then the state
    should be CreateFieldState.failure then CreateFieldState.initial''',
      build: () {
        createFieldUseCase = MockCreateFieldUseCase();
        when(() => createFieldUseCase.call(
            fieldId,
            userId,
            name,
            creationAt,
            creationAt,
            usageCount,
            color)).thenThrow(ArgumentError('Field name cannot be blank'));
        return createFieldCubit = CreateFieldCubit(createFieldUseCase);
      },
      act: (cubit) => cubit.createField(
          fieldId, userId, name, creationAt, creationAt, usageCount, color),
      expect: () => [CreateFieldState.validationFailure, CreateFieldState.initial]);

  blocTest<CreateFieldCubit, CreateFieldState>('''
    When calling CreateFieldUseCase.call() throws an error other than ArgumentError 
    then the state should be CreateFieldState.failure then CreateFieldState.initial''',
      build: () {
        name = "field name";
        createFieldUseCase = MockCreateFieldUseCase();
        when(() => createFieldUseCase.call(
            fieldId,
            userId,
            name,
            creationAt,
            creationAt,
            usageCount,
            color)).thenThrow(SqliteException(1, 'Error from database'));
        return createFieldCubit = CreateFieldCubit(createFieldUseCase);
      },
      act: (cubit) => cubit.createField(
          fieldId, userId, name, creationAt, creationAt, usageCount, color),
      expect: () => [CreateFieldState.persistanceFailure, CreateFieldState.initial]);

  blocTest<CreateFieldCubit, CreateFieldState>('''
    When calling CreateFieldUseCase.call() return a future of void
    should be CreateFieldState.success then CreateFieldState.initial''',
      build: () {
        name = "field name";
        createFieldUseCase = MockCreateFieldUseCase();
        when(() => createFieldUseCase.call(
            fieldId,
            userId,
            name,
            creationAt,
            creationAt,
            usageCount,
            color)).thenAnswer((_) => Completer<void>().future);
        return createFieldCubit = CreateFieldCubit(createFieldUseCase);
      },
      act: (cubit) => cubit.createField(
          fieldId, userId, name, creationAt, creationAt, usageCount, color),
      expect: () => [CreateFieldState.success, CreateFieldState.initial]);
}
