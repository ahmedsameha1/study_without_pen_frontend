import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_tests_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FullyRandomTestsDao fullyRandomTestsDao;
  String id = Uuid().v4();
  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fullyRandomTestsDao = FullyRandomTestsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a FullyRandomTests", () {
    test("Invalid FullyRandomTests: id is an invalid UUID v4", () {
      var fullyRandomTest = FullyRandomTest(id: "owhoweh");
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No FullyRandomTests with the same id", () async {
      var fullyRandomTest1 = FullyRandomTest(id: id);
      var fullyRandomTest2 = FullyRandomTest(id: id);
      await fullyRandomTestsDao.create(fullyRandomTest1.toCompanion(true));
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Good case: create FullyRandomTest without 'id'", () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion();
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });
  });
}
