import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_note_entity.dart';
import 'package:uuid/uuid.dart';

void main() {
  String id = const Uuid().v4();
  String fieldListId = const Uuid().v4();
  DateTime creationAt = DateTime(2025);
  test(
    'FieldListNoteEntity id, fieldListId, creationAt, and lastModificationAt have the correct values',
    () {
      FieldListNoteEntity fieldListNoteEntity = FieldListNoteEntity(
        id: id,
        fieldListId: fieldListId,
        text: 'note',
        creationAt: creationAt,
        lastModificationAt: creationAt,
      );
      expect(fieldListNoteEntity.id, id);
      expect(fieldListNoteEntity.fieldListId, fieldListId);
      expect(fieldListNoteEntity.creationAt, creationAt);
      expect(fieldListNoteEntity.lastModificationAt, creationAt);
    },
  );

  test(
    'FieldListNoteEntity throws AssertionError when created with invalid text',
    () {
      expect(
        () => FieldListNoteEntity(
          fieldListId: fieldListId,
          text: '',
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message ==
                    'text must be between ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} and ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} characters',
          ),
        ),
      );
      expect(
        () => FieldListNoteEntity(
          fieldListId: fieldListId,
          text: ' ',
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message ==
                    'text must be between ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} and ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} characters',
          ),
        ),
      );
      expect(
        () => FieldListNoteEntity(
          fieldListId: fieldListId,
          text: '${"r" * FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} ',
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message ==
                    'text must be between ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} and ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} characters',
          ),
        ),
      );
    },
  );

  test('FieldListNoteEntity text has the correct value', () {
    final fieldListEntity = FieldListNoteEntity(
      fieldListId: fieldListId,
      text: 'note',
      creationAt: creationAt,
      lastModificationAt: creationAt,
    );
    expect(fieldListEntity.text, 'note');
  });

  test('invalid lastModificationAt', () {
    expect(
      () => FieldListNoteEntity(
        fieldListId: fieldListId,
        text: 'note',
        creationAt: creationAt,
        lastModificationAt: creationAt.subtract(const Duration(days: 2)),
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message == 'lastModification cannot be before creationAt',
        ),
      ),
    );
  });
}
