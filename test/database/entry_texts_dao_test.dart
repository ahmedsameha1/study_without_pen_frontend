import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';
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
        await entryTextsDao.create(entryText);
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("Creating EntryText with the same 'id'", () async {
      var entryText = EntryText(id: id, value: value + "t");
      var entryText1 = EntryText(id: id, value: value);
      expect(() async {
        await entryTextsDao.create(entryText);
        await entryTextsDao.create(entryText1);
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test(
        "Invalid EntryText: value length is less than the minimum number of characters",
        () {
      var entryText = EntryText(id: id, value: "");
      expect(() async {
        await entryTextsDao.create(entryText);
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
      entryText = EntryText(id: id, value: " ");
      expect(() async {
        await entryTextsDao.create(entryText);
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test(
        "Invalid EntryText: value length is more than the maximum number of characters",
        () {
      var entryText = EntryText(id: id, value: "w" * 2001);
      expect(() async {
        await entryTextsDao.create(entryText);
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("value"))));
    });

    test("Creating EntryText with the same 'value'", () async {
      var entryText = EntryText(id: id, value: value);
      var entryText1 = EntryText(id: const Uuid().v4(), value: value);
      expect(() async {
        await entryTextsDao.create(entryText);
        await entryTextsDao.create(entryText1);
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test("Good case", () async {
      var entryText = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText);
    });
  });

  group("Getting EntryText", () {
    test("Get an EntryText by id: not found", () async {
      expect(await entryTextsDao.getById(id), equals(null));
    });

    test("Get an EntryText by id: Good case", () async {
      var entryText = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText);
      var gettedEntryText = await entryTextsDao.getById(id);
      expect(gettedEntryText, isNot(null));
      expect(gettedEntryText!.id, entryText.id);
      expect(gettedEntryText!.value, entryText.value);
    });
  });

  group("Delete an EntryText", () {
    test("Good case1: when not found there is no error", () async {
      await entryTextsDao.remove(id);
    });

    test("Good case2", () async {
      var entryText = EntryText(id: id, value: value);
      await entryTextsDao.create(entryText);
      await entryTextsDao.remove(id);
      expect(await entryTextsDao.getById(id), equals(null));
    });
  });
}
