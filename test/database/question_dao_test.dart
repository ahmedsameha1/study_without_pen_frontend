import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/questions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late QuestionsDao questionsDao;
  String id = const Uuid().v4();
  String address = const Uuid().v4();
  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    questionsDao = QuestionsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a Question", () {
    test("Invalid Question: id is an invalid UUID v4", () {
      var question = Question(
          id: "ewhe",
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      expect(() async {
        await questionsDao.create(question);
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("Creating Question with the same 'id'", () async {
      var question = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      var question1 = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: const Uuid().v4());
      expect(() async {
        await questionsDao.create(question);
        await questionsDao.create(question1);
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test(
        "Invalid Question: address is an invalid UUID v4, when questionType is EntryTextQuestion",
        () {
      var question = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: "hewf");
      expect(() async {
        await questionsDao.create(question);
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("address"))));
    });

    test("Creating a Question with the same questionType and the same address",
        () {
      var question = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      var question1 = Question(
          id: const Uuid().v4(),
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      expect(() async {
        await questionsDao.create(question);
        await questionsDao.create(question1);
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("question_type") &&
              e.message.contains("address"))));
    });
    test("Good case", () async {
      var question = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      await questionsDao.create(question);
    });
  });

  group("Getting EntryText", () {
    test("Get a Question by id: not found", () async {
      expect(await questionsDao.getById(id), equals(null));
    });

    test("Get a Question by id: Good case", () async {
      var question = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      await questionsDao.create(question);
      var gotQuestion = await questionsDao.getById(id);
      expect(gotQuestion, isNot(null));
      expect(gotQuestion!.id, question.id);
      expect(gotQuestion!.questionType, question.questionType);
      expect(gotQuestion!.address, question.address);
    });
  });

  group("Delete a Question", () {
    test("Good case1: when not found there is no error", () async {
      await questionsDao.remove(id);
    });

    test("Good case2", () async {
      var question = Question(
          id: id,
          questionType: QuestionType.EntryTextQuestion.index,
          address: address);
      await questionsDao.create(question);
      await questionsDao.remove(id);
      expect(await questionsDao.getById(id), equals(null));
    });
  });
}
