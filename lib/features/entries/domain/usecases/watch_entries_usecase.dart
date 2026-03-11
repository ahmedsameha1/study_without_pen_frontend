import 'dart:async';
import 'dart:isolate';

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
  Stream<EntriesPageData> watchEntriesForScore(String fieldListId) =>
      Rx.combineLatest2(
        _entriesRepository.watch(fieldListId).switchMap((list) {
          final entries = List<EntryEntity>.from(list);
          return Stream.fromFuture(
            Isolate.run(() => _prepareEntriesForScore(entries)),
          );
        }),
        _fieldListsRepository.watchFieldList(fieldListId),
        (entries, fieldList) =>
            EntriesPageData(fieldList: fieldList, entries: entries),
      );

  static List<EntryEntity> _prepareEntriesForScore(List<EntryEntity> entries) =>
      entries..sort((a, b) => b.score.compareTo(a.score));
}
