import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_test.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_tests_dao.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FullyRandomTestsDao fullyRandomTestsDao;
  late SessionsDao sessionsDao;
  late EntrysDao entrysDao;
  late FieldsDao fieldsDao;
  late FieldListsDao fieldListsDao;
  String id = Uuid().v4();
  String fieldId = const Uuid().v4();
  String fieldListId = const Uuid().v4();
  String question = "question";
  int currentQuestionCounter = 5;
  int questionsNumber = 2;
  int triesNumber = 2;
  int triesCounter = 1;
  int elapsedTime = 6000;
  bool isCompleted = true;
  bool lastCheckedAnswerResult = true;
  bool shouldCheckAnAnswer = true;
  int currentHintCounter = 0;
  int wrongAnswerCounter = 1;
  String lastAnswer = "wefw";
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  String name = "fieldList1";
  DateTime creationAt1 = DateTime.utc(2019, 1, 1);
  DateTime lastModificationAt1 = DateTime.utc(2019, 2, 2);
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
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  String name1 = "name";
  DateTime creationAt2 = DateTime(2018, 1, 1);
  DateTime lastModificationAt2 = DateTime.utc(2018, 2, 2);
  int usageCount1 = 9;
  int color1 = 0xff55ee11;
  bool doesObfuscateQuestion = true;

  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fullyRandomTestsDao = FullyRandomTestsDao(appDatabase);
    sessionsDao = SessionsDao(appDatabase);
    entrysDao = EntrysDao(appDatabase);
    fieldsDao = FieldsDao(appDatabase);
    fieldListsDao = FieldListsDao(appDatabase);
    var field = Field(
      id: fieldId,
      userAccountId: userAccountId,
      name: "${name1}2",
      creationAt: creationAt2,
      lastModificationAt: lastModificationAt2,
      usageCount: usageCount1,
      color: color1,
    );
    fieldsDao.create(field.toCompanion(true));
    var fieldList = FieldList(
      id: fieldListId,
      fieldId: fieldId,
      name: name,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      languageTag: languageTag,
      checkType: checkType,
      sortBy: sortBy,
      doesReadAnswer: doesReadAnswer,
      usageCount: usageCount,
      color: color,
      emulationNumberOfQuestions: emulationNumberOfQuestions,
      emulationDays: emulationDays,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration,
      testsFindingAnswerDuration: testsFindingAnswerDuration,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction,
      doesObfuscateQuestion: doesObfuscateQuestion,
    );
    await fieldListsDao.create(fieldList.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a FullyRandomTest", () {
    test("Invalid FullyRandomTest: invalid Session", () {
      expect(
        () async {
          await fullyRandomTestsDao.create(
            questionsNumber: questionsNumber,
            id: "wefwe",
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
            lastModificationAt: lastModificationAt,
            seed: 1,
          );
        },
        throwsA(
          predicate(
            (e) => e is InvalidDataException && e.message.contains("id"),
          ),
        ),
      );
    });

    test("Invalid FullyRandomTest: invalid TestSession", () {
      expect(
        () async {
          await fullyRandomTestsDao.create(
            questionsNumber: questionsNumber,
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
            wrongAnswerCounter: -1,
            lastAnswer: lastAnswer,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            seed: 1,
          );
        },
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.message.contains("wrong_answer_counter"),
          ),
        ),
      );
    });

    test(
      "Invalid FullyRandomTest: wrongAnswerCounter is bigger than or equal questionsNumber",
      () {
        expect(
          () async {
            await fullyRandomTestsDao.create(
              questionsNumber: questionsNumber,
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
              wrongAnswerCounter: 2,
              lastAnswer: lastAnswer,
              creationAt: creationAt,
              lastModificationAt: lastModificationAt,
              seed: 1,
            );
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException &&
                  e.message.contains(
                    "wrongAnswerCounter is bigger than or equal questionsNumber",
                  ),
            ),
          ),
        );

        expect(
          () async {
            await fullyRandomTestsDao.create(
              questionsNumber: questionsNumber,
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
              wrongAnswerCounter: 3,
              lastAnswer: lastAnswer,
              creationAt: creationAt,
              lastModificationAt: lastModificationAt,
              seed: 1,
            );
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException &&
                  e.message.contains(
                    "wrongAnswerCounter is bigger than or equal questionsNumber",
                  ),
            ),
          ),
        );
      },
    );
    test(
      "Invalid FullyRandomTest: questionsNumber is less than ${FullyRandomTestsDao.MINIMUM_QUESTIONS_NUMBER}",
      () {
        expect(
          () async {
            await fullyRandomTestsDao.create(
              questionsNumber: FullyRandomTestsDao.MINIMUM_QUESTIONS_NUMBER - 1,
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
              lastModificationAt: lastModificationAt,
              seed: 1,
            );
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException &&
                  e.message.contains("questionsNumber"),
            ),
          ),
        );
      },
    );

    test(
      "Invalid FullyRandomTest: the number of entries in fieldlist is less than questions number",
      () async {
        expect(
          () async {
            await fullyRandomTestsDao.create(
              questionsNumber: questionsNumber,
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
              lastModificationAt: lastModificationAt,
              seed: 1,
            );
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException &&
                  e.message.contains(
                    "number of entries in fieldlist is less than questions number",
                  ),
            ),
          ),
        );
      },
    );

    test(
      "Invalid FullyRandomTest: invalid Session is not created in the database",
      () async {
        try {
          await fullyRandomTestsDao.create(
            questionsNumber: questionsNumber,
            id: "wefwe",
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
            lastModificationAt: lastModificationAt,
            seed: 1,
          );
        } on InvalidDataException {}
        var gotten = await sessionsDao.getByFieldListId(fieldListId);
        expect(gotten.length, 0);
      },
    );
  });

  group("Getting FullyRandomTest by id", () {
    String id1 = const Uuid().v4();
    String id2 = const Uuid().v4();
    String id3 = const Uuid().v4();
    String id4 = const Uuid().v4();
    String fieldListId2 = const Uuid().v4();
    DateTime creationAt2 = DateTime.utc(2019, 1, 1);
    DateTime creationAt3 = DateTime.utc(2021, 1, 1);
    DateTime creationAt4 = DateTime.utc(2018, 1, 1);
    DateTime lastModificationAt2 = DateTime.utc(2019, 2, 1);
    DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
    DateTime lastModificationAt4 = DateTime.utc(2019, 2, 1);
    int rank = Rank.normal.index;
    int askedCount = 2;
    int wronglyAnsweredCount = 1;
    DateTime emulatedCreatedAt = DateTime.utc(2022, 2, 2);
    setUp(() async {
      var fieldList = FieldList(
        id: fieldListId2,
        fieldId: fieldId,
        name: "${name}f",
        creationAt: creationAt1.add(Duration(days: 10)),
        lastModificationAt: lastModificationAt1.add(Duration(days: 20)),
        languageTag: languageTag,
        checkType: checkType,
        sortBy: sortBy,
        doesReadAnswer: doesReadAnswer,
        usageCount: usageCount,
        color: color,
        emulationNumberOfQuestions: emulationNumberOfQuestions,
        emulationDays: emulationDays,
        testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration,
        testsFindingAnswerDuration: testsFindingAnswerDuration,
        testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
        studyTillCorrectReadingQuestionLetterDuration:
            studyTillCorrectReadingQuestionLetterDuration,
        studyTillCorrectFindingAnswerDuration:
            studyTillCorrectFindingAnswerDuration,
        studyTillCorrectTypingAnswerLetterDuration:
            studyTillCorrectTypingAnswerLetterDuration,
        testsTimeOfAnswerAction: testsTimeOfAnswerAction,
        doesObfuscateQuestion: doesObfuscateQuestion,
      );
      await fieldListsDao.create(fieldList.toCompanion(true));
      final answer1 = "answer1";
      final answer2 = "answer2";
      final answer3 = "answer3";
      final answer4 = "answer4";
      final question2 = "text2";
      final question3 = "text3";
      final question4 = "text4";
      var entry = Entry(
        id: id1,
        fieldListId: fieldListId,
        answer: answer1,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: 3,
        didAskedAtCurrentTestRound: true,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: rank,
        askedCount: BigInt.from(askedCount),
        wronglyAnsweredCount: BigInt.from(wronglyAnsweredCount),
      );
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
        id: id2,
        fieldListId: fieldListId,
        answer: answer2,
        question: question2,
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3,
        order: 2,
        didAskedAtCurrentTestRound: true,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: rank,
        askedCount: BigInt.from(askedCount),
        wronglyAnsweredCount: BigInt.from(wronglyAnsweredCount),
      );
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
        id: id3,
        fieldListId: fieldListId,
        answer: answer3,
        question: question3,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2,
        order: 1,
        didAskedAtCurrentTestRound: true,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: rank,
        askedCount: BigInt.from(askedCount),
        wronglyAnsweredCount: BigInt.from(wronglyAnsweredCount),
      );
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
        id: id4,
        fieldListId: fieldListId2,
        answer: answer4,
        question: question4,
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4,
        order: 2,
        didAskedAtCurrentTestRound: true,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: rank,
        askedCount: BigInt.from(askedCount),
        wronglyAnsweredCount: BigInt.from(wronglyAnsweredCount),
      );
      await entrysDao.create(entry.toCompanion(true));
    });

    test("Good case: is found", () async {
      await fullyRandomTestsDao.create(
        questionsNumber: questionsNumber,
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
        lastModificationAt: lastModificationAt,
        seed: 1,
      );
      FullyRandomTest? fullyRandomTest = await fullyRandomTestsDao.getById(id);
      fullyRandomTest = fullyRandomTest!;
      expect(fullyRandomTest.session.id, id);
      expect(fullyRandomTest.session.fieldListId, fieldListId);
      expect(
        fullyRandomTest.session.currentQuestionCounter,
        currentQuestionCounter,
      );
      expect(fullyRandomTest.session.triesNumber, triesNumber);
      expect(fullyRandomTest.session.triesCounter, triesCounter);
      expect(fullyRandomTest.session.elapsedTime, elapsedTime);
      expect(fullyRandomTest.session.isCompleted, isCompleted);
      expect(
        fullyRandomTest.session.lastCheckedAnswerResult,
        lastCheckedAnswerResult,
      );
      expect(fullyRandomTest.session.shouldCheckAnAnswer, shouldCheckAnAnswer);
      expect(fullyRandomTest.session.currentHintCounter, currentHintCounter);
      expect(fullyRandomTest.session.creationAt, creationAt);
      expect(fullyRandomTest.session.lastModificationAt, lastModificationAt);
      expect(
        fullyRandomTest.testSession.wrongAnswerCounter,
        wrongAnswerCounter,
      );
      expect(fullyRandomTest.testSession.lastAnswer, lastAnswer);
      expect(fullyRandomTest.entries, {id1, id2});
    });
  });
}
