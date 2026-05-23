import 'package:rxdart/rxdart.dart';

import '../../../field_lists/data/repositories/field_lists_repository.dart';
import '../../data/repositories/field_list_notes_repository.dart';
import '../models/field_list_notes_page_data.dart';

class WatchFieldListNotesUsecase {
  FieldListNotesRepository _fieldListNotesRepository;
  FieldListsRepository _fieldListsRepository;
  WatchFieldListNotesUsecase(
    this._fieldListsRepository,
    this._fieldListNotesRepository,
  );
  Stream<FieldListNotesPageData> call(String fieldListId) => Rx.combineLatest2(
    _fieldListsRepository.watchFieldList(fieldListId),
    _fieldListNotesRepository.watchFieldListNotes(fieldListId),
    (fieldList, fieldListNotes) => FieldListNotesPageData(
      fieldList: fieldList,
      fieldListNotes: fieldListNotes,
    ),
  );
}
