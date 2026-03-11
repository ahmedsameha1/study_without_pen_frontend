import 'dart:async';
import 'dart:isolate';

import 'package:clock/clock.dart';
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

  Stream<EntriesPageData> watchEntriesForStruggling(String fieldListId) =>
      Rx.combineLatest2(
        _entriesRepository.watch(fieldListId).switchMap((list) {
          final entries = List<EntryEntity>.from(list);
          return Stream.fromFuture(
            Isolate.run(() => _prepareEntriesForStruggling(entries)),
          );
        }),
        _fieldListsRepository.watchFieldList(fieldListId),
        (entries, fieldList) =>
            EntriesPageData(fieldList: fieldList, entries: entries),
      );

  Stream<EntriesPageData> watchEntriesForToday(String fieldListId) {
    final now = clock.now();
    return Rx.combineLatest2(
      _entriesRepository.watch(fieldListId).switchMap((list) {
        final entries = List<EntryEntity>.from(list);
        return Stream.fromFuture(
          Isolate.run(() => _prepareEntriesForToday(entries, now)),
        );
      }),
      _fieldListsRepository.watchFieldList(fieldListId),
      (entries, fieldList) =>
          EntriesPageData(fieldList: fieldList, entries: entries),
    );
  }

  static List<EntryEntity> _prepareEntriesForScore(List<EntryEntity> entries) =>
      entries..sort((a, b) => b.score.compareTo(a.score));

  static List<EntryEntity> _prepareEntriesForStruggling(
    List<EntryEntity> entries,
  ) =>
      entries.where((entry) => entry.wrongness > 0.6).toList()
        ..sort((a, b) => a.score >= b.score ? -1 : 1);

  static List<EntryEntity> _prepareEntriesForToday(
    List<EntryEntity> entries,
    DateTime now,
  ) => entries
        .where(
          (entry) =>
              entry.creationAt.year == now.year &&
              entry.creationAt.month == now.month &&
              entry.creationAt.day == now.day,
        )
        .toList()
      ..sort((a, b) => b.creationAt.difference(a.creationAt).inMicroseconds);
}
