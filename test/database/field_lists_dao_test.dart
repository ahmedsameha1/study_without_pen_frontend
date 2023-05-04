import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FieldListsDao fieldListsDao;
  String id = const Uuid().v4();
  String fieldId = const Uuid().v4();

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldListsDao = FieldListsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Creat a FieldList", () {
    test("Invalid FieldList: id is an invalid UUID v4", () async {
      var fieldList = FieldList(id: "eewohow", fieldId: fieldId);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No FieldList with the same id", () async {
      var fieldList1 = FieldList(id: id, fieldId: fieldId);
      var fieldList2 = FieldList(id: id, fieldId: const Uuid().v4());
      await fieldListsDao.create(fieldList1.toCompanion(true));
      expect(() async {
        await fieldListsDao.create(fieldList2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid FieldList: fieldId is an invalid UUID v4", () async {
      var fieldList = FieldList(id: id, fieldId: "ewhw");
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test("Good case: create FieldList without 'id'", () async {
      var fieldListCompanion = FieldListsCompanion(fieldId: Value(fieldId));
      await fieldListsDao.create(fieldListCompanion);
    });
  });
}
