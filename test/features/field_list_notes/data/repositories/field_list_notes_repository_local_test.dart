import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_list_notes_dao.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/data/repositories/field_list_notes_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/data/repositories/field_list_notes_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_note_entity.dart';
import 'package:uuid/uuid.dart';

class MockFieldListNoteDao extends Mock implements FieldListNotesDao {}

void main() {
  FieldListNotesDao fieldListNotesDao = MockFieldListNoteDao();
  FieldListNotesRepository fieldListNotesRepository =
      FieldListNotesRepositoryLocal(fieldListNotesDao);
  final fieldListId = const Uuid().v4();
  DateTime creationAt = DateTime(2025);
  FieldListNote fieldListNote = FieldListNote(
    id: const Uuid().v4(),
    fieldListId: fieldListId,
    texT: 'Field List note 1',
    creationAt: creationAt,
    lastModificationAt: creationAt,
  );
  test(
    'watchFieldListNotes() throws what FieldListNotesDao.watchByFieldListId() throw',
    () {
      when(() => fieldListNotesDao.watchByFieldListId(fieldListId)).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      expect(
        () => fieldListNotesRepository.watchFieldListNotes(fieldListId),
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
    'watchFieldListNotes() throws what FieldListNotesDao.watchByFieldListId() throw',
    () {
      when(
        () => fieldListNotesDao.watchByFieldListId(fieldListId),
      ).thenAnswer((_) => Stream.error('Not Found'));
      expect(
        fieldListNotesRepository.watchFieldListNotes(fieldListId),
        emitsError(predicate((e) => e is String && e == 'Not Found')),
      );
    },
  );

  test(
    'watchFieldListNotes() returns what FieldListNotesDao.watchByFieldListId() return',
    () {
      when(
        () => fieldListNotesDao.watchByFieldListId(fieldListId),
      ).thenAnswer((_) => Stream.value([fieldListNote]));
      expect(
        fieldListNotesRepository.watchFieldListNotes(fieldListId),
        emitsInOrder([
          [
            FieldListNoteEntity(
              id: fieldListNote.id,
              fieldListId: fieldListId,
              text: fieldListNote.texT,
              creationAt: fieldListNote.creationAt,
              lastModificationAt: fieldListNote.lastModificationAt,
            ),
          ],
        ]),
      );
    },
  );
}
