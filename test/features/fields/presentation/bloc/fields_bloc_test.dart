import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/delete_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_bloc.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_event.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_state.dart';
import 'package:uuid/uuid.dart';

class MockWatchFieldsWithFieldListsCountUsecase extends Mock
    implements WatchFieldsWithFieldListsCountUsecase {}

class MockDeleteFieldUsecase extends Mock implements DeleteFieldUsecase {}

void main() {
  late WatchFieldsWithFieldListsCountUsecase
  watchFieldsWithFieldListsCountUsecase;
  late DeleteFieldUsecase deleteFieldUsecase;
  String userAccountId = "wefgweho";
  final fieldId = const Uuid().v4();
  String name = "field name";
  final usageCount = 0;
  int color = 0xff520404;
  DateTime creationAt = DateTime(2020, 1, 1);

  FieldsBloc buildBloc() =>
      FieldsBloc(watchFieldsWithFieldListsCountUsecase, deleteFieldUsecase);

  setUp(() {
    watchFieldsWithFieldListsCountUsecase =
        MockWatchFieldsWithFieldListsCountUsecase();
    when(
      () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
    ).thenAnswer(
      (_) => Stream.value([
        (
          FieldEntity(
            fieldId,
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
    deleteFieldUsecase = MockDeleteFieldUsecase();
    when(
      () => deleteFieldUsecase.call(fieldId),
    ).thenAnswer((_) => Future.value(1));
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
            fieldId,
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

  blocTest<FieldsBloc, FieldsState>(
    '''
    When DeleteField event is added
    DeleteFieldUsecase.call() is called
    ''',
    build: buildBloc,
    act: (bloc) => bloc.add(DeleteField(fieldId)),
    verify: (_) {
      verify(() => deleteFieldUsecase.call(fieldId)).called(1);
    },
  );

  blocTest(
    'When DeleteFieldUsecase.call() return a Future of an int this bloc should emit success',
    build: buildBloc,
    seed: () => FieldsState(FieldsStatus.success, [
      (
        FieldEntity(
          fieldId,
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
    act: (bloc) => bloc.add(DeleteField(fieldId)),
    expect: () => [
      FieldsState(FieldsStatus.loading, [
        (
          FieldEntity(
            fieldId,
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
      FieldsState(FieldsStatus.success, [
        (
          FieldEntity(
            fieldId,
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

  blocTest(
    'When DeleteFieldUsecase.call() throws this bloc should emit failure',
    setUp: () {
      when(() => deleteFieldUsecase.call(fieldId)).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
    },
    build: buildBloc,
    seed: () => FieldsState(FieldsStatus.success, [
      (
        FieldEntity(
          fieldId,
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
    act: (bloc) => bloc.add(DeleteField(fieldId)),
    expect: () => [
      FieldsState(FieldsStatus.loading, [
        (
          FieldEntity(
            fieldId,
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
      FieldsState(FieldsStatus.failure, [
        (
          FieldEntity(
            fieldId,
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

  blocTest(
    'When DeleteFieldUsecase.call() return a Future of error this bloc should emit failure',
    setUp: () {
      when(
        () => deleteFieldUsecase.call(fieldId),
      ).thenAnswer((_) => Future.error('Opps!'));
    },
    build: buildBloc,
    seed: () => FieldsState(FieldsStatus.success, [
      (
        FieldEntity(
          fieldId,
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
    act: (bloc) => bloc.add(DeleteField(fieldId)),
    expect: () => [
      FieldsState(FieldsStatus.loading, [
        (
          FieldEntity(
            fieldId,
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
      FieldsState(FieldsStatus.failure, [
        (
          FieldEntity(
            fieldId,
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
