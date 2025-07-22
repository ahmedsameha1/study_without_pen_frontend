import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/cubit/field_lists_cubit.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/cubit/field_lists_state.dart';

class MockWatchFieldUseCase extends Mock implements WatchFieldUsecase {}

void main() {
  WatchFieldUsecase watchFieldUsecase = MockWatchFieldUseCase();
  String userAccountId = "wefgweho";
  final fieldId = "wefohweo";
  String name = "field name";
  final usageCount = 0;
  int color = 0xff520404;
  DateTime creationAt = DateTime(2020, 1, 1);
  test('has the correct initial state', () {
    FieldListsCubit fieldCubit = FieldListsCubit(watchFieldUsecase);
    expect(fieldCubit.state, FieldListsState());
  });

  blocTest(
    '''When WatchFieldUsecase.call throws then state should be 
       FieldListsState(StateStatus.loading, [])
       FieldListsState(StateStatus.failure, []))''',
    build: () {
      when(() => watchFieldUsecase.call(fieldId))
          .thenThrow(SqliteException(1, 'sqlexception'));
      return FieldListsCubit(watchFieldUsecase);
    },
    act: (bloc) => bloc.watch(fieldId),
    expect: () => [
      FieldListsState(StateStatus.loading),
      FieldListsState(StateStatus.failure)
    ],
  );

  blocTest('''When WatchFieldUsecase.call return a Stream<FieldEntity>
    then state should be
       FieldListsState(StateStatus.loading, [])
       FieldListsState(StateStatus.success, the name of the field)''', build: () {
    when(() => watchFieldUsecase.call(fieldId)).thenAnswer((_) => Stream.value(
        FieldEntity(fieldId, userAccountId, name, creationAt, creationAt,
            usageCount, color)));
    return FieldListsCubit(watchFieldUsecase);
  },
  act: (bloc) => bloc.watch(fieldId),
  expect: () => [
    FieldListsState(StateStatus.loading),
    FieldListsState(StateStatus.success, name),]
  );
}
