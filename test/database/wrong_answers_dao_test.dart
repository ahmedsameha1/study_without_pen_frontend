import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/wrong_answers_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late WrongAnswersDao wrongAnswersDao;
  late String entryId = const Uuid().v4();
  late String sessionId = const Uuid().v4();

  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    wrongAnswersDao = WrongAnswersDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create wrongAnswer", () {
    test("Invalid wrongAnswer: sessionId is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(sessionId: "owfbhwe", entryId: entryId);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });

    test("Invalid wrongAnswer: sessionId doesn't exist in sessions table", () {
      final wrongAnswer = WrongAnswer(sessionId: sessionId, entryId: entryId);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });
  });
}
