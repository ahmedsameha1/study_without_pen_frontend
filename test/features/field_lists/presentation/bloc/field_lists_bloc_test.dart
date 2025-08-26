import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';

class MockWatchFieldUsecase extends Mock implements WatchFieldUsecase {}

class MockWatchFieldListsUsecase extends Mock
    implements WatchFieldListsUsecase {}

class FakeFieldEntity extends Fake implements FieldEntity {}

class FakeFieldListEntity extends Fake implements FieldListEntity {}

void main() {
  String fieldId = 'wetowho0tgu';
  FieldEntity mockFieldEntity = FieldEntity('wetowho0tgu', 'weohofh',
      'fieldName', DateTime.now(), DateTime.now(), 10, 10);
  List<FieldListEntity> mockFieldListEntities = [
    FieldListEntity(
        id: 'wofhweohg',
        fieldId: fieldId,
        name: "field list name 1",
        creationAt: DateTime(2020),
        lastModificationAt: DateTime(2020)),
    FieldListEntity(
        id: 'e3wngwgpwertpweortk',
        fieldId: fieldId,
        name: 'field list name 2',
        creationAt: DateTime(2021),
        lastModificationAt: DateTime(2021)),
    FieldListEntity(
        id: 'weofwheofhweofjwelfmwofise',
        fieldId: fieldId,
        name: 'field list name 3',
        creationAt: DateTime(2022),
        lastModificationAt: DateTime(2022))
  ];
  late WatchFieldUsecase watchFieldUsecase;
  late WatchFieldListsUsecase watchFieldListsUsecase;

  setUpAll(() {
    registerFallbackValue(FakeFieldEntity());
    registerFallbackValue(FakeFieldListEntity());
  });

  setUp(() {
    watchFieldUsecase = MockWatchFieldUsecase();
    watchFieldListsUsecase = MockWatchFieldListsUsecase();
    when(() => watchFieldUsecase.call(fieldId))
        .thenAnswer((_) => Stream.value(mockFieldEntity));
    when(() => watchFieldListsUsecase.call(fieldId))
        .thenAnswer((_) => Stream.value(mockFieldListEntities));
  });

  FieldListsBloc buildBloc() {
    return FieldListsBloc(watchFieldUsecase, watchFieldListsUsecase);
  }

  test('FieldListsBloc has a correct initial state', () {
    expect(buildBloc().state, const FieldListsState());
  });

  blocTest<FieldListsBloc, FieldListsState>(
    'starts listening to what watchFieldUsecase.call() returns',
    build: buildBloc,
    act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldId)),
    verify: (_) {
      verify(() => watchFieldUsecase.call(fieldId)).called(1);
      verify(() => watchFieldListsUsecase.call(fieldId)).called(1);
    },
  );

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with updated status and field name '
      'when watchFieldUsecase.call() stream emits a field '
      'and watchFieldListsUsecase.call stream emits a list of field lists',
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldId)),
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(
              status: FieldListsStatus.success,
              fieldName: 'fieldName',
            ),
            FieldListsState(
                status: FieldListsStatus.success,
                fieldName: 'fieldName',
                fieldLists: mockFieldListEntities),
          ]);

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with failure status'
      'when watchFieldUsecase.call() stream of null',
      setUp: () {
        when(() => watchFieldUsecase.call(fieldId))
            .thenAnswer((_) => Stream.value(null));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldId)),
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(status: FieldListsStatus.failure)
          ]);

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with failure status'
      'when watchFieldUsecase.call() stream emits error',
      setUp: () {
        when(() => watchFieldUsecase.call(fieldId))
            .thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldId)),
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(status: FieldListsStatus.failure)
          ]);

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with failure status'
      'when watchFieldUsecase.call() throws an exception',
      setUp: () {
        when(() => watchFieldUsecase.call(fieldId))
            .thenThrow(SqliteException(1, 'sqlexception'));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldId)),
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(status: FieldListsStatus.failure)
          ]);
}
