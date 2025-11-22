import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
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
  final fieldEntity = FieldEntity("owghoghw", "woeghwiouegfwo", "field name1",
      DateTime(2020, 1, 1), DateTime(2021, 1, 1), 0, 0xff520404);
  List<FieldListEntity> mockFieldListEntities = [
    FieldListEntity(
        id: 'wofhweohg',
        fieldId: fieldEntity.id!,
        name: "field list name 1",
        creationAt: DateTime(2020),
        lastModificationAt: DateTime(2020)),
    FieldListEntity(
        id: 'e3wngwgpwertpweortk',
        fieldId: fieldEntity.id!,
        name: 'field list name 2',
        creationAt: DateTime(2021),
        lastModificationAt: DateTime(2021)),
    FieldListEntity(
        id: 'weofwheofhweofjwelfmwofise',
        fieldId: fieldEntity.id!,
        name: 'field list name 3',
        creationAt: DateTime(2022),
        lastModificationAt: DateTime(2022))
  ];
  FieldListsPageData mockFieldListsPageData =
      FieldListsPageData(field: fieldEntity, fieldLists: mockFieldListEntities);
  late WatchFieldListsUsecase watchFieldListsUsecase;

  setUpAll(() {
    registerFallbackValue(FakeFieldEntity());
    registerFallbackValue(FakeFieldListEntity());
  });

  setUp(() {
    watchFieldListsUsecase = MockWatchFieldListsUsecase();
    when(() => watchFieldListsUsecase.call(fieldEntity.id!))
        .thenAnswer((_) => Stream.value(mockFieldListsPageData));
  });

  FieldListsBloc buildBloc() {
    return FieldListsBloc(watchFieldListsUsecase);
  }

  test('FieldListsBloc has a correct initial state', () {
    expect(buildBloc().state, const FieldListsState());
  });

  blocTest<FieldListsBloc, FieldListsState>(
    'starts listening to what watchFieldUsecase.call() returns',
    build: buildBloc,
    act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldEntity.id!)),
    verify: (_) {
      verify(() => watchFieldListsUsecase.call(fieldEntity.id!)).called(1);
    },
  );

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with status and FieldListsPageData '
      'when watchFieldListsUsecase.call stream emits FieldListsPageData',
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldEntity.id!)),
      expect: () => [
            FieldListsState(
              status: FieldListsStatus.loading,
            ),
            FieldListsState(
                status: FieldListsStatus.success,
                fieldListsPageData: mockFieldListsPageData),
          ]);

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with failure status '
      'when watchFieldListsUsecase.call stream emits '
      'a FieldListsPageDate with a null fieldName',
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldEntity.id!)),
      setUp: () {
        when(() => watchFieldListsUsecase.call(fieldEntity.id!)).thenAnswer(
            (_) => Stream.value(FieldListsPageData(
                field: null, fieldLists: mockFieldListEntities)));
      },
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(status: FieldListsStatus.failure)
          ]);

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with failure status '
      'when watchFieldListsUsecase.call stream emits an error',
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldEntity.id!)),
      setUp: () {
        when(() => watchFieldListsUsecase.call(fieldEntity.id!))
            .thenAnswer((_) => Stream.error(Exception("oops!")));
      },
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(status: FieldListsStatus.failure)
          ]);

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with failure status '
      'when watchFieldListsUsecase.call throws an exception',
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldEntity.id!)),
      setUp: () {
        when(() => watchFieldListsUsecase.call(fieldEntity.id!))
            .thenThrow((_) => SqliteException(1, "sqlexception"));
      },
      expect: () => [
            const FieldListsState(status: FieldListsStatus.loading),
            FieldListsState(status: FieldListsStatus.failure)
          ]);
}
