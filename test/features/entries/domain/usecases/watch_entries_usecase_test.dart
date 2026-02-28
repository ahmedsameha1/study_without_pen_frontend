import 'dart:async';

import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/watch_entries_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockEntriesRepository extends Mock implements EntriesRepository {}

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  DateTime aDateTime = DateTime.utc(2025);
  DateTime fieldListDateTime = DateTime(2024);
  final fieldListId = const Uuid().v4();
  final entry1Id = const Uuid().v4();
  final entry2Id = const Uuid().v4();
  final entry3Id = const Uuid().v4();
  final entry4Id = const Uuid().v4();
  FieldListEntity fieldListEntity = FieldListEntity(
    id: fieldListId,
    fieldId: const Uuid().v4(),
    name: 'field list name',
    creationAt: fieldListDateTime,
    lastModificationAt: fieldListDateTime,
  );
  List<EntryEntity> entries = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
    ),
  ];
  List<EntryEntity> entries1 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'aquestion',
      creationAt: aDateTime.add(const Duration(hours: 2)),
      lastModificationAt: aDateTime.add(const Duration(hours: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 3,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'bquestion',
      creationAt: aDateTime.add(const Duration(hours: 1)),
      lastModificationAt: aDateTime.add(const Duration(hours: 1)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'cquestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 4,
      rank: Rank.vital,
    ),
  ];
  List<EntryEntity> entries2 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: DateTime.utc(2026),
      lastModificationAt: DateTime.utc(2026),
      askedCount: 4,
      wronglyAnsweredCount: 3,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.add(const Duration(hours: 4)),
      lastModificationAt: aDateTime.add(const Duration(hours: 4)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.add(const Duration(hours: 2)),
      lastModificationAt: aDateTime.add(const Duration(hours: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 4,
      rank: Rank.vital,
    ),
  ];
  List<EntryEntity> entries3 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 3)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 3)),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.important,
      order: 1,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
      order: 1,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'aQuestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 1,
    ),
    EntryEntity(
      id: entry4Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 0,
    ),
  ];
  List<EntryEntity> entries4 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: DateTime(2024, 2, 1),
      lastModificationAt: DateTime(2024, 2, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.important,
      order: 1,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
      order: 1,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'aQuestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 1,
    ),
    EntryEntity(
      id: entry4Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2024, 3, 1),
      lastModificationAt: DateTime(2024, 3, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 0,
    ),
  ];
  List<EntryEntity> entries5 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: DateTime(2024, 2, 1),
      lastModificationAt: DateTime(2024, 2, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.important,
      order: 1,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
      order: 2,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'aQuestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 2,
    ),
    EntryEntity(
      id: entry4Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2024, 3, 1),
      lastModificationAt: DateTime(2024, 3, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 3,
    ),
  ];
  final List<EntryEntity> scoreEntries = [
    entries1[2],
    entries1[0],
    entries1[1],
  ];
  final List<EntryEntity> strugglingEntries = [entries1[2], entries1[0]];
  final List<EntryEntity> todayEntries = [entries2[1], entries2[2]];
  final List<EntryEntity> unseenEntries1 = [entries3[3], entries3[0]];
  final List<EntryEntity> unseenEntries2 = [entries4[3], entries4[0]];
  final List<EntryEntity> browseEntries = [
    entries5[0],
    entries5[2],
    entries5[1],
    entries5[3],
  ];
  EntriesRepository entriesRepository = MockEntriesRepository();
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  WatchEntriesUsecase watchEntriesUsecase = WatchEntriesUsecase(
    fieldListsRepository,
    entriesRepository,
  );

  group('watchEntriesForScore', () {
    test('throws what EntriesRepository.watch() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      expect(
        () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test('throws what FieldListsRepository.watchFieldList() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      expect(
        () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test(
      '''should emit an empty stream when any repository dependency is empty''',
      () {
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => Stream.value(entries));
        expect(
          watchEntriesUsecase.watchEntriesForScore(fieldListId),
          emitsInOrder([]),
        );

        ///
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.value(fieldListEntity));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        expect(
          watchEntriesUsecase.watchEntriesForScore(fieldListId),
          emitsInOrder([]),
        );
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should emit sequential updates when repositories yield data over time''',
      () async {
        StreamController<List<EntryEntity>> streamController =
            StreamController();
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => streamController.stream);
        final future = expectLater(
          watchEntriesUsecase.watchEntriesForScore(fieldListId),
          emitsInOrder([
            EntriesPageData(fieldList: fieldListEntity, entries: [entries[0]]),
            EntriesPageData(fieldList: fieldListEntity, entries: scoreEntries),
            EntriesPageData(fieldList: fieldListEntity, entries: [entries[1]]),
          ]),
        );
        streamController.add([entries[0]]);
        await Future.delayed(Duration(milliseconds: 10));
        streamController.add(entries1);
        await Future.delayed(Duration(milliseconds: 10));
        streamController.add([entries[1]]);
        await streamController.close();
        await future;
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should handle rapid repository updates correctly''',
      () async {
        StreamController<List<EntryEntity>> streamController =
            StreamController();
        streamController = StreamController();
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => streamController.stream);
        final future = expectLater(
          watchEntriesUsecase.watchEntriesForScore(fieldListId),
          emitsInOrder([
            EntriesPageData(fieldList: fieldListEntity, entries: scoreEntries),
          ]),
        );
        streamController.add([entries[0]]);
        streamController.add([entries[1]]);
        streamController.add(entries1);
        await streamController.close();
        await future;
      },
    );
  });

  group('watchEntriesForStruggling', () {
    test('throws what EntriesRepository.watch() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      expect(
        () => watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test('throws what FieldListsRepository.watchFieldList() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      expect(
        () => watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test(
      '''should emit an empty stream when any repository dependency is empty''',
      () {
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => Stream.value(entries));
        expect(
          watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
          emitsInOrder([]),
        );

        ///
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.value(fieldListEntity));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        expect(
          watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
          emitsInOrder([]),
        );
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should emit sequential updates when repositories yield data over time''',
      () async {
        StreamController<List<EntryEntity>> streamController =
            StreamController();
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => streamController.stream);
        final future = expectLater(
          watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
          emitsInOrder([
            EntriesPageData(fieldList: fieldListEntity, entries: [entries1[2]]),
            EntriesPageData(
              fieldList: fieldListEntity,
              entries: strugglingEntries,
            ),
          ]),
        );
        streamController.add([entries1[2]]);
        await Future.delayed(Duration(milliseconds: 10));
        streamController.add(entries1);
        await Future.delayed(Duration(milliseconds: 10));
        streamController.add([entries[1]]);
        await streamController.close();
        await future;
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should handle rapid repository updates correctly''',
      () async {
        StreamController<List<EntryEntity>> streamController =
            StreamController();
        streamController = StreamController();
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => streamController.stream);
        final future = expectLater(
          watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
          emitsInOrder([
            EntriesPageData(
              fieldList: fieldListEntity,
              entries: strugglingEntries,
            ),
          ]),
        );
        streamController.add([entries1[2]]);
        streamController.add([entries[1]]);
        streamController.add(entries1);
        await streamController.close();
        await future;
      },
    );
  });

  group('watchEntriesForToday', () {
    test('throws what EntriesRepository.watch() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      expect(
        () => watchEntriesUsecase.watchEntriesForToday(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test('throws what FieldListsRepository.watchFieldList() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      expect(
        () => watchEntriesUsecase.watchEntriesForToday(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test(
      '''should emit an empty stream when any repository dependency is empty''',
      () {
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => Stream.value(entries));
        expect(
          watchEntriesUsecase.watchEntriesForToday(fieldListId),
          emitsInOrder([]),
        );

        ///
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.value(fieldListEntity));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        expect(
          watchEntriesUsecase.watchEntriesForToday(fieldListId),
          emitsInOrder([]),
        );
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should emit sequential updates when repositories yield data over time''',
      () {
        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForToday(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: [entries2[1]],
              ),
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: todayEntries,
              ),
            ]),
          );
          streamController.add([entries2[1]]);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add(entries2);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add([entries[1]]);
          await streamController.close();
          await future;
        });
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should handle rapid repository updates correctly''',
      () {
        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          streamController = StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForToday(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: todayEntries,
              ),
            ]),
          );
          streamController.add([entries2[1]]);
          streamController.add([entries[1]]);
          streamController.add(entries2);
          await streamController.close();
          await future;
        });
      },
    );
  });

  group('watchEntriesForUnseen', () {
    test('throws what EntriesRepository.watch() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      expect(
        () => watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test('throws what FieldListsRepository.watchFieldList() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      expect(
        () => watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test(
      '''should emit an empty stream when any repository dependency is empty''',
      () {
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => Stream.value(entries));
        expect(
          watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
          emitsInOrder([]),
        );

        ///
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.value(fieldListEntity));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        expect(
          watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
          emitsInOrder([]),
        );
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should emit sequential updates when repositories yield data over time''',
      () {
        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: [entries3[3]],
              ),
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: unseenEntries1,
              ),
            ]),
          );
          streamController.add([entries3[3]]);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add(entries3);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add([entries[1]]);
          await streamController.close();
          await future;
        });

        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: [entries4[3]],
              ),
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: unseenEntries2,
              ),
            ]),
          );
          streamController.add([entries4[3]]);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add(entries4);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add([entries[1]]);
          await streamController.close();
          await future;
        });
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should handle rapid repository updates correctly''',
      () {
        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          streamController = StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: unseenEntries1,
              ),
            ]),
          );
          streamController.add([entries3[3]]);
          streamController.add([entries[1]]);
          streamController.add(entries3);
          await streamController.close();
          await future;
        });

        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          streamController = StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: unseenEntries2,
              ),
            ]),
          );
          streamController.add([entries4[3]]);
          streamController.add([entries[1]]);
          streamController.add(entries4);
          await streamController.close();
          await future;
        });
      },
    );
  });

  group('watchEntriesForBrowse', () {
    test('throws what EntriesRepository.watch() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      expect(
        () => watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test('throws what FieldListsRepository.watchFieldList() throw', () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => const Stream.empty());
      expect(
        () => watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test(
      '''should emit an empty stream when any repository dependency is empty''',
      () {
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => Stream.value(entries));
        expect(
          watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
          emitsInOrder([]),
        );

        ///
        when(
          () => fieldListsRepository.watchFieldList(fieldListId),
        ).thenAnswer((_) => Stream.value(fieldListEntity));
        when(
          () => entriesRepository.watch(fieldListId),
        ).thenAnswer((_) => const Stream.empty());
        expect(
          watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
          emitsInOrder([]),
        );
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should emit sequential updates when repositories yield data over time''',
      () {
        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: [entries5[1]],
              ),
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: browseEntries,
              ),
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: [entries[1]],
              ),
            ]),
          );
          streamController.add([entries5[1]]);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add(entries5);
          await Future.delayed(Duration(milliseconds: 10));
          streamController.add([entries[1]]);
          await streamController.close();
          await future;
        });
      },
    );

    test(
      ''''should combine field list and entry data into a unified stream of EntriesPageData '''
      '''should handle rapid repository updates correctly''',
      () {
        withClock(Clock.fixed(aDateTime), () async {
          StreamController<List<EntryEntity>> streamController =
              StreamController();
          streamController = StreamController();
          when(
            () => fieldListsRepository.watchFieldList(fieldListId),
          ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
          when(
            () => entriesRepository.watch(fieldListId),
          ).thenAnswer((_) => streamController.stream);
          final future = expectLater(
            watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
            emitsInOrder([
              EntriesPageData(
                fieldList: fieldListEntity,
                entries: browseEntries,
              ),
            ]),
          );
          streamController.add([entries5[1]]);
          streamController.add([entries[1]]);
          streamController.add(entries5);
          await streamController.close();
          await future;
        });
      },
    );
  });

  group('watchSearchData()', () {
    final String text = 'text';
    test('Throws what EntriesRepository.search() throw', () {
      when(
        () => entriesRepository.search(fieldListId, text),
      ).thenThrow(SqliteException(1, 'sqlexception1'));
      expect(
        () => watchEntriesUsecase.watchSearchData(fieldListId, text),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    });

    test('''Returns a Stream of List<EntryEntity> with what '''
        '''entriesRepository.watchSearchData() return''', () {
      when(() => entriesRepository.search(fieldListId, text)).thenAnswer(
        (_) => Stream.fromIterable([
          [entries[0]],
          [entries[0], entries[1]],
          [entries[1]],
        ]),
      );
      expect(
        watchEntriesUsecase.watchSearchData(fieldListId, text),
        emitsInOrder([
          [entries[0]],
          [entries[0], entries[1]],
          [entries[1]],
        ]),
      );
    });
  });
}
