import 'package:clock/clock.dart';
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
  String name = "fieldList1";
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  String languageTag = "en-US";
  int checkType = CheckType.NON_STRICT_IGNORE_CASE.index;
  int sortBy = SortBy.CREATION_DATE_DESC.index;
  bool doesReadAnswer = true;
  int usageCount = 20;
  int color = 0x55554433;
  int emulationNumberOfQuestions = 0;
  String emulationDays = "01234";
  int testsReadingQuestionLetterDuration = 200;
  int testsFindingAnswerDuration = 1000;
  int testsTypingAnswerLetterDuration = 100;
  int studyTillCorrectReadingQuestionLetterDuration = 200;
  int studyTillCorrectFindingAnswerDuration = 1000;
  int studyTillCorrectTypingAnswerLetterDuration = 100;
  int testsTimeOfAnswerAction = TimeOfAnswerAction.NEXT.index;
  bool doesObfuscateQuestion = true;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldListsDao = FieldListsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Creat a FieldList", () {
    test("Invalid FieldList: id is an invalid UUID v4", () async {
      var fieldList = FieldList(
          id: "eewohow",
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No FieldList with the same id", () async {
      var fieldList1 = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      var fieldList2 = FieldList(
          id: id,
          fieldId: const Uuid().v4(),
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      await fieldListsDao.create(fieldList1.toCompanion(true));
      expect(() async {
        await fieldListsDao.create(fieldList2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid FieldList: fieldId is an invalid UUID v4", () async {
      var fieldList = FieldList(
          id: id,
          fieldId: "ewhw",
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test(
        "Invalid FieldList: name length is less than ${FieldLists.MINIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid FieldList: name length is less than ${FieldLists.MINIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid FieldList: name length is bigger than ${FieldLists.MAXIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: "j" * (FieldLists.MAXIMUM_LENGTH_OF_NAME + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Invalid FieldList: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var fieldList = FieldList(
            id: id,
            fieldId: fieldId,
            name: name,
            creationAt: DateTime.utc(2023, 1, 1),
            lastModificationAt: lastModificationAt,
            languageTag: languageTag,
            checkType: checkType,
            sortBy: sortBy,
            doesReadAnswer: doesReadAnswer,
            usageCount: usageCount,
            color: color,
            emulationNumberOfQuestions: emulationNumberOfQuestions,
            emulationDays: emulationDays,
            testsReadingQuestionLetterDuration:
                testsReadingQuestionLetterDuration,
            testsFindingAnswerDuration: testsFindingAnswerDuration,
            testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
            studyTillCorrectReadingQuestionLetterDuration:
                studyTillCorrectReadingQuestionLetterDuration,
            studyTillCorrectFindingAnswerDuration:
                studyTillCorrectFindingAnswerDuration,
            studyTillCorrectTypingAnswerLetterDuration:
                studyTillCorrectTypingAnswerLetterDuration,
            testsTimeOfAnswerAction: testsTimeOfAnswerAction,
            doesObfuscateQuestion: doesObfuscateQuestion);
        expect(() async {
          await fieldListsDao.create(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException && e.message.contains("creation_at"))));
      });
    });

    test("Invalid FieldList: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2021, 1, 1)), () {
        var fieldList = FieldList(
            id: id,
            fieldId: fieldId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2022, 1, 1),
            languageTag: languageTag,
            checkType: checkType,
            sortBy: sortBy,
            doesReadAnswer: doesReadAnswer,
            usageCount: usageCount,
            color: color,
            emulationNumberOfQuestions: emulationNumberOfQuestions,
            emulationDays: emulationDays,
            testsReadingQuestionLetterDuration:
                testsReadingQuestionLetterDuration,
            testsFindingAnswerDuration: testsFindingAnswerDuration,
            testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
            studyTillCorrectReadingQuestionLetterDuration:
                studyTillCorrectReadingQuestionLetterDuration,
            studyTillCorrectFindingAnswerDuration:
                studyTillCorrectFindingAnswerDuration,
            studyTillCorrectTypingAnswerLetterDuration:
                studyTillCorrectTypingAnswerLetterDuration,
            testsTimeOfAnswerAction: testsTimeOfAnswerAction,
            doesObfuscateQuestion: doesObfuscateQuestion);
        expect(() async {
          await fieldListsDao.create(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid FieldList: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2021, 1, 1)), () {
        var fieldList = FieldList(
            id: id,
            fieldId: fieldId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2012, 1, 1),
            languageTag: languageTag,
            checkType: checkType,
            sortBy: sortBy,
            doesReadAnswer: doesReadAnswer,
            usageCount: usageCount,
            color: color,
            emulationNumberOfQuestions: emulationNumberOfQuestions,
            emulationDays: emulationDays,
            testsReadingQuestionLetterDuration:
                testsReadingQuestionLetterDuration,
            testsFindingAnswerDuration: testsFindingAnswerDuration,
            testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
            studyTillCorrectReadingQuestionLetterDuration:
                studyTillCorrectReadingQuestionLetterDuration,
            studyTillCorrectFindingAnswerDuration:
                studyTillCorrectFindingAnswerDuration,
            studyTillCorrectTypingAnswerLetterDuration:
                studyTillCorrectTypingAnswerLetterDuration,
            testsTimeOfAnswerAction: testsTimeOfAnswerAction,
            doesObfuscateQuestion: doesObfuscateQuestion);
        expect(() async {
          await fieldListsDao.create(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid FieldList: checkType is invalid", () {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: 88,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("check_type"))));
      fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: -88,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("check_type"))));
    });

    test("Invalid FieldList: sortBy is invalid", () {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: 88,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("sort_by"))));
      fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: -88,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("sort_by"))));
    });

    test(
        "Invalid FieldList: usageCount is smaller than ${FieldLists.MINIMUM_USAGE_COUNT}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: FieldLists.MINIMUM_USAGE_COUNT - 1,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test(
        "Invalid FieldList: usageCount is bigger than ${FieldLists.MAXIMUM_USAGE_COUNT}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: FieldLists.MAXIMUM_USAGE_COUNT + 1,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test("Invalid FieldList: color is smaller than ${FieldLists.MINIMUM_COLOR}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: FieldLists.MINIMUM_COLOR - 1,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test("Invalid FieldList: color is bigger than ${FieldLists.MAXIMUM_COLOR}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: FieldLists.MAXIMUM_COLOR + 1,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test(
        "Invalid FieldList: emulationNumberOfQuestions is smaller than ${FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions:
              FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS - 1,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("emulation_number_of_questions"))));
    });

    test(
        "Invalid FieldList: emulationNumberOfQuestions is bigger than ${FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions:
              FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS + 1,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("emulation_number_of_questions"))));
    });

    test(
        "Invalid FieldList: emulationDays contains characters other than 0 to 6",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: "ewins",
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
      fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: "017",
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test("Invalid FieldList: emulationDays is empty", () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: "",
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test("Invalid FieldList: emulationDays has the same digit more than once",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: "0122",
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test(
        "Invalid FieldList: emulationDays has the digit is not in acscending order",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: "06122",
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test(
        "Invalid FieldList: testsReadingQuestionLetterDuration is smaller than ${FieldLists.MINIMUM_TESTS_DURATIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              FieldLists.MINIMUM_TESTS_DURATIONS - 1,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_reading_question_letter_duration"))));
    });

    test(
        "Invalid FieldList: testsFindingAnswerDuration is smaller than ${FieldLists.MINIMUM_TESTS_DURATIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: FieldLists.MINIMUM_TESTS_DURATIONS - 1,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_finding_answer_duration"))));
    });

    test(
        "Invalid FieldList: testsTypingAnswerLetterDuration is smaller than ${FieldLists.MINIMUM_TESTS_DURATIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration:
              FieldLists.MINIMUM_TESTS_DURATIONS - 1,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_typing_answer_letter_duration"))));
    });

    test(
        "Invalid FieldList: testsReadingQuestionLetterDuration & testsFindingAnswerDuration & testsTypingAnswerLetterDuration is not consistant null wise",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: null,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message
                  .contains("tests durations is not consistant null wise"))));
    });

    test(
        "Invalid FieldList: studyTillCorrectReadingQuestionLetterDuration is smaller than ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS - 1,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains(
                  "study_till_correct_reading_question_letter_duration"))));
    });

    test(
        "Invalid FieldList: studyTillCorrectFindingAnswerDuration is smaller than ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS - 1,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message
                  .contains("study_till_correct_finding_answer_duration"))));
    });

    test(
        "Invalid FieldList: studyTillCorrectTypingAnswerLetterDuration is smaller than ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS - 1,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains(
                  "study_till_correct_typing_answer_letter_duration"))));
    });

    test(
        "Invalid FieldList: studyTillCorrectReadingQuestionLetterDuration & studyTillCorrectFindingAnswerDuration & studyTillCorrectTypingAnswerLetterDuration is not consistant null wise",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration: null,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains(
                  "study till correct durations is not consistant null wise"))));
    });

    test("Invalid FieldList: testsTimeOfAnswerAction is invalid", () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: TimeOfAnswerAction.MAX.index,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_time_of_answer_action"))));
      fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: 0 - 1,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_time_of_answer_action"))));
    });

    test("Invalid FieldList: testsTimeOfAnswerAction is invalid", () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: TimeOfAnswerAction.MAX.index + 1,
          doesObfuscateQuestion: doesObfuscateQuestion);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_time_of_answer_action"))));
    });

    test("Good case 1: create FieldList without 'id'", () async {
      var fieldListCompanion = FieldListsCompanion(
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          languageTag: Value(languageTag),
          checkType: Value(checkType),
          sortBy: Value(sortBy),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 2: create FieldList when languageTag is null", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          languageTag: Value(null),
          checkType: Value(checkType),
          sortBy: Value(sortBy),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 3: NON_STRICT_DO_NOT_IGNORE_CASE is valid checkType",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(CheckType.NON_STRICT_DO_NOT_IGNORE_CASE.index),
          sortBy: Value(sortBy),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 4: IGNORE_CASE is valid checkType", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(CheckType.IGNORE_CASE.index),
          sortBy: Value(sortBy),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 5: DO_NOT_IGNORE_CASE is valid checkType", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(CheckType.DO_NOT_IGNORE_CASE.index),
          sortBy: Value(sortBy),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 6: checkType could by ignored", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          sortBy: Value(sortBy),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 7: ANSWER_DESC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.ANSWER_DESC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 8: QUESTION_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.QUESTION_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 9: ANSWER_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.ANSWER_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 10: DATE_DESC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.DATE_DESC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 11: DATE_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.DATE_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 12: QUESTION_DESC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.QUESTION_DESC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 13: CREATION_DATE_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.CREATION_DATE_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 14: ORDER_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.ORDER_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 15: ORDER_DESC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.ORDER_DESC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 16: RANK_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.RANK_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 17: RANK_DESC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.RANK_DESC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 18: WRONGNESS_ASC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_ASC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 19: WRONGNESS_DESC is a valid sortBy", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 20: sortBy could be ignored", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          doesReadAnswer: Value(doesReadAnswer),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 21: create FieldList without doesReadAnswer", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 22: create FieldList without usageCount", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          color: Value(color),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 23: create FieldList without color", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          emulationNumberOfQuestions: Value(emulationNumberOfQuestions),
          emulationDays: Value(emulationDays),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 24: create FieldList when emulationNumberOfQuestions is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 25: create FieldList when emulationDays is null", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration:
              Value(testsReadingQuestionLetterDuration),
          testsFindingAnswerDuration: Value(testsFindingAnswerDuration),
          testsTypingAnswerLetterDuration:
              Value(testsTypingAnswerLetterDuration),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 26: create FieldList when testsReadingQuestionLetterDuration is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 27: create FieldList when testsFindingAnswerDuration is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 28: create FieldList when testsTypingAnswerLetterDuration is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration:
              Value(studyTillCorrectReadingQuestionLetterDuration),
          studyTillCorrectFindingAnswerDuration:
              Value(studyTillCorrectFindingAnswerDuration),
          studyTillCorrectTypingAnswerLetterDuration:
              Value(studyTillCorrectTypingAnswerLetterDuration),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 29: create FieldList when studyTillCorrectReadingQuestionLetterDuration is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration: Value(null),
          studyTillCorrectFindingAnswerDuration: Value(null),
          studyTillCorrectTypingAnswerLetterDuration: Value(null),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 30: create FieldList when studyTillCorrectFindingAnswerDuration is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration: Value(null),
          studyTillCorrectFindingAnswerDuration: Value(null),
          studyTillCorrectTypingAnswerLetterDuration: Value(null),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction));
      await fieldListsDao.create(fieldListCompanion);
    });

    test(
        "Good case 31: create FieldList when studyTillCorrectTypingAnswerLetterDuration is null",
        () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration: Value(null),
          studyTillCorrectFindingAnswerDuration: Value(null),
          studyTillCorrectTypingAnswerLetterDuration: Value(null),
          testsTimeOfAnswerAction: Value(testsTimeOfAnswerAction));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 32", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration: Value(null),
          studyTillCorrectFindingAnswerDuration: Value(null),
          studyTillCorrectTypingAnswerLetterDuration: Value(null),
          testsTimeOfAnswerAction: Value(TimeOfAnswerAction.NOTIFY.index));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 33, testsTimeOfAnswerAction could be ignored", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration: Value(null),
          studyTillCorrectFindingAnswerDuration: Value(null),
          studyTillCorrectTypingAnswerLetterDuration: Value(null),
          doesObfuscateQuestion: Value(doesObfuscateQuestion));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case 34, doesObfuscateQuestion could be ignored", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          checkType: Value(checkType),
          sortBy: Value(SortBy.WRONGNESS_DESC.index),
          usageCount: Value(usageCount),
          color: Value(color),
          emulationNumberOfQuestions: Value(null),
          emulationDays: Value(null),
          testsReadingQuestionLetterDuration: Value(null),
          testsFindingAnswerDuration: Value(null),
          testsTypingAnswerLetterDuration: Value(null),
          studyTillCorrectReadingQuestionLetterDuration: Value(null),
          studyTillCorrectFindingAnswerDuration: Value(null),
          studyTillCorrectTypingAnswerLetterDuration: Value(null),
          testsTimeOfAnswerAction: Value(TimeOfAnswerAction.NOTIFY.index));
      await fieldListsDao.create(fieldListCompanion);
    });
  });
}
