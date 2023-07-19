import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/uncompleted_fully_random_tests_dao.dart';

class FullyRandomTestsDao {
  AppDatabase appDatabase;
  FullyRandomTestsDao(this.appDatabase);
  Future<void> create(
      {required String id,
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
      required DateTime lastModificationAt}) async {
    await appDatabase.transaction(() async {
      EntrysDao entrysDao = EntrysDao(appDatabase);
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
      if (entries.length < 1) {
        throw InvalidDataException("FieldList has no entries");
      }
      return Future.value(null);
    });
  }
}
