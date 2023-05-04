import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:uuid/uuid.dart';

main() {
  late AppDatabase appDatabase;
  late EntryTextsDao entryTextsDao;
  String id = const Uuid().v4();
  String value = "value";
  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    entryTextsDao = EntryTextsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create an EntryText", () {
    test("Invalid EntryText: id is an invalid UUID v4", () {
      var entryText = EntryText(id: "ehohw", value: value);
      expect(() async {
        await entryTextsDao.create(entryText.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No EntryText with the same 'id'", () async {
      var entryText = EntryText(id: id, value: value + "t");
      var entryText1 = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText.toCompanion(true));
      expect(() async {
        await entryTextsDao.create(entryText1.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test(
        "Invalid EntryText: value length is less than the minimum number of characters",
        () {
      var entryText = EntryText(id: id, value: "");
      expect(() async {
        await entryTextsDao.create(entryText.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
      entryText = EntryText(id: id, value: " ");
      expect(() async {
        await entryTextsDao.create(entryText.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test(
        "Invalid EntryText: value length is more than the maximum number of characters",
        () {
      var entryText = EntryText(id: id, value: "w" * 2001);
      expect(() async {
        await entryTextsDao.create(entryText.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test("Creating EntryText with the same 'value'", () async {
      var entryText = EntryText(id: id, value: value);
      var entryText1 = EntryText(id: const Uuid().v4(), value: value);
      expect(() async {
        await entryTextsDao.create(entryText.toCompanion(true));
        await entryTextsDao.create(entryText1.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test("Good case", () async {
      var entryText = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText.toCompanion(true));
    });

    test("Good case: Creating EntryText without giving an 'id'", () async {
      var entryTextsCompanion = EntryTextsCompanion(value: Value(value));
      await entryTextsDao.create(entryTextsCompanion);
      List<EntryText> entryTexts = await entryTextsDao.getAll();
      expect(isValid(entryTexts[0].id), true);
    });
  });

  group("Getting EntryText", () {
    test("Get an EntryText by id: not found", () async {
      expect(await entryTextsDao.getById(id), equals(null));
    });

    test("Get an EntryText by id: Good case", () async {
      var entryText = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText.toCompanion(true));
      var gettedEntryText = await entryTextsDao.getById(id);
      expect(gettedEntryText, isNot(null));
      expect(gettedEntryText!.id, entryText.id);
      expect(gettedEntryText!.value, entryText.value);
    });

    test("Get all EntryText", () async {
      var entryTextsCompanion = EntryTextsCompanion(value: Value(value));
      var entryTextsCompanion2 =
          EntryTextsCompanion(value: Value(value + "x2"));
      var entryTextsCompanion3 =
          EntryTextsCompanion(value: Value(value + "x3"));
      await entryTextsDao.create(entryTextsCompanion);
      await entryTextsDao.create(entryTextsCompanion2);
      await entryTextsDao.create(entryTextsCompanion3);
      var entryTexts = await entryTextsDao.getAll();
      expect(entryTexts.length, 3);
      expect(entryTexts[0].value, value);
      expect(entryTexts[1].value, value + "x2");
      expect(entryTexts[2].value, value + "x3");
    });

    test("Get all EntryText: nothing found", () async {
      var entryTexts = await entryTextsDao.getAll();
      expect(entryTexts.length, 0);
    });
  });

  group("Delete an EntryText", () {
    test("Good case1: when not found there is no error", () async {
      await entryTextsDao.remove(id);
    });

    test("Good case2", () async {
      var entryText = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText.toCompanion(true));
      await entryTextsDao.remove(id);
      expect(await entryTextsDao.getById(id), equals(null));
    });
  });
}
