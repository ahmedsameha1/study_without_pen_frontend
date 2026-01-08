import 'package:rxdart/rxdart.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';

class WatchEntriesUsecase {
  const WatchEntriesUsecase(
    this._fieldListsRepository,
    this._entriesRepository,
  );
  final FieldListsRepository _fieldListsRepository;
  final EntriesRepository _entriesRepository;
  Stream<EntriesPageData> call(String fieldListId) {
    return Rx.combineLatest2(
      _entriesRepository.watch(fieldListId),
      _fieldListsRepository.watchFieldList(fieldListId),
      (entries, fieldList) =>
          EntriesPageData(fieldList: fieldList!, entries: entries),
    );
  }
}
