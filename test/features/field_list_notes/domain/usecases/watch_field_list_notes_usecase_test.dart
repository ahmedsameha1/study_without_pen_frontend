import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/data/repositories/field_list_notes_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_note_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/usecases/watch_field_list_notes_usecase.dart';
import 'package:uuid/uuid.dart';

class MockFieldListNoteRepository extends Mock
    implements FieldListNotesRepository {}

void main() {
  FieldListNotesRepository fieldListNotesRepository =
      MockFieldListNoteRepository();
  WatchFieldListNotesUsecase watchFieldListNotesUsecase =
      WatchFieldListNotesUsecase(fieldListNotesRepository);
  final fieldListId = const Uuid().v4();
  DateTime creationAt = DateTime(2025);
  FieldListNoteEntity fieldListNoteEntity = FieldListNoteEntity(
    id: const Uuid().v4(),
    fieldListId: fieldListId,
    text: 'Field List note 1',
    creationAt: creationAt,
    lastModificationAt: creationAt,
  );
  test(
    'call() throws what FieldListNotesRepository.watchFieldListNotes() throw',
    () {
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

  test(
    'call() throws what FieldListNotesRepository.watchFieldListNotes() throw',
    () {
      when(
        () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
      ).thenAnswer((_) => Stream<List<FieldListNoteEntity>>.error('Not Found'));
      expect(
        watchFieldListNotesUsecase.call(fieldListId),
        emitsError(predicate((e) => e is String && e == 'Not Found')),
      );
    },
  );

  test(
    'call() returns what FieldListNotesRepository.watchFieldListNotes() return',
    () {
      when(
        () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
      ).thenAnswer((_) => Stream.value([fieldListNoteEntity]));
      expect(
        watchFieldListNotesUsecase.call(fieldListId),
        emitsInOrder([
          [fieldListNoteEntity],
        ]),
      );
    },
  );
}
