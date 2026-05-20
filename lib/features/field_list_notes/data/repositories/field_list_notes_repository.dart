import '../../domain/models/field_list_note_entity.dart';

abstract class FieldListNotesRepository {
  Stream<List<FieldListNoteEntity>> watchFieldListNotes(String fieldListId);
}
