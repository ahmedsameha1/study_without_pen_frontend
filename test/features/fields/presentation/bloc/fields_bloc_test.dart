import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_bloc.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_event.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_state.dart';

class MockWatchFieldsWithFieldListsCountUsecase extends Mock
    implements WatchFieldsWithFieldListsCountUsecase {}

void main() {
  WatchFieldsWithFieldListsCountUsecase watchFieldsWithFieldListsCountUsecase =
      MockWatchFieldsWithFieldListsCountUsecase();
  String userAccountId = "wefgweho";
  final id = "wefohweo";
  String name = "field name";
  final usageCount = 0;
  int color = 0xff520404;
  DateTime creationAt = DateTime(2020, 1, 1);

  FieldsBloc buildBloc() => FieldsBloc(watchFieldsWithFieldListsCountUsecase);

  setUp(() {
    watchFieldsWithFieldListsCountUsecase =
        MockWatchFieldsWithFieldListsCountUsecase();
    when(
      () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
    ).thenAnswer(
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
  });

  test('has the correct initial state', () {
    expect(buildBloc().state, FieldsState());
  });

  blocTest<FieldsBloc, FieldsState>(
    '''
    When FieldsSubscriptionRequested event is added
    WatchFieldsWithFieldListsCountUsecase.call() is called
    ''',
    build: buildBloc,
    act: (bloc) => bloc.add(FieldsSubscriptionRequested(userAccountId)),
    verify: (_) {
      verify(
        () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
      ).called(1);
    },
  );

  blocTest(
    '''When WatchFieldsWithFieldListsCountUsecase.call throws then state should be 
       FieldsState(FieldsStatus.loading, [])
       then FieldsState(FieldsStatus.failure, [])) 1''',
    setUp: () {
      when(
        () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
      ).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(FieldsSubscriptionRequested(userAccountId)),
    expect: () => [
      FieldsState(FieldsStatus.loading, []),
      FieldsState(FieldsStatus.failure, []),
    ],
  );

  blocTest(
    '''When WatchFieldsWithFieldListsCountUsecase.call throws then state should be 
       FieldsState(FieldsStatus.loading, [])
       then FieldsState(FieldsStatus.failure, [])) 2''',
    setUp: () {
      when(
        () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
      ).thenAnswer((_) => Stream.error('Opps!'));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(FieldsSubscriptionRequested(userAccountId)),
    expect: () => [
      FieldsState(FieldsStatus.loading, []),
      FieldsState(FieldsStatus.failure, []),
    ],
  );

  blocTest(
    'When WatchFieldsWithFieldListsCountUsecase.call return a Stream this bloc should emit success with data',
    build: buildBloc,
    act: (bloc) => bloc.add(FieldsSubscriptionRequested(userAccountId)),
    expect: () => [
      const FieldsState(FieldsStatus.loading),
      FieldsState(FieldsStatus.success, [
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
