import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';

class MockWatchFieldUsecase extends Mock implements WatchFieldUsecase {}

class FakeFieldEntity extends Fake implements FieldEntity {}

void main() {
  FieldEntity mockFieldEntity = FieldEntity('wetowho0tgu', 'weohofh',
      'fieldName', DateTime.now(), DateTime.now(), 10, 10);
  late WatchFieldUsecase watchFieldUsecase;
  String fieldId = 'wetowho0tgu';

  setUpAll(() {
    registerFallbackValue(FakeFieldEntity());
  });

  setUp(() {
    watchFieldUsecase = MockWatchFieldUsecase();
    when(() => watchFieldUsecase.call(fieldId))
        .thenAnswer((_) => Stream.value(mockFieldEntity));
  });

  FieldListsBloc buildBloc() {
    return FieldListsBloc(watchFieldUsecase);
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
    },
  );

  blocTest<FieldListsBloc, FieldListsState>(
      'emits state with updated status and field name '
      'when watchFieldUsecase.call() stream emits a field',
      build: buildBloc,
      act: (bloc) => bloc.add(FieldListsSubscriptionRequested(fieldId)),
      expect: () => [
            const FieldListsState(FieldListsStatus.loading),
            const FieldListsState(FieldListsStatus.success, 'fieldName')
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
            const FieldListsState(FieldListsStatus.loading),
            FieldListsState(FieldListsStatus.failure)
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
            const FieldListsState(FieldListsStatus.loading),
            FieldListsState(FieldListsStatus.failure)
          ]);
}
