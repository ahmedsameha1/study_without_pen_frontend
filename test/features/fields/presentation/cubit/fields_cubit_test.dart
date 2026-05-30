import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/cubit/fields_cubit.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/cubit/fields_state.dart';

class MockWatchFieldsUseCase extends Mock
    implements WatchFieldsWithFieldListsCountUsecase {}

void main() {
  WatchFieldsWithFieldListsCountUsecase watchFieldsUsecase =
      MockWatchFieldsUseCase();
  String userAccountId = "wefgweho";
  final id = "wefohweo";
  String name = "field name";
  final usageCount = 0;
  int color = 0xff520404;
  DateTime creationAt = DateTime(2020, 1, 1);

  test('has the correct initial state', () {
    FieldsCubit fieldsCubit = FieldsCubit(watchFieldsUsecase);
    expect(fieldsCubit.state, FieldsState());
  });

  blocTest(
    '''When WatchFieldsUsecase.call throws then state should be 
       FieldsState(FieldsStateStatus.loading, [])
       then FieldsState(FieldsStateStatus.failure, []))''',
    build: () {
      when(() => watchFieldsUsecase.call(userAccountId)).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      return FieldsCubit(watchFieldsUsecase);
    },
    act: (bloc) => bloc.watch(userAccountId),
    expect: () => [
      FieldsState(StateStatus.loading, []),
      FieldsState(StateStatus.failure, []),
    ],
  );

  blocTest(
    '''When WatchFieldsUsecase.call return a Stream<List<FieldEntity>>
       then state should be 
       FieldsState(StateStatus.loading, [])
       FieldsState(StateStatus.success, the returned List of FieldEntity)''',
    build: () {
      when(() => watchFieldsUsecase.call(userAccountId)).thenAnswer(
        (_) => Stream.value([
          (
            FieldEntity(
              id,
              userAccountId,
              name,
              creationAt,
              creationAt,
              usageCount,
              color,
            ),
            3,
          ),
        ]),
      );
      return FieldsCubit(watchFieldsUsecase);
    },
    act: (bloc) => bloc.watch(userAccountId),
    expect: () => [
      FieldsState(StateStatus.loading, []),
      FieldsState(StateStatus.success, [
        (
          FieldEntity(
            id,
            userAccountId,
            name,
            creationAt,
            creationAt,
            usageCount,
            color,
          ),
          3,
        ),
      ]),
    ],
  );
}
