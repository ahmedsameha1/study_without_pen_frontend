import 'package:rxdart/rxdart.dart';

import '../../../field_lists/data/repositories/field_lists_repository.dart';
import '../../data/repositories/entries_repository.dart';
import '../models/entries_page_data.dart';
import '../models/entry_entity.dart';

class WatchEntriesUsecase {
  const WatchEntriesUsecase(
    this._fieldListsRepository,
    this._entriesRepository,
  );
  final FieldListsRepository _fieldListsRepository;
  final EntriesRepository _entriesRepository;
  Stream<EntriesPageData> watchData(String fieldListId) => Rx.combineLatest2(
    _entriesRepository.watch(fieldListId),
    _fieldListsRepository.watchFieldList(fieldListId),
    (entries, fieldList) =>
        EntriesPageData(fieldList: fieldList!, entries: entries),
  );

  Stream<List<EntryEntity>> watchSearchData(String fieldListId, String text) =>
      _entriesRepository.search(fieldListId, text);
}
