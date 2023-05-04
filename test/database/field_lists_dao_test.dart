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

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldListsDao = FieldListsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Creat a FieldList", () {
    test("Invalid FieldList: id is an invalid UUID v4", () async {
      var fieldList = FieldList(id: "eewohow");
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      }, throwsA(predicate((e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("Good case: create FieldList without 'id'", () async {
      var fieldListCompanion = FieldListsCompanion();
      await fieldListsDao.create(fieldListCompanion);
    });
  });
}
