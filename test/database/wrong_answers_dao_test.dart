import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/database/questions_dao.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:study_without_pen_by_flutter/database/wrong_answers_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late WrongAnswersDao wrongAnswersDao;
  late SessionsDao sessionsDao;
  late EntrysDao entrysDao;
  late FieldsDao fieldsDao;
  late FieldListsDao fieldListsDao;
  late EntryTextsDao entryTextsDao;
  late QuestionsDao questionsDao;
  String id = const Uuid().v4();
  String entryId = const Uuid().v4();
  String sessionId = const Uuid().v4();
  String value = "wrong answer";
  String fieldListId = Uuid().v4();
  int currentQuestionCounter = 5;
  int triesNumber = 3;
  int triesCounter = 1;
  int elapsedTime = 6000;
  bool isCompleted = true;
  bool lastCheckedAnswerResult = true;
  bool shouldCheckAnAnswer = true;
  int currentHintCounter = 0;
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  String answerId = const Uuid().v4();
  String questionId = const Uuid().v4();
  DateTime emulatedCreatedAt = DateTime.utc(2022, 2, 2);
  int order = 1;
  int rank = Rank.Normal.index;
  int askedCount = 2;
  int wronglyAnsweredCount = 1;
  bool didAskedAtCurrentTestRound = true;
  String fieldId = const Uuid().v4();
  String name = "fieldList1";
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
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  String name1 = "name";
  DateTime creationAt2 = DateTime(2018, 1, 1);
  DateTime lastModificationAt2 = DateTime.utc(2018, 2, 2);
  int usageCount1 = 9;
  int color1 = 0xff55ee11;
  String questionAddress = const Uuid().v4();
  final answer = EntryText(id: answerId, value: "answer");
  final entryTextQuestion = EntryText(id: questionAddress, value: "text");
  Question question = Question(
      id: questionId,
      questionType: QuestionType.EntryTextQuestion.index,
      address: questionAddress);
  Field field = Field(
      id: fieldId,
      userAccountId: userAccountId,
      name: name1,
      creationAt: creationAt2,
      lastModificationAt: lastModificationAt2,
      usageCount: usageCount1,
      color: color1);
  FieldList fieldList = FieldList(
      id: fieldListId,
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
      doesObfuscateQuestion: doesObfuscateQuestion);
  Session session = Session(
      id: sessionId,
      fieldListId: fieldListId,
      currentQuestionCounter: currentQuestionCounter,
      triesNumber: triesNumber,
      triesCounter: triesCounter,
      elapsedTime: elapsedTime,
      isCompleted: isCompleted,
      lastCheckedAnswerResult: lastCheckedAnswerResult,
      shouldCheckAnAnswer: shouldCheckAnAnswer,
      currentHintCounter: currentHintCounter,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt);
  Entry entry = Entry(
      id: entryId,
      fieldListId: fieldListId,
      answerId: answerId,
      questionId: questionId,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: rank,
      askedCount: askedCount,
      wronglyAnsweredCount: wronglyAnsweredCount);
  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    wrongAnswersDao = WrongAnswersDao(appDatabase);
    sessionsDao = SessionsDao(appDatabase);
    entrysDao = EntrysDao(appDatabase);
    fieldsDao = FieldsDao(appDatabase);
    fieldListsDao = FieldListsDao(appDatabase);
    entryTextsDao = EntryTextsDao(appDatabase);
    questionsDao = QuestionsDao(appDatabase);
    await entryTextsDao.create(answer.toCompanion(true));
    await entryTextsDao.create(entryTextQuestion.toCompanion(true));
    await questionsDao.create(question.toCompanion(true));
    await fieldsDao.create(field.toCompanion(true));
    await fieldListsDao.create(fieldList.toCompanion(true));
    await sessionsDao.create(session.toCompanion(true));
    await entrysDao.create(entry.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create wrongAnswer", () {
    test("Invalid wrongAnswer: id is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(
          id: "efweh",
          sessionId: sessionId,
          entryId: entryId,
          value: value,
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No two or more wrongAnswers with the same id", () async {
      final wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: entryId,
          value: value,
          creationAt: creationAt);
      await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("wrong_answers.id"))));
    });

    test("Invalid wrongAnswer: sessionId is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(
          id: id,
          sessionId: "owfbhwe",
          entryId: entryId,
          value: value,
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });

    test("Invalid wrongAnswer: sessionId doesn't exist in sessions table", () {
      final wrongAnswer = WrongAnswer(
          id: id,
          sessionId: const Uuid().v4(),
          entryId: entryId,
          value: value,
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid wrongAnswer: entryId is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: "efbw",
          value: value,
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("entryId"))));
    });

    test("Invalid wrongAnswer: entryId doesn't exist in sessions table", () {
      final wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: const Uuid().v4(),
          value: value,
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid wrongAnswer: value is an empty String", () {
      var wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: entryId,
          value: "",
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
      wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: entryId,
          value: " ",
          creationAt: creationAt);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test("Invalid wrongAnswer: value is an empty String", () {
      var wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: entryId,
          value: value,
          creationAt: DateTime(2019, 1, 1));
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message
                  .contains("creationAt is before the session creationAt"))));
    });

    test("Good case: not provide id", () async {
      var wrongAnswerCompanion = WrongAnswersCompanion(
          sessionId: Value(sessionId),
          entryId: Value(entryId),
          value: Value("wefhweo"),
          creationAt: Value(creationAt));
      await wrongAnswersDao.create(wrongAnswerCompanion);
    });
  });

  group("Get by sessionId & entryId", () {
    test("There is at least one wrong answer", () async {
      final id2 = const Uuid().v4();
      final id3 = const Uuid().v4();
      final id4 = const Uuid().v4();
      final id5 = const Uuid().v4();
      final sessionId1 = const Uuid().v4();
      final entryId1 = const Uuid().v4();
      final answerId1 = const Uuid().v4();
      final answer1 = EntryText(id: answerId1, value: "answer1");
      await entryTextsDao.create(answer1.toCompanion(true));
      Session session1 = Session(
          id: sessionId1,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await sessionsDao.create(session1.toCompanion(true));
      Entry entry1 = Entry(
          id: entryId1,
          fieldListId: fieldListId,
          answerId: answerId1,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      final wrongAnswerCreationAt1 = DateTime(2020, 3, 3);
      final wrongAnswerCreationAt2 = DateTime(2020, 4, 4);
      final wrongAnswerCreationAt3 = DateTime(2020, 5, 5);
      final wrongAnswerCreationAt4 = DateTime(2020, 6, 6);
      final wrongAnswerCreationAt5 = DateTime(2020, 7, 7);
      var wrongAnswer1 = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: entryId,
          value: value,
          creationAt: wrongAnswerCreationAt1);
      var wrongAnswer2 = WrongAnswer(
          id: id2,
          sessionId: sessionId1,
          entryId: entryId,
          value: value,
          creationAt: wrongAnswerCreationAt2);
      var wrongAnswer3 = WrongAnswer(
          id: id3,
          sessionId: sessionId,
          entryId: entryId,
          value: value,
          creationAt: wrongAnswerCreationAt3);
      var wrongAnswer4 = WrongAnswer(
          id: id4,
          sessionId: sessionId,
          entryId: entryId,
          value: value,
          creationAt: wrongAnswerCreationAt4);
      var wrongAnswer5 = WrongAnswer(
          id: id5,
          sessionId: sessionId,
          entryId: entryId1,
          value: value,
          creationAt: wrongAnswerCreationAt5);
      await wrongAnswersDao.create(wrongAnswer4.toCompanion(true));
      await wrongAnswersDao.create(wrongAnswer2.toCompanion(true));
      await wrongAnswersDao.create(wrongAnswer5.toCompanion(true));
      await wrongAnswersDao.create(wrongAnswer3.toCompanion(true));
      await wrongAnswersDao.create(wrongAnswer1.toCompanion(true));
      List<WrongAnswer> wrongAnswers =
          await wrongAnswersDao.getBySessionIdAndEntryId(sessionId, entryId);
      expect(wrongAnswers.length, 3);
      var gottenWrongAnser = wrongAnswers[0];
      expect(gottenWrongAnser.id, wrongAnswer1.id);
      expect(gottenWrongAnser.sessionId, wrongAnswer1.sessionId);
      expect(gottenWrongAnser.entryId, wrongAnswer1.entryId);
      expect(gottenWrongAnser.value, wrongAnswer1.value);
      expect(gottenWrongAnser.creationAt, wrongAnswer1.creationAt);
      gottenWrongAnser = wrongAnswers[1];
      expect(gottenWrongAnser.id, wrongAnswer3.id);
      expect(gottenWrongAnser.sessionId, wrongAnswer3.sessionId);
      expect(gottenWrongAnser.entryId, wrongAnswer3.entryId);
      expect(gottenWrongAnser.value, wrongAnswer3.value);
      expect(gottenWrongAnser.creationAt, wrongAnswer3.creationAt);
      gottenWrongAnser = wrongAnswers[2];
      expect(gottenWrongAnser.id, wrongAnswer4.id);
      expect(gottenWrongAnser.sessionId, wrongAnswer4.sessionId);
      expect(gottenWrongAnser.entryId, wrongAnswer4.entryId);
      expect(gottenWrongAnser.value, wrongAnswer4.value);
      expect(gottenWrongAnser.creationAt, wrongAnswer4.creationAt);
    });

    test("There is no wrong answer", () async {
      final answerId1 = const Uuid().v4();
      final answer1 = EntryText(id: answerId1, value: "answer1");
      await entryTextsDao.create(answer1.toCompanion(true));
      final sessionId1 = const Uuid().v4();
      final entryId1 = const Uuid().v4();
      Session session1 = Session(
          id: sessionId1,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await sessionsDao.create(session1.toCompanion(true));
      Entry entry1 = Entry(
          id: entryId1,
          fieldListId: fieldListId,
          answerId: answerId1,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      List<WrongAnswer> wrongAnswers =
          await wrongAnswersDao.getBySessionIdAndEntryId(sessionId1, entryId1);
      expect(wrongAnswers.length, 0);
    });
  });
}
