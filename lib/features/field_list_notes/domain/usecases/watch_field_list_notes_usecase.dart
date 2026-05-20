import '../../data/repositories/field_list_notes_repository.dart';
import '../models/field_list_note_entity.dart';

class WatchFieldListNotesUsecase {
  FieldListNotesRepository _fieldListNotesRepository;
  WatchFieldListNotesUsecase(this._fieldListNotesRepository);
  Stream<List<FieldListNoteEntity>> call(String fieldListId) =>
      _fieldListNotesRepository.watchFieldListNotes(fieldListId);
}
