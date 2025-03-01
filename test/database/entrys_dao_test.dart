import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/database/questions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late EntrysDao entrysDao;
  late QuestionsDao questionsDao;
  late EntryTextsDao entryTextsDao;
  late FieldsDao fieldsDao;
  late FieldListsDao fieldListsDao;
  String id = const Uuid().v4();
  String fieldListId = const Uuid().v4();
  String answerId = const Uuid().v4();
  String questionId = const Uuid().v4();
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  DateTime emulatedCreatedAt = DateTime.utc(2022, 2, 2);
  int order = 1;
  int rank = Rank.Normal.index;
  int askedCount = 2;
  int wronglyAnsweredCount = 1;
  bool didAskedAtCurrentTestRound = true;
  String fieldId = const Uuid().v4();
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
  bool doesObfuscateQuestion = true;
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  String name1 = "name";
  DateTime creationAt2 = DateTime(2018, 1, 1);
  DateTime lastModificationAt2 = DateTime.utc(2018, 2, 2);
  int usageCount1 = 9;
  int color1 = 0xff55ee11;
  String questionAddress = const Uuid().v4();
  final entryTextQuestion = EntryText(id: questionAddress, value: "text");
  Question question = Question(
      id: questionId,
      questionType: QuestionType.EntryTextQuestion.index,
      address: questionAddress);
  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    entrysDao = EntrysDao(appDatabase);
    questionsDao = QuestionsDao(appDatabase);
    entryTextsDao = EntryTextsDao(appDatabase);
    fieldsDao = FieldsDao(appDatabase);
    fieldListsDao = FieldListsDao(appDatabase);
    EntryText answer = EntryText(id: answerId, value: "answer");
    await entryTextsDao.create(entryTextQuestion.toCompanion(true));
    await entryTextsDao.create(answer.toCompanion(true));
    await questionsDao.create(question.toCompanion(true));
    var field = Field(
        id: fieldId,
        userAccountId: userAccountId,
        name: name1,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2,
        usageCount: usageCount1,
        color: color1);
    await fieldsDao.create(field.toCompanion(true));
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
        doesObfuscateQuestion: doesObfuscateQuestion);
    await fieldListsDao.create(fieldList.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Getting entry by id", () {
    test("Good case: the entry is found", () async {
      var entry = Entry(
          id: id,
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
      await entrysDao.create(entry.toCompanion(true));
      var gottenEntry = await entrysDao.getById(id);
      gottenEntry = gottenEntry!;
      expect(gottenEntry.id, id);
      expect(gottenEntry.fieldListId, fieldListId);
      expect(gottenEntry.answerId, answerId);
      expect(gottenEntry.questionId, questionId);
      expect(gottenEntry.creationAt, creationAt);
      expect(gottenEntry.lastModificationAt, lastModificationAt);
      expect(gottenEntry.order, order);
      expect(
          gottenEntry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(gottenEntry.emulatedCreatedAt, emulatedCreatedAt);
      expect(gottenEntry.rank, rank);
      expect(gottenEntry.askedCount, askedCount);
      expect(gottenEntry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case: the entry is not found", () async {
      var gottenEntry = await entrysDao.getById(const Uuid().v4());
      expect(gottenEntry, null);
    });
  });

  group("Get entries by fieldlist", () {
    test("At least one entry is found in the fieldList", () async {
      String id1 = const Uuid().v4();
      String id2 = const Uuid().v4();
      String id3 = const Uuid().v4();
      String id4 = const Uuid().v4();
      String fieldListId2 = const Uuid().v4();
      String answerId2 = const Uuid().v4();
      String answerId3 = const Uuid().v4();
      String answerId4 = const Uuid().v4();
      String questionId2 = const Uuid().v4();
      String questionId3 = const Uuid().v4();
      String questionId4 = const Uuid().v4();
      DateTime creationAt2 = DateTime.utc(2019, 1, 1);
      DateTime creationAt3 = DateTime.utc(2021, 1, 1);
      DateTime creationAt4 = DateTime.utc(2018, 1, 1);
      DateTime lastModificationAt2 = DateTime.utc(2019, 2, 1);
      DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
      DateTime lastModificationAt4 = DateTime.utc(2019, 2, 1);
      final answer2 = EntryText(id: answerId2, value: "answer2");
      await entryTextsDao.create(answer2.toCompanion(true));
      final answer3 = EntryText(id: answerId3, value: "answer3");
      await entryTextsDao.create(answer3.toCompanion(true));
      final answer4 = EntryText(id: answerId4, value: "answer4");
      await entryTextsDao.create(answer4.toCompanion(true));
      var fieldList = FieldList(
          id: fieldListId2,
          fieldId: fieldId,
          name: name + "f",
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
      String questionAddress2 = const Uuid().v4();
      final entryTextQuestion2 =
          EntryText(id: questionAddress2, value: "text2");
      String questionAddress3 = const Uuid().v4();
      final entryTextQuestion3 =
          EntryText(id: questionAddress3, value: "text3");
      String questionAddress4 = const Uuid().v4();
      final entryTextQuestion4 =
          EntryText(id: questionAddress4, value: "text4");
      await entryTextsDao.create(entryTextQuestion2.toCompanion(true));
      await entryTextsDao.create(entryTextQuestion3.toCompanion(true));
      await entryTextsDao.create(entryTextQuestion4.toCompanion(true));
      Question question2 = Question(
          id: questionId2,
          questionType: QuestionType.EntryTextQuestion.index,
          address: questionAddress2);
      Question question3 = Question(
          id: questionId3,
          questionType: QuestionType.EntryTextQuestion.index,
          address: questionAddress3);
      Question question4 = Question(
          id: questionId4,
          questionType: QuestionType.EntryTextQuestion.index,
          address: questionAddress4);
      await questionsDao.create(question2.toCompanion(true));
      await questionsDao.create(question3.toCompanion(true));
      await questionsDao.create(question4.toCompanion(true));
      var entry = Entry(
          id: id1,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 3,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id2,
          fieldListId: fieldListId2,
          answerId: answerId2,
          questionId: questionId2,
          creationAt: creationAt3,
          lastModificationAt: lastModificationAt3,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id3,
          fieldListId: fieldListId,
          answerId: answerId3,
          questionId: questionId3,
          creationAt: creationAt2,
          lastModificationAt: lastModificationAt2,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id4,
          fieldListId: fieldListId,
          answerId: answerId4,
          questionId: questionId4,
          creationAt: creationAt4,
          lastModificationAt: lastModificationAt4,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      List<Entry> entries = await entrysDao.getByFieldListId(fieldListId);
      expect(entries.length, 3);
      entry = entries[0];
      expect(entry.id, id3);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId3);
      expect(entry.questionId, questionId3);
      expect(entry.creationAt, creationAt2);
      expect(entry.lastModificationAt, lastModificationAt2);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[1];
      expect(entry.id, id4);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId4);
      expect(entry.questionId, questionId4);
      expect(entry.creationAt, creationAt4);
      expect(entry.lastModificationAt, lastModificationAt4);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, true);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[2];
      expect(entry.id, id1);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId);
      expect(entry.questionId, questionId);
      expect(entry.creationAt, creationAt);
      expect(entry.lastModificationAt, lastModificationAt);
      expect(entry.order, 3);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case: no entry is found in the fieldList", () async {
      var entries = await entrysDao.getByFieldListId(const Uuid().v4());
      expect(entries.length, 0);
    });
  });

  group("Get all entries", () {
    test("Get all entries in Descending order by creationAt field", () async {
      String id2 = const Uuid().v4();
      String id3 = const Uuid().v4();
      String id4 = const Uuid().v4();
      String answerId2 = const Uuid().v4();
      String answerId3 = const Uuid().v4();
      String answerId4 = const Uuid().v4();
      String questionId2 = const Uuid().v4();
      String questionId3 = const Uuid().v4();
      String questionId4 = const Uuid().v4();
      DateTime creationAt2 = DateTime.utc(2019, 1, 1);
      DateTime creationAt3 = DateTime.utc(2021, 1, 1);
      DateTime creationAt4 = DateTime.utc(2018, 1, 1);
      DateTime lastModificationAt2 = DateTime.utc(2019, 2, 1);
      DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
      DateTime lastModificationAt4 = DateTime.utc(2019, 2, 1);
      String questionAddress2 = const Uuid().v4();
      final entryTextQuestion2 =
          EntryText(id: questionAddress2, value: "text2");
      String questionAddress3 = const Uuid().v4();
      final entryTextQuestion3 =
          EntryText(id: questionAddress3, value: "text3");
      String questionAddress4 = const Uuid().v4();
      final entryTextQuestion4 =
          EntryText(id: questionAddress4, value: "text4");
      final answer2 = EntryText(id: answerId2, value: "answer2");
      await entryTextsDao.create(answer2.toCompanion(true));
      final answer3 = EntryText(id: answerId3, value: "answer3");
      await entryTextsDao.create(answer3.toCompanion(true));
      final answer4 = EntryText(id: answerId4, value: "answer4");
      await entryTextsDao.create(answer4.toCompanion(true));
      await entryTextsDao.create(entryTextQuestion2.toCompanion(true));
      await entryTextsDao.create(entryTextQuestion3.toCompanion(true));
      await entryTextsDao.create(entryTextQuestion4.toCompanion(true));
      Question question2 = Question(
          id: questionId2,
          questionType: QuestionType.EntryTextQuestion.index,
          address: questionAddress2);
      Question question3 = Question(
          id: questionId3,
          questionType: QuestionType.EntryTextQuestion.index,
          address: questionAddress3);
      Question question4 = Question(
          id: questionId4,
          questionType: QuestionType.EntryTextQuestion.index,
          address: questionAddress4);
      await questionsDao.create(question2.toCompanion(true));
      await questionsDao.create(question3.toCompanion(true));
      await questionsDao.create(question4.toCompanion(true));
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 3,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id2,
          fieldListId: fieldListId,
          answerId: answerId2,
          questionId: questionId2,
          creationAt: creationAt3,
          lastModificationAt: lastModificationAt3,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id3,
          fieldListId: fieldListId,
          answerId: answerId3,
          questionId: questionId3,
          creationAt: creationAt2,
          lastModificationAt: lastModificationAt2,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id4,
          fieldListId: fieldListId,
          answerId: answerId4,
          questionId: questionId4,
          creationAt: creationAt4,
          lastModificationAt: lastModificationAt4,
          order: order,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      final entries = await entrysDao.getAll();
      expect(entries.length, 4);
      entry = entries[0];
      expect(entry.id, id4);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId4);
      expect(entry.questionId, questionId4);
      expect(entry.creationAt, creationAt4);
      expect(entry.lastModificationAt, lastModificationAt4);
      expect(entry.order, order);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[1];
      expect(entry.id, id2);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId2);
      expect(entry.questionId, questionId2);
      expect(entry.creationAt, creationAt3);
      expect(entry.lastModificationAt, lastModificationAt3);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[2];
      expect(entry.id, id3);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId3);
      expect(entry.questionId, questionId3);
      expect(entry.creationAt, creationAt2);
      expect(entry.lastModificationAt, lastModificationAt2);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[3];
      expect(entry.id, id);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId);
      expect(entry.questionId, questionId);
      expect(entry.creationAt, creationAt);
      expect(entry.lastModificationAt, lastModificationAt);
      expect(entry.order, 3);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case: there is no entries", () async {
      var entries = await entrysDao.getAll();
      expect(entries.length, 0);
    });
  });

  group("Create an Entry", () {
    test("Invalid Entry: id is an invalid UUID v4", () async {
      var entry = Entry(
          id: "ewhfwo",
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
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Entry with the same 'id'", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      var entry1 = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      expect(() async {
        await entrysDao.create(entry1.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid Entry: fieldListId is an invalid UUID v4", () async {
      var entry = Entry(
          id: id,
          fieldListId: "wiuofehw",
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test("Invalid Entry: fieldListId doesn't exist in FieldLists table",
        () async {
      var entry = Entry(
          id: id,
          fieldListId: const Uuid().v4(),
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid Entry: answerId is an invalid UUID v4", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: "uefwe",
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("answerId"))));
    });

    test("Invalid Entry: answerId doesn't exist in EntryTexts table", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: const Uuid().v4(),
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid Entry: questionId is an invalid UUID v4", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: "uehfe",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("questionId"))));
    });

    test("Invalid Entry: questionId doesn't exist in questions table",
        () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: const Uuid().v4(),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("The same fieldListId and the same answerId and the same questionId",
        () {
      var entry = Entry(
          id: id,
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
      var entry1 = Entry(
          id: const Uuid().v4(),
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
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
        await entrysDao.create(entry1.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("field_list_id") &&
              e.message.contains("question_id") &&
              e.message.contains("answer_id"))));
    });

    test("Invalid Entry: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2023, 2, 2),
            lastModificationAt: lastModificationAt,
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.create(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid Entry: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2023, 2, 2),
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.create(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid Entry: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2021, 1, 1),
            lastModificationAt: DateTime.utc(2020, 1, 1),
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.create(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid Entry: order is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 65535 + 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid Entry: order is smaller than 0", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 0 - 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid Entry: rank is invalid value", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: 8,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("rank"))));
    });

    test("Invalid Entry: askedCount is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: 65535 + 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid Entry: askedCount is smaller than 0", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: 0 - 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid Entry: wronglyAnsweredCount is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: 65535 + 1);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Invalid Entry: wronglyAnsweredCount is smaller than 0", () async {
      var entry = Entry(
          id: id,
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
          wronglyAnsweredCount: 0 - 1);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Good case", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
    });

    test("Good case: Creating Entry without giving an 'id'", () async {
      var entrysCompanion = EntrysCompanion(
          fieldListId: Value(fieldListId),
          answerId: Value(answerId),
          questionId: Value(questionId),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          order: Value(order),
          didAskedAtCurrentTestRound: Value(true),
          emulatedCreatedAt: Value(emulatedCreatedAt),
          rank: Value(rank),
          askedCount: Value(askedCount),
          wronglyAnsweredCount: Value(wronglyAnsweredCount));
      await entrysDao.create(entrysCompanion);
      List<Entry> entrys = await entrysDao.getAll();
      expect(isValid(entrys[0].id), true);
    });
  });

  group("Update Entry", () {
    setUp(() async {
      var entry = Entry(
          id: id,
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
      await entrysDao.create(entry.toCompanion(true));
    });
    test("fieldListId field should be a valid UUID v4", () {
      var entry = Entry(
          id: id,
          fieldListId: "eweho",
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
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test("answerId field should be a valid UUID v4", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: "ewh2woe",
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("answerId"))));
    });

    test("questionId field should be a valid UUID v4", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: "oewhow",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("questionId"))));
    });

    test("creationAt field should be a DateTime in the past", () {
      withClock(Clock.fixed(DateTime.utc(2020, 3, 3)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2021, 5, 5),
            lastModificationAt: lastModificationAt,
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.mutate(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("lastModificationAt field should be a DateTime in the past", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: creationAt,
            lastModificationAt: DateTime(2024, 1, 1),
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.mutate(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid Entry: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2021, 1, 1),
            lastModificationAt: DateTime.utc(2020, 1, 1),
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.mutate(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid update: order is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 65535 + 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid update: order is smaller than 0", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 0 - 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid update: rank is invalid value", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: 7,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("rank"))));
    });

    test("Invalid update: askedCount is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: 65535 + 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid update: askedCount is smaller than 0", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: 0 - 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid update: wronglyAnsweredCount is greater than 65535", () {
      var entry = Entry(
          id: id,
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
          wronglyAnsweredCount: 65535 + 1);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Invalid update: wronglyAnsweredCount is smaller than 0", () {
      var entry = Entry(
          id: id,
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
          wronglyAnsweredCount: 0 - 1);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Good case 1", () async {
      const thisOrder = 10;
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: thisOrder,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      var mutated = await entrysDao.mutate(entry.toCompanion(true));
      expect(mutated, true);
      var gottenEntry = await entrysDao.getById(id);
      gottenEntry = gottenEntry!;
      expect(gottenEntry.id, id);
      expect(gottenEntry.fieldListId, fieldListId);
      expect(gottenEntry.answerId, answerId);
      expect(gottenEntry.questionId, questionId);
      expect(gottenEntry.creationAt, creationAt);
      expect(gottenEntry.lastModificationAt, lastModificationAt);
      expect(gottenEntry.order, thisOrder);
      expect(
          gottenEntry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(gottenEntry.emulatedCreatedAt, emulatedCreatedAt);
      expect(gottenEntry.rank, rank);
      expect(gottenEntry.askedCount, askedCount);
      expect(gottenEntry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case 2", () async {
      const thisOrder = 10;
      var thisAnswerId = const Uuid().v4();
      const thisAskedCount = 1000;
      final thisAnswer = EntryText(id: thisAnswerId, value: "thisAnswer");
      await entryTextsDao.create(thisAnswer.toCompanion(true));
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: thisAnswerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: thisOrder,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: thisAskedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      var mutated = await entrysDao.mutate(entry.toCompanion(true));
      expect(mutated, true);
      var gottenEntry = await entrysDao.getById(id);
      gottenEntry = gottenEntry!;
      expect(gottenEntry.id, id);
      expect(gottenEntry.fieldListId, fieldListId);
      expect(gottenEntry.answerId, thisAnswerId);
      expect(gottenEntry.questionId, questionId);
      expect(gottenEntry.creationAt, creationAt);
      expect(gottenEntry.lastModificationAt, lastModificationAt);
      expect(gottenEntry.order, thisOrder);
      expect(
          gottenEntry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(gottenEntry.emulatedCreatedAt, emulatedCreatedAt);
      expect(gottenEntry.rank, rank);
      expect(gottenEntry.askedCount, thisAskedCount);
      expect(gottenEntry.wronglyAnsweredCount, wronglyAnsweredCount);
    });
  });

  test("Delete Entry", () async {
    var entry = Entry(
        id: id,
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
    await entrysDao.create(entry.toCompanion(true));
    await entrysDao.remove(entry.id);
    var gottenEntry = await entrysDao.getById(id);
    expect(gottenEntry, null);
  });

  group("Get hints", () {
    test("no hints", () async {
      final questionEntryTextId = const Uuid().v4();
      final answerEntryTextId = const Uuid().v4();
      EntryText questionEntryText =
          EntryText(id: questionEntryTextId, value: "hello");
      EntryText answerEntryText = EntryText(id: answerEntryTextId, value: "hi");
      await entryTextsDao.create(questionEntryText.toCompanion(true));
      await entryTextsDao.create(answerEntryText.toCompanion(true));
      final entry = Entry(
          id: id,
          questionId: question.id,
          answerId: answerEntryText.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(id);
      List<String>? hints = await hintsFuture;
      expect(hints, null);
    });

    test("one hint for lenght of the answer", () async {
      final entryId1 = const Uuid().v4();
      final entryId2 = const Uuid().v4();
      final questionEntryTextId = const Uuid().v4();
      final answerEntryTextId1 = const Uuid().v4();
      final answerEntryTextId2 = const Uuid().v4();
      EntryText questionEntryText =
          EntryText(id: questionEntryTextId, value: "hello");
      EntryText answerEntryText1 =
          EntryText(id: answerEntryTextId1, value: "b" * 80);
      EntryText answerEntryText2 =
          EntryText(id: answerEntryTextId2, value: "b" * 100);
      await entryTextsDao.create(questionEntryText.toCompanion(true));
      await entryTextsDao.create(answerEntryText1.toCompanion(true));
      await entryTextsDao.create(answerEntryText2.toCompanion(true));
      final entry1 = Entry(
          id: entryId1,
          questionId: question.id,
          answerId: answerEntryText1.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry2 = Entry(
          id: entryId2,
          questionId: question.id,
          answerId: answerEntryText2.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      await entrysDao.create(entry2.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(entryId1);
      List<String>? hints = await hintsFuture;
      expect(hints!.length, 1);
      expect(hints[0], "Length: 80");
    });

    test("two hints, one for lenght of the answer", () async {
      final entryId1 = const Uuid().v4();
      final entryId2 = const Uuid().v4();
      final entryId3 = const Uuid().v4();
      final questionEntryTextId = const Uuid().v4();
      final answerEntryTextId1 = const Uuid().v4();
      final answerEntryTextId2 = const Uuid().v4();
      final answerEntryTextId3 = const Uuid().v4();
      EntryText questionEntryText =
          EntryText(id: questionEntryTextId, value: "hello");
      EntryText answerEntryText1 =
          EntryText(id: answerEntryTextId1, value: "b" * 80);
      EntryText answerEntryText2 =
          EntryText(id: answerEntryTextId2, value: "b" * 100);
      EntryText answerEntryText3 =
          EntryText(id: answerEntryTextId3, value: ("b" * 79) + "h");
      await entryTextsDao.create(questionEntryText.toCompanion(true));
      await entryTextsDao.create(answerEntryText1.toCompanion(true));
      await entryTextsDao.create(answerEntryText2.toCompanion(true));
      await entryTextsDao.create(answerEntryText3.toCompanion(true));
      final entry1 = Entry(
          id: entryId1,
          questionId: question.id,
          answerId: answerEntryText1.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry2 = Entry(
          id: entryId2,
          questionId: question.id,
          answerId: answerEntryText2.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry3 = Entry(
          id: entryId3,
          questionId: question.id,
          answerId: answerEntryText3.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      await entrysDao.create(entry2.toCompanion(true));
      await entrysDao.create(entry3.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(entryId1);
      List<String>? hints = await hintsFuture;
      expect(hints!.length, 2);
      expect(hints[0], "Length: 80");
      expect(hints[1], "Letter: 80 is 'b'");
    });

    test("two hints, one for lenght of the answer /2", () async {
      final entryId1 = const Uuid().v4();
      final entryId2 = const Uuid().v4();
      final entryId3 = const Uuid().v4();
      final questionEntryTextId = const Uuid().v4();
      final answerEntryTextId1 = const Uuid().v4();
      final answerEntryTextId2 = const Uuid().v4();
      final answerEntryTextId3 = const Uuid().v4();
      EntryText questionEntryText =
          EntryText(id: questionEntryTextId, value: "hello");
      EntryText answerEntryText1 =
          EntryText(id: answerEntryTextId1, value: "b" * 80);
      EntryText answerEntryText2 =
          EntryText(id: answerEntryTextId2, value: "b" * 100);
      EntryText answerEntryText3 = EntryText(
          id: answerEntryTextId3, value: ("b" * 49) + "h" + ("b" * 29) + "h");
      await entryTextsDao.create(questionEntryText.toCompanion(true));
      await entryTextsDao.create(answerEntryText1.toCompanion(true));
      await entryTextsDao.create(answerEntryText2.toCompanion(true));
      await entryTextsDao.create(answerEntryText3.toCompanion(true));
      final entry1 = Entry(
          id: entryId1,
          questionId: question.id,
          answerId: answerEntryText1.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry2 = Entry(
          id: entryId2,
          questionId: question.id,
          answerId: answerEntryText2.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry3 = Entry(
          id: entryId3,
          questionId: question.id,
          answerId: answerEntryText3.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      await entrysDao.create(entry2.toCompanion(true));
      await entrysDao.create(entry3.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(entryId1);
      List<String>? hints = await hintsFuture;
      expect(hints!.length, 2);
      expect(hints[0], "Length: 80");
      expect(hints[1], "Letter: 50 is 'b'");
    });

    test("three hints, one for lenght of the answer", () async {
      final entryId1 = const Uuid().v4();
      final entryId2 = const Uuid().v4();
      final entryId3 = const Uuid().v4();
      final entryId4 = const Uuid().v4();
      final questionEntryTextId = const Uuid().v4();
      final answerEntryTextId1 = const Uuid().v4();
      final answerEntryTextId2 = const Uuid().v4();
      final answerEntryTextId3 = const Uuid().v4();
      final answerEntryTextId4 = const Uuid().v4();
      EntryText questionEntryText =
          EntryText(id: questionEntryTextId, value: "hello");
      EntryText answerEntryText1 =
          EntryText(id: answerEntryTextId1, value: "b" * 80);
      EntryText answerEntryText2 =
          EntryText(id: answerEntryTextId2, value: "b" * 100);
      EntryText answerEntryText3 = EntryText(
          id: answerEntryTextId3, value: ("b" * 49) + "h" + ("b" * 30));
      EntryText answerEntryText4 = EntryText(
          id: answerEntryTextId4, value: ("b" * 50) + ("b" * 29) + "h");
      await entryTextsDao.create(questionEntryText.toCompanion(true));
      await entryTextsDao.create(answerEntryText1.toCompanion(true));
      await entryTextsDao.create(answerEntryText2.toCompanion(true));
      await entryTextsDao.create(answerEntryText3.toCompanion(true));
      await entryTextsDao.create(answerEntryText4.toCompanion(true));
      final entry1 = Entry(
          id: entryId1,
          questionId: question.id,
          answerId: answerEntryText1.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry2 = Entry(
          id: entryId2,
          questionId: question.id,
          answerId: answerEntryText2.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry3 = Entry(
          id: entryId3,
          questionId: question.id,
          answerId: answerEntryText3.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry4 = Entry(
          id: entryId4,
          questionId: question.id,
          answerId: answerEntryText4.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      await entrysDao.create(entry2.toCompanion(true));
      await entrysDao.create(entry3.toCompanion(true));
      await entrysDao.create(entry4.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(entryId1);
      List<String>? hints = await hintsFuture;
      expect(hints!.length, 3);
      expect(hints[0], "Length: 80");
      expect(hints[1], "Letter: 50 is 'b'");
      expect(hints[2], "Letter: 80 is 'b'");
    });

    test("three hints, one for lenght of the answer /2", () async {
      final entryId1 = const Uuid().v4();
      final entryId2 = const Uuid().v4();
      final entryId3 = const Uuid().v4();
      final entryId4 = const Uuid().v4();
      final entryId5 = const Uuid().v4();
      final questionEntryTextId = const Uuid().v4();
      final answerEntryTextId1 = const Uuid().v4();
      final answerEntryTextId2 = const Uuid().v4();
      final answerEntryTextId3 = const Uuid().v4();
      final answerEntryTextId4 = const Uuid().v4();
      final answerEntryTextId5 = const Uuid().v4();
      EntryText questionEntryText =
          EntryText(id: questionEntryTextId, value: "hello");
      EntryText answerEntryText1 =
          EntryText(id: answerEntryTextId1, value: "b" * 80);
      EntryText answerEntryText2 =
          EntryText(id: answerEntryTextId2, value: "b" * 100);
      EntryText answerEntryText3 = EntryText(
          id: answerEntryTextId3, value: ("b" * 49) + "h" + ("b" * 30));
      EntryText answerEntryText4 = EntryText(
          id: answerEntryTextId4, value: ("b" * 49) + "h" + ("b" * 29) + "h");
      EntryText answerEntryText5 = EntryText(
          id: answerEntryTextId5, value: ("b" * 50) + ("b" * 29) + "h");
      await entryTextsDao.create(questionEntryText.toCompanion(true));
      await entryTextsDao.create(answerEntryText1.toCompanion(true));
      await entryTextsDao.create(answerEntryText2.toCompanion(true));
      await entryTextsDao.create(answerEntryText3.toCompanion(true));
      await entryTextsDao.create(answerEntryText4.toCompanion(true));
      await entryTextsDao.create(answerEntryText5.toCompanion(true));
      final entry1 = Entry(
          id: entryId1,
          questionId: question.id,
          answerId: answerEntryText1.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry2 = Entry(
          id: entryId2,
          questionId: question.id,
          answerId: answerEntryText2.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry3 = Entry(
          id: entryId3,
          questionId: question.id,
          answerId: answerEntryText3.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry4 = Entry(
          id: entryId4,
          questionId: question.id,
          answerId: answerEntryText4.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry5 = Entry(
          id: entryId5,
          questionId: question.id,
          answerId: answerEntryText5.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      await entrysDao.create(entry2.toCompanion(true));
      await entrysDao.create(entry3.toCompanion(true));
      await entrysDao.create(entry4.toCompanion(true));
      await entrysDao.create(entry5.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(entryId1);
      List<String>? hints = await hintsFuture;
      expect(hints!.length, 3);
      expect(hints[0], "Length: 80");
      expect(hints[1], "Letter: 50 is 'b'");
      expect(hints[2], "Letter: 80 is 'b'");
    });

    test("four hints, one for lenght of the answer", () async {
      final entryId1 = const Uuid().v4();
      final entryId2 = const Uuid().v4();
      final entryId3 = const Uuid().v4();
      final entryId4 = const Uuid().v4();
      final entryId5 = const Uuid().v4();
      final entryId6 = const Uuid().v4();
      final answerEntryTextId1 = const Uuid().v4();
      final answerEntryTextId2 = const Uuid().v4();
      final answerEntryTextId3 = const Uuid().v4();
      final answerEntryTextId4 = const Uuid().v4();
      final answerEntryTextId5 = const Uuid().v4();
      final answerEntryTextId6 = const Uuid().v4();
      EntryText answerEntryText1 =
          EntryText(id: answerEntryTextId1, value: "b" * 80);
      EntryText answerEntryText2 =
          EntryText(id: answerEntryTextId2, value: "b" * 100);
      EntryText answerEntryText3 = EntryText(
          id: answerEntryTextId3, value: ("b" * 49) + "h" + ("b" * 30));
      EntryText answerEntryText4 = EntryText(
          id: answerEntryTextId4, value: ("b" * 49) + "h" + ("b" * 29) + "h");
      EntryText answerEntryText5 = EntryText(
          id: answerEntryTextId5, value: ("b" * 50) + ("b" * 29) + "h");
      EntryText answerEntryText6 =
          EntryText(id: answerEntryTextId6, value: "n" + ("b" * 79));
      await entryTextsDao.create(answerEntryText1.toCompanion(true));
      await entryTextsDao.create(answerEntryText2.toCompanion(true));
      await entryTextsDao.create(answerEntryText3.toCompanion(true));
      await entryTextsDao.create(answerEntryText4.toCompanion(true));
      await entryTextsDao.create(answerEntryText5.toCompanion(true));
      await entryTextsDao.create(answerEntryText6.toCompanion(true));
      final entry1 = Entry(
          id: entryId1,
          questionId: question.id,
          answerId: answerEntryText1.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry2 = Entry(
          id: entryId2,
          questionId: question.id,
          answerId: answerEntryText2.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry3 = Entry(
          id: entryId3,
          questionId: question.id,
          answerId: answerEntryText3.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry4 = Entry(
          id: entryId4,
          questionId: question.id,
          answerId: answerEntryText4.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry5 = Entry(
          id: entryId5,
          questionId: question.id,
          answerId: answerEntryText5.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      final entry6 = Entry(
          id: entryId6,
          questionId: question.id,
          answerId: answerEntryText6.id,
          fieldListId: fieldListId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry1.toCompanion(true));
      await entrysDao.create(entry2.toCompanion(true));
      await entrysDao.create(entry3.toCompanion(true));
      await entrysDao.create(entry4.toCompanion(true));
      await entrysDao.create(entry5.toCompanion(true));
      await entrysDao.create(entry6.toCompanion(true));
      Future<List<String>?> hintsFuture = entrysDao.getHintsByEntryId(entryId1);
      List<String>? hints = await hintsFuture;
      expect(hints!.length, 4);
      expect(hints[0], "Length: 80");
      expect(hints[1], "Letter: 50 is 'b'");
      expect(hints[2], "Letter: 80 is 'b'");
      expect(hints[3], "Letter: 1 is 'b'");
    });
  });
}
