import 'dart:math';

import 'package:drift/drift.dart';
import 'package:rxdart/rxdart.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_test.dart';
import 'package:study_without_pen_by_flutter/database/uncompleted_fully_random_tests_dao.dart';

import 'session_entrys_dao.dart';

class FullyRandomTestsDao {
  static const int MINIMUM_QUESTIONS_NUMBER = 1;
  AppDatabase appDatabase;
  FullyRandomTestsDao(this.appDatabase);
  Future<void> create(
      {required int questionsNumber,
      required String id,
      required String fieldListId,
      required int currentQuestionCounter,
      required int triesNumber,
      required int triesCounter,
      required int elapsedTime,
      required bool isCompleted,
      required bool lastCheckedAnswerResult,
      required bool shouldCheckAnAnswer,
      required int currentHintCounter,
      required int wrongAnswerCounter,
      required String lastAnswer,
      required DateTime creationAt,
      required DateTime lastModificationAt,
      required int seed}) async {
    return appDatabase.transaction(() async {
      EntrysDao entrysDao = EntrysDao(appDatabase);
      SessionEntrysDao sessionEntrysDao = SessionEntrysDao(appDatabase);
      if (questionsNumber < MINIMUM_QUESTIONS_NUMBER) {
        throw InvalidDataException("questionsNumber");
      }
      UncompletedFullyRandomTestsDao uncompletedFullyRandomTestsDao =
          UncompletedFullyRandomTestsDao(appDatabase);
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await uncompletedFullyRandomTestsDao
          .create(uncompletedFullyRandomTest.toCompanion(true));
      final entries = await entrysDao.getByFieldListId(fieldListId);
      if (entries.length < questionsNumber) {
        throw InvalidDataException(
            "number of entries in fieldlist is less than questions number");
      }
      final fieldListEntries = await entrysDao.getByFieldListId(fieldListId);
      fieldListEntries.shuffle(Random(seed = seed));
      for (var i = 0; i < questionsNumber; i++) {
        var sessionEntry =
            SessionEntry(sessionId: id, entryId: fieldListEntries[i].id);
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      }
    });
  }

  Future<FullyRandomTest?> getById(String id) {
    final uncompletedFullyRandomTestStream =
        (appDatabase.select(appDatabase.uncompletedFullyRandomTests)
              ..where((tbl) => tbl.id.equals(id)))
            .watchSingle();
    //uncompleted = uncompleted!;
    final sessionEntryStream = (appDatabase.select(appDatabase.sessionEntrys)
          ..where((tbl) => tbl.sessionId.equals(id)))
        .watch()
        .map((rows) {
      return rows.map((row) {
        return row.entryId;
      }).toSet();
    });

    return Rx.combineLatest2(
        uncompletedFullyRandomTestStream, sessionEntryStream,
        (UncompletedFullyRandomTest uncompletedFullyRandomTest,
            Set<String> entries) {
      return FullyRandomTest(uncompletedFullyRandomTest, entries);
    }).first;
/*
    final query =
        appDatabase.select(appDatabase.uncompletedFullyRandomTests).join([
      leftOuterJoin(
          appDatabase.sessionEntrys,
          appDatabase.sessionEntrys.sessionId
              .equalsExp(appDatabase.uncompletedFullyRandomTests.id))
    ]);

    query.watch().map((rows) {
      return rows.map((row) {
        row.readTableOrNull(appDatabase.sessionEntrys).entryId
        return FullyRandomTest(
          row.readTable(appDatabase.uncompletedFullyRandomTests),
          //Set.from(row.readTableOrNull(appDatabase.sessionEntrys).entryId),
        );
      }).toList();
    });

    return FullyRandomTest(uncompleted, {});
    */
  }
}
