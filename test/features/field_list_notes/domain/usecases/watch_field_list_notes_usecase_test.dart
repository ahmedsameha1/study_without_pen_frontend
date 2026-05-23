import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/data/repositories/field_list_notes_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_note_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_notes_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/usecases/watch_field_list_notes_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockFieldListNoteRepository extends Mock
    implements FieldListNotesRepository {}

class MockFieldListRepository extends Mock implements FieldListsRepository {}

void main() {
  FieldListNotesRepository fieldListNotesRepository =
      MockFieldListNoteRepository();
  FieldListsRepository fieldListsRepository = MockFieldListRepository();
  WatchFieldListNotesUsecase watchFieldListNotesUsecase =
      WatchFieldListNotesUsecase(
        fieldListsRepository,
        fieldListNotesRepository,
      );
  final fieldListId = const Uuid().v4();
  DateTime creationAt = DateTime(2025);
  DateTime creationAt1 = DateTime(2024);
  final fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'field list name1',
    creationAt: creationAt1,
    lastModificationAt: creationAt1,
  );
  FieldListNoteEntity fieldListNoteEntity = FieldListNoteEntity(
    id: const Uuid().v4(),
    fieldListId: fieldListEntity.id!,
    text: 'Field List note 1',
    creationAt: creationAt,
    lastModificationAt: creationAt,
  );
  test(
    'call() throws what FieldListNotesRepository.watchFieldListNotes() throw',
    () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => Stream.value(fieldListEntity));
      when(
        () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
      ).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      expect(
        () => watchFieldListNotesUsecase.call(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.message == 'sqlexception' &&
                e.extendedResultCode == 1,
          ),
        ),
      );
    },
  );

  test('call() throws what FieldListsRepository.watchFieldList() throw', () {
    when(() => fieldListsRepository.watchFieldList(fieldListId)).thenThrow(
      SqliteException(extendedResultCode: 1, message: 'sqlexception'),
    );
    when(
      () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
    ).thenAnswer((_) => Stream.value([fieldListNoteEntity]));
    expect(
      () => watchFieldListNotesUsecase.call(fieldListId),
      throwsA(
        predicate(
          (e) =>
              e is SqliteException &&
              e.message == 'sqlexception' &&
              e.extendedResultCode == 1,
        ),
      ),
    );
  });

  test(
    'call() throws what FieldListNotesRepository.watchFieldListNotes() throw 2',
    () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => Stream.value(fieldListEntity));
      when(
        () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
      ).thenAnswer((_) => Stream<List<FieldListNoteEntity>>.error('Not Found'));
      expect(
        watchFieldListNotesUsecase.call(fieldListId),
        emitsError(predicate((e) => e is String && e == 'Not Found')),
      );
    },
  );

  test('call() throws what FieldListsRepository.watchFieldList() throw 2', () {
    when(
      () => fieldListsRepository.watchFieldList(fieldListId),
    ).thenAnswer((_) => Stream.error('Not Found'));
    when(
      () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
    ).thenAnswer((_) => Stream.value([fieldListNoteEntity]));
    expect(
      watchFieldListNotesUsecase.call(fieldListId),
      emitsError(predicate((e) => e is String && e == 'Not Found')),
    );
  });

  test('''call() returns what FieldListNotesRepository.watchFieldListNotes() '''
      ''' FieldListsRepository.watchFieldList() return''', () {
    when(
      () => fieldListsRepository.watchFieldList(fieldListId),
    ).thenAnswer((_) => Stream.value(fieldListEntity));
    when(
      () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
    ).thenAnswer((_) => Stream.value([fieldListNoteEntity]));
    expect(
      watchFieldListNotesUsecase.call(fieldListId),
      emitsInOrder([
        FieldListNotesPageData(
          fieldList: fieldListEntity,
          fieldListNotes: [fieldListNoteEntity],
        ),
      ]),
    );
  });
}
