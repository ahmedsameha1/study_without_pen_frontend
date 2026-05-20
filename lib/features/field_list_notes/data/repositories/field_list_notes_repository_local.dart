import '../../../../database/field_list_notes_dao.dart';
import '../../domain/models/field_list_note_entity.dart';
import 'field_list_notes_repository.dart';

class FieldListNotesRepositoryLocal implements FieldListNotesRepository {
  FieldListNotesDao _fieldListNotesDao;
  FieldListNotesRepositoryLocal(this._fieldListNotesDao);
  Stream<List<FieldListNoteEntity>> watchFieldListNotes(String fieldListId) => _fieldListNotesDao
        .watchByFieldListId(fieldListId)
        .map(
          (list) => list
              .map(
                (item) => FieldListNoteEntity(
                  id: item.id,
                  fieldListId: item.fieldListId,
                  text: item.texT,
                  creationAt: item.creationAt,
                  lastModificationAt: item.lastModificationAt,
                ),
              )
              .toList(),
        );
}
