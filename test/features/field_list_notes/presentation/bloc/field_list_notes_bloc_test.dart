import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_note_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_notes_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/usecases/watch_field_list_notes_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/presentation/bloc/field_list_notes_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/presentation/bloc/field_list_notes_event.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/presentation/bloc/field_list_notes_state.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class FakeFieldListNoteEntity extends Fake implements FieldListNoteEntity {}

class MockWatchFieldListNotesUsecase extends Mock
    implements WatchFieldListNotesUsecase {}

void main() {
  final creationAt1 = DateTime(2023);
  final creationAt2 = DateTime(2024);
  final creationAt3 = DateTime(2025);
  final fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'field list name1',
    creationAt: creationAt1,
    lastModificationAt: creationAt1,
  );
  List<FieldListNoteEntity> fieldListNoteEntities = [
    FieldListNoteEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      text: 'note1',
      creationAt: creationAt1,
      lastModificationAt: creationAt1,
    ),
    FieldListNoteEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      text: 'note2',
      creationAt: creationAt2,
      lastModificationAt: creationAt2,
    ),
    FieldListNoteEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      text: 'note3',
      creationAt: creationAt3,
      lastModificationAt: creationAt3,
    ),
  ];
  late WatchFieldListNotesUsecase watchFieldListNotesUsecase;
  final fieldListNotesPageData = FieldListNotesPageData(
    fieldList: fieldListEntity,
    fieldListNotes: fieldListNoteEntities,
  );

  setUpAll(() {
    registerFallbackValue(FakeFieldListNoteEntity());
  });

  setUp(() {
    watchFieldListNotesUsecase = MockWatchFieldListNotesUsecase();
    when(
      () => watchFieldListNotesUsecase.call(fieldListEntity.id!),
    ).thenAnswer((_) => Stream.value(fieldListNotesPageData));
  });

  FieldListNotesBloc buildBloc() =>
      FieldListNotesBloc(watchFieldListNotesUsecase);

  test('FieldListNotesBloc has a correct initial state', () {
    expect(buildBloc().state, const FieldListNotesState());
  });

  blocTest<FieldListNotesBloc, FieldListNotesState>(
    'Starts listening to what WatchFieldListNotesUsecase.call return',
    build: buildBloc,
    act: (bloc) =>
        bloc.add(FieldListNotesSubscriptionRequested(fieldListEntity.id!)),
    verify: (_) => verify(
      () => watchFieldListNotesUsecase.call(fieldListEntity.id!),
    ).called(1),
  );

  blocTest<FieldListNotesBloc, FieldListNotesState>(
    'when the stream emits data',
    build: buildBloc,
    act: (bloc) =>
        bloc.add(FieldListNotesSubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      const FieldListNotesState(status: FieldListNotesStatus.loading),
      FieldListNotesState(
        status: FieldListNotesStatus.success,
        fieldListNotesPageData: fieldListNotesPageData,
      ),
    ],
  );

  blocTest<FieldListNotesBloc, FieldListNotesState>(
    'when the stream emits an error',
    setUp: () => when(
      () => watchFieldListNotesUsecase.call(fieldListEntity.id!),
    ).thenAnswer((_) => Stream.error('An error')),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(FieldListNotesSubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      const FieldListNotesState(status: FieldListNotesStatus.loading),
      const FieldListNotesState(status: FieldListNotesStatus.failure),
    ],
  );

  blocTest<FieldListNotesBloc, FieldListNotesState>(
    'when the stream throws',
    setUp: () =>
        when(
          () => watchFieldListNotesUsecase.call(fieldListEntity.id!),
        ).thenThrow(
          SqliteException(extendedResultCode: 1, message: 'sqlexception'),
        ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(FieldListNotesSubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      const FieldListNotesState(status: FieldListNotesStatus.loading),
      const FieldListNotesState(status: FieldListNotesStatus.failure),
    ],
  );
}
