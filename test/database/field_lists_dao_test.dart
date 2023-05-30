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
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
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
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
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

  group("Getting FieldList by id", () {
    test("Good case: the FieldList is found", () async {
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
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      await fieldListsDao.create(fieldList.toCompanion(true));
      var gottenFieldList = await fieldListsDao.getById(id);
      gottenFieldList = gottenFieldList!;
      expect(gottenFieldList.id, id);
      expect(gottenFieldList.fieldId, fieldId);
      expect(gottenFieldList.name, name);
      expect(gottenFieldList.creationAt, creationAt);
      expect(gottenFieldList.lastModificationAt, lastModificationAt);
      expect(gottenFieldList.languageTag, languageTag);
      expect(gottenFieldList.checkType, checkType);
      expect(gottenFieldList.sortBy, sortBy);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer);
      expect(gottenFieldList.usageCount, usageCount);
      expect(gottenFieldList.color, color);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions);
      expect(gottenFieldList.emulationDays, emulationDays);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion);
    });

    test("Good case: the FieldList is not found", () async {
      var gottenFieldList = await fieldListsDao.getById(const Uuid().v4());
      expect(gottenFieldList, null);
    });

    test("test default values", () async {
      var fieldListCompanion = FieldListsCompanion(
        id: Value(id),
        fieldId: Value(fieldId),
        name: Value(name),
        creationAt: Value(creationAt),
        lastModificationAt: Value(lastModificationAt),
      );
      await fieldListsDao.create(fieldListCompanion);
      var gottenFieldList = await fieldListsDao.getById(id);
      gottenFieldList = gottenFieldList!;
      expect(gottenFieldList.languageTag, null);
      expect(gottenFieldList.checkType, CheckType.NON_STRICT_IGNORE_CASE.index);
      expect(gottenFieldList.sortBy, SortBy.CREATION_DATE_DESC.index);
      expect(gottenFieldList.doesReadAnswer, false);
      expect(gottenFieldList.usageCount, 0);
      expect(gottenFieldList.color, 0xffffffff);
      expect(gottenFieldList.emulationNumberOfQuestions, null);
      expect(gottenFieldList.emulationDays, null);
      expect(gottenFieldList.testsReadingQuestionLetterDuration, null);
      expect(gottenFieldList.testsFindingAnswerDuration, null);
      expect(gottenFieldList.testsTypingAnswerLetterDuration, null);
      expect(
          gottenFieldList.studyTillCorrectReadingQuestionLetterDuration, null);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration, null);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration, null);
      expect(gottenFieldList.testsTimeOfAnswerAction,
          TimeOfAnswerAction.NOTIFY.index);
      expect(gottenFieldList.doesObfuscateQuestion, false);
    });
  });

  group("Getting all FieldLists by fieldId", () {
    test("Six FieldLists on two fields", () async {
      var fieldId1 = const Uuid().v4();
      var fieldId2 = const Uuid().v4();
      var fieldId3 = const Uuid().v4();
      var fieldListId1 = const Uuid().v4();
      var fieldListId2 = const Uuid().v4();
      var fieldListId3 = const Uuid().v4();
      var fieldListId4 = const Uuid().v4();
      var fieldListId5 = const Uuid().v4();
      var fieldListId6 = const Uuid().v4();
      String name1 = "fieldList1";
      String name2 = "fieldList2";
      String name3 = "fieldList3";
      String name4 = "fieldList4";
      String name5 = "fieldList5";
      String name6 = "fieldList6";
      DateTime creationAt1 = DateTime.utc(2020, 1, 1);
      DateTime creationAt2 = DateTime.utc(2020, 1, 2);
      DateTime creationAt3 = DateTime.utc(2020, 2, 1);
      DateTime creationAt4 = DateTime.utc(2020, 2, 2);
      DateTime creationAt5 = DateTime.utc(2020, 3, 1);
      DateTime creationAt6 = DateTime.utc(2020, 3, 2);
      DateTime lastModificationAt1 = DateTime.utc(2021, 1, 1);
      DateTime lastModificationAt2 = DateTime.utc(2021, 1, 2);
      DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
      DateTime lastModificationAt4 = DateTime.utc(2021, 2, 2);
      DateTime lastModificationAt5 = DateTime.utc(2021, 3, 1);
      DateTime lastModificationAt6 = DateTime.utc(2021, 3, 2);
      String languageTag1 = "es";
      String languageTag2 = "en-US";
      String languageTag3 = "fr";
      String languageTag4 = "de";
      String languageTag5 = "it";
      String languageTag6 = "pt";
      int checkType1 = CheckType.NON_STRICT_IGNORE_CASE.index;
      int checkType2 = CheckType.NON_STRICT_DO_NOT_IGNORE_CASE.index;
      int checkType3 = CheckType.DO_NOT_IGNORE_CASE.index;
      int checkType4 = CheckType.IGNORE_CASE.index;
      int checkType5 = CheckType.NON_STRICT_IGNORE_CASE.index;
      int checkType6 = CheckType.NON_STRICT_DO_NOT_IGNORE_CASE.index;
      int sortBy1 = SortBy.CREATION_DATE_DESC.index;
      int sortBy2 = SortBy.ANSWER_ASC.index;
      int sortBy3 = SortBy.ANSWER_DESC.index;
      int sortBy4 = SortBy.ORDER_ASC.index;
      int sortBy5 = SortBy.ORDER_DESC.index;
      int sortBy6 = SortBy.QUESTION_ASC.index;
      bool doesReadAnswer1 = true;
      bool doesReadAnswer2 = true;
      bool doesReadAnswer3 = true;
      bool doesReadAnswer4 = false;
      bool doesReadAnswer5 = false;
      bool doesReadAnswer6 = false;
      int usageCount1 = 20;
      int usageCount2 = 30;
      int usageCount3 = 40;
      int usageCount4 = 50;
      int usageCount5 = 60;
      int usageCount6 = 70;
      int color1 = 0x55554433;
      int color2 = 0x55664433;
      int color3 = 0x55774433;
      int color4 = 0x55884433;
      int color5 = 0x55994433;
      int color6 = 0x55aa4433;
      int emulationNumberOfQuestions1 = 0;
      int emulationNumberOfQuestions2 = 1;
      int emulationNumberOfQuestions3 = 2;
      int emulationNumberOfQuestions4 = 3;
      int emulationNumberOfQuestions5 = 5;
      int emulationNumberOfQuestions6 = 6;
      String emulationDays1 = "01234";
      String emulationDays2 = "0134";
      String emulationDays3 = "0124";
      String emulationDays4 = "12345";
      String emulationDays5 = "01236";
      String emulationDays6 = "01245";
      int testsReadingQuestionLetterDuration1 = 200;
      int testsReadingQuestionLetterDuration2 = 300;
      int testsReadingQuestionLetterDuration3 = 500;
      int testsReadingQuestionLetterDuration4 = 600;
      int testsReadingQuestionLetterDuration5 = 700;
      int testsReadingQuestionLetterDuration6 = 800;
      int testsFindingAnswerDuration1 = 1000;
      int testsFindingAnswerDuration2 = 1100;
      int testsFindingAnswerDuration3 = 1200;
      int testsFindingAnswerDuration4 = 1300;
      int testsFindingAnswerDuration5 = 900;
      int testsFindingAnswerDuration6 = 800;
      int testsTypingAnswerLetterDuration1 = 100;
      int testsTypingAnswerLetterDuration2 = 200;
      int testsTypingAnswerLetterDuration3 = 300;
      int testsTypingAnswerLetterDuration4 = 400;
      int testsTypingAnswerLetterDuration5 = 600;
      int testsTypingAnswerLetterDuration6 = 700;
      int studyTillCorrectReadingQuestionLetterDuration1 = 200;
      int studyTillCorrectReadingQuestionLetterDuration2 = 300;
      int studyTillCorrectReadingQuestionLetterDuration3 = 400;
      int studyTillCorrectReadingQuestionLetterDuration4 = 500;
      int studyTillCorrectReadingQuestionLetterDuration5 = 600;
      int studyTillCorrectReadingQuestionLetterDuration6 = 700;
      int studyTillCorrectFindingAnswerDuration1 = 1000;
      int studyTillCorrectFindingAnswerDuration2 = 1100;
      int studyTillCorrectFindingAnswerDuration3 = 1200;
      int studyTillCorrectFindingAnswerDuration4 = 1300;
      int studyTillCorrectFindingAnswerDuration5 = 1400;
      int studyTillCorrectFindingAnswerDuration6 = 1500;
      int studyTillCorrectTypingAnswerLetterDuration1 = 100;
      int studyTillCorrectTypingAnswerLetterDuration2 = 200;
      int studyTillCorrectTypingAnswerLetterDuration3 = 300;
      int studyTillCorrectTypingAnswerLetterDuration4 = 400;
      int studyTillCorrectTypingAnswerLetterDuration5 = 500;
      int studyTillCorrectTypingAnswerLetterDuration6 = 600;
      int testsTimeOfAnswerAction1 = TimeOfAnswerAction.NEXT.index;
      int testsTimeOfAnswerAction2 = TimeOfAnswerAction.NEXT.index;
      int testsTimeOfAnswerAction3 = TimeOfAnswerAction.NEXT.index;
      int testsTimeOfAnswerAction4 = TimeOfAnswerAction.NOTIFY.index;
      int testsTimeOfAnswerAction5 = TimeOfAnswerAction.NOTIFY.index;
      int testsTimeOfAnswerAction6 = TimeOfAnswerAction.NOTIFY.index;
      bool doesObfuscateQuestion1 = true;
      bool doesObfuscateQuestion2 = true;
      bool doesObfuscateQuestion3 = true;
      bool doesObfuscateQuestion4 = false;
      bool doesObfuscateQuestion5 = false;
      bool doesObfuscateQuestion6 = false;
      var fieldList1 = FieldList(
          id: fieldListId1,
          fieldId: fieldId1,
          name: name1,
          creationAt: creationAt1,
          lastModificationAt: lastModificationAt1,
          languageTag: languageTag1,
          checkType: checkType1,
          sortBy: sortBy1,
          doesReadAnswer: doesReadAnswer1,
          usageCount: usageCount1,
          color: color1,
          emulationNumberOfQuestions: emulationNumberOfQuestions1,
          emulationDays: emulationDays1,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration1,
          testsFindingAnswerDuration: testsFindingAnswerDuration1,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration1,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration1,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration1,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration1,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction1,
          doesObfuscateQuestion: doesObfuscateQuestion1);
      var fieldList2 = FieldList(
          id: fieldListId2,
          fieldId: fieldId2,
          name: name2,
          creationAt: creationAt2,
          lastModificationAt: lastModificationAt2,
          languageTag: languageTag2,
          checkType: checkType2,
          sortBy: sortBy2,
          doesReadAnswer: doesReadAnswer2,
          usageCount: usageCount2,
          color: color2,
          emulationNumberOfQuestions: emulationNumberOfQuestions2,
          emulationDays: emulationDays2,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration2,
          testsFindingAnswerDuration: testsFindingAnswerDuration2,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration2,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration2,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration2,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration2,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction2,
          doesObfuscateQuestion: doesObfuscateQuestion2);
      var fieldList3 = FieldList(
          id: fieldListId3,
          fieldId: fieldId3,
          name: name3,
          creationAt: creationAt3,
          lastModificationAt: lastModificationAt3,
          languageTag: languageTag3,
          checkType: checkType3,
          sortBy: sortBy3,
          doesReadAnswer: doesReadAnswer3,
          usageCount: usageCount3,
          color: color3,
          emulationNumberOfQuestions: emulationNumberOfQuestions3,
          emulationDays: emulationDays3,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration3,
          testsFindingAnswerDuration: testsFindingAnswerDuration3,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration3,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration3,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration3,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration3,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction3,
          doesObfuscateQuestion: doesObfuscateQuestion3);
      var fieldList4 = FieldList(
          id: fieldListId4,
          fieldId: fieldId1,
          name: name4,
          creationAt: creationAt4,
          lastModificationAt: lastModificationAt4,
          languageTag: languageTag4,
          checkType: checkType4,
          sortBy: sortBy4,
          doesReadAnswer: doesReadAnswer4,
          usageCount: usageCount4,
          color: color4,
          emulationNumberOfQuestions: emulationNumberOfQuestions4,
          emulationDays: emulationDays4,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration4,
          testsFindingAnswerDuration: testsFindingAnswerDuration4,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration4,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration4,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration4,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration4,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction4,
          doesObfuscateQuestion: doesObfuscateQuestion4);
      var fieldList5 = FieldList(
          id: fieldListId5,
          fieldId: fieldId2,
          name: name5,
          creationAt: creationAt5,
          lastModificationAt: lastModificationAt5,
          languageTag: languageTag5,
          checkType: checkType5,
          sortBy: sortBy5,
          doesReadAnswer: doesReadAnswer5,
          usageCount: usageCount5,
          color: color5,
          emulationNumberOfQuestions: emulationNumberOfQuestions5,
          emulationDays: emulationDays5,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration5,
          testsFindingAnswerDuration: testsFindingAnswerDuration5,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration5,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration5,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration5,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration5,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction5,
          doesObfuscateQuestion: doesObfuscateQuestion5);
      var fieldList6 = FieldList(
          id: fieldListId6,
          fieldId: fieldId1,
          name: name6,
          creationAt: creationAt6,
          lastModificationAt: lastModificationAt6,
          languageTag: languageTag6,
          checkType: checkType6,
          sortBy: sortBy6,
          doesReadAnswer: doesReadAnswer6,
          usageCount: usageCount6,
          color: color6,
          emulationNumberOfQuestions: emulationNumberOfQuestions6,
          emulationDays: emulationDays6,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration6,
          testsFindingAnswerDuration: testsFindingAnswerDuration6,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration6,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration6,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration6,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration6,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction6,
          doesObfuscateQuestion: doesObfuscateQuestion6);
      await fieldListsDao.create(fieldList1.toCompanion(true));
      await fieldListsDao.create(fieldList2.toCompanion(true));
      await fieldListsDao.create(fieldList3.toCompanion(true));
      await fieldListsDao.create(fieldList4.toCompanion(true));
      await fieldListsDao.create(fieldList5.toCompanion(true));
      await fieldListsDao.create(fieldList6.toCompanion(true));
      var listFieldStream = fieldListsDao.watchByFieldId(fieldId1);
      var listFieldlist = await listFieldStream.first;
      expect(listFieldlist.length, 3);
      var gottenFieldList = listFieldlist[0];
      expect(gottenFieldList.id, fieldListId6);
      expect(gottenFieldList.fieldId, fieldId1);
      expect(gottenFieldList.name, name6);
      expect(gottenFieldList.creationAt, creationAt6);
      expect(gottenFieldList.lastModificationAt, lastModificationAt6);
      expect(gottenFieldList.languageTag, languageTag6);
      expect(gottenFieldList.checkType, checkType6);
      expect(gottenFieldList.sortBy, sortBy6);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer6);
      expect(gottenFieldList.usageCount, usageCount6);
      expect(gottenFieldList.color, color6);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions6);
      expect(gottenFieldList.emulationDays, emulationDays6);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration6);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration6);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration6);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration6);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration6);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration6);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction6);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion6);
      gottenFieldList = listFieldlist[1];
      expect(gottenFieldList.id, fieldListId4);
      expect(gottenFieldList.fieldId, fieldId1);
      expect(gottenFieldList.name, name4);
      expect(gottenFieldList.creationAt, creationAt4);
      expect(gottenFieldList.lastModificationAt, lastModificationAt4);
      expect(gottenFieldList.languageTag, languageTag4);
      expect(gottenFieldList.checkType, checkType4);
      expect(gottenFieldList.sortBy, sortBy4);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer4);
      expect(gottenFieldList.usageCount, usageCount4);
      expect(gottenFieldList.color, color4);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions4);
      expect(gottenFieldList.emulationDays, emulationDays4);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration4);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration4);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration4);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration4);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration4);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration4);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction4);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion4);
      gottenFieldList = listFieldlist[2];
      expect(gottenFieldList.id, fieldListId1);
      expect(gottenFieldList.fieldId, fieldId1);
      expect(gottenFieldList.name, name1);
      expect(gottenFieldList.creationAt, creationAt1);
      expect(gottenFieldList.lastModificationAt, lastModificationAt1);
      expect(gottenFieldList.languageTag, languageTag1);
      expect(gottenFieldList.checkType, checkType1);
      expect(gottenFieldList.sortBy, sortBy1);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer1);
      expect(gottenFieldList.usageCount, usageCount1);
      expect(gottenFieldList.color, color1);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions1);
      expect(gottenFieldList.emulationDays, emulationDays1);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration1);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration1);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration1);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration1);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration1);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration1);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction1);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion1);
      listFieldStream = fieldListsDao.watchByFieldId(fieldId2);
      listFieldlist = await listFieldStream.first;
      expect(listFieldlist.length, 2);
      gottenFieldList = listFieldlist[0];
      expect(gottenFieldList.id, fieldListId5);
      expect(gottenFieldList.fieldId, fieldId2);
      expect(gottenFieldList.name, name5);
      expect(gottenFieldList.creationAt, creationAt5);
      expect(gottenFieldList.lastModificationAt, lastModificationAt5);
      expect(gottenFieldList.languageTag, languageTag5);
      expect(gottenFieldList.checkType, checkType5);
      expect(gottenFieldList.sortBy, sortBy5);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer5);
      expect(gottenFieldList.usageCount, usageCount5);
      expect(gottenFieldList.color, color5);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions5);
      expect(gottenFieldList.emulationDays, emulationDays5);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration5);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration5);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration5);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration5);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration5);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration5);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction5);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion5);
      gottenFieldList = listFieldlist[1];
      expect(gottenFieldList.id, fieldListId2);
      expect(gottenFieldList.fieldId, fieldId2);
      expect(gottenFieldList.name, name2);
      expect(gottenFieldList.creationAt, creationAt2);
      expect(gottenFieldList.lastModificationAt, lastModificationAt2);
      expect(gottenFieldList.languageTag, languageTag2);
      expect(gottenFieldList.checkType, checkType2);
      expect(gottenFieldList.sortBy, sortBy2);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer2);
      expect(gottenFieldList.usageCount, usageCount2);
      expect(gottenFieldList.color, color2);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions2);
      expect(gottenFieldList.emulationDays, emulationDays2);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration2);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration2);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration2);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration2);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration2);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration2);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction2);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion2);
      listFieldStream = fieldListsDao.watchByFieldId(fieldId3);
      listFieldlist = await listFieldStream.first;
      expect(listFieldlist.length, 1);
      gottenFieldList = listFieldlist[0];
      expect(gottenFieldList.id, fieldListId3);
      expect(gottenFieldList.fieldId, fieldId3);
      expect(gottenFieldList.name, name3);
      expect(gottenFieldList.creationAt, creationAt3);
      expect(gottenFieldList.lastModificationAt, lastModificationAt3);
      expect(gottenFieldList.languageTag, languageTag3);
      expect(gottenFieldList.checkType, checkType3);
      expect(gottenFieldList.sortBy, sortBy3);
      expect(gottenFieldList.doesReadAnswer, doesReadAnswer3);
      expect(gottenFieldList.usageCount, usageCount3);
      expect(gottenFieldList.color, color3);
      expect(gottenFieldList.emulationNumberOfQuestions,
          emulationNumberOfQuestions3);
      expect(gottenFieldList.emulationDays, emulationDays3);
      expect(gottenFieldList.testsReadingQuestionLetterDuration,
          testsReadingQuestionLetterDuration3);
      expect(gottenFieldList.testsFindingAnswerDuration,
          testsFindingAnswerDuration3);
      expect(gottenFieldList.testsTypingAnswerLetterDuration,
          testsTypingAnswerLetterDuration3);
      expect(gottenFieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration3);
      expect(gottenFieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectFindingAnswerDuration3);
      expect(gottenFieldList.studyTillCorrectTypingAnswerLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration3);
      expect(gottenFieldList.testsTimeOfAnswerAction, testsTimeOfAnswerAction3);
      expect(gottenFieldList.doesObfuscateQuestion, doesObfuscateQuestion3);
    });
  });

  group("Update FieldList", () {
    setUp(() async {
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
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      await fieldListsDao.create(fieldList.toCompanion(true));
    });

    test("Invalid update: fieldId is an invalid UUID v4", () async {
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test(
        "Invalid update: name length is less than ${FieldLists.MINIMUM_LENGTH_OF_NAME}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid update: name length is less than ${FieldLists.MINIMUM_LENGTH_OF_NAME}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid update: name length is bigger than ${FieldLists.MAXIMUM_LENGTH_OF_NAME}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Invalid update: creationAt is in the future", () {
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
          await fieldListsDao.mutate(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
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
          await fieldListsDao.mutate(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
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
          await fieldListsDao.mutate(fieldList.toCompanion(true));
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("check_type"))));
    });

    test("Invalid update: sortBy is invalid", () {
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("sort_by"))));
    });

    test(
        "Invalid update: usageCount is smaller than ${FieldLists.MINIMUM_USAGE_COUNT}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test(
        "Invalid update: usageCount is bigger than ${FieldLists.MAXIMUM_USAGE_COUNT}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test("Invalid update: color is smaller than ${FieldLists.MINIMUM_COLOR}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test("Invalid update: color is bigger than ${FieldLists.MAXIMUM_COLOR}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test(
        "Invalid update: emulationNumberOfQuestions is smaller than ${FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("emulation_number_of_questions"))));
    });

    test(
        "Invalid update: emulationNumberOfQuestions is bigger than ${FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("emulation_number_of_questions"))));
    });

    test(
        "Invalid update: emulationDays contains characters other than 0 to 6",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test("Invalid update: emulationDays is empty", () async {
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test("Invalid update: emulationDays has the same digit more than once",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test(
        "Invalid update: emulationDays has the digit is not in acscending order",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("emulationDays"))));
    });

    test(
        "Invalid update: testsReadingQuestionLetterDuration is smaller than ${FieldLists.MINIMUM_TESTS_DURATIONS}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_reading_question_letter_duration"))));
    });

    test(
        "Invalid update: testsFindingAnswerDuration is smaller than ${FieldLists.MINIMUM_TESTS_DURATIONS}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_finding_answer_duration"))));
    });

    test(
        "Invalid update: testsTypingAnswerLetterDuration is smaller than ${FieldLists.MINIMUM_TESTS_DURATIONS}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("tests_typing_answer_letter_duration"))));
    });

    test(
        "Invalid update: testsReadingQuestionLetterDuration & testsFindingAnswerDuration & testsTypingAnswerLetterDuration is not consistant null wise",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message
                  .contains("tests durations is not consistant null wise"))));
    });

    test(
        "Invalid update: studyTillCorrectReadingQuestionLetterDuration is smaller than ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}",
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
        await fieldListsDao.mutate(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains(
                  "study_till_correct_reading_question_letter_duration"))));
    });
  });
}
