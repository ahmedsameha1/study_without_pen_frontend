import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_period.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final FieldList fieldList =
      FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  final List<TextEntry> entries = List<TextEntry>.unmodifiable([
    TextEntry(
        uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1))
  ]);
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => StudyPeriod("", fieldList, entries, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod("weuwe", fieldList, entries, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), fieldList, entries, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod =
          StudyPeriod(uuidString, fieldList, entries, 0, 1, Duration());
      final id = studyPeriod.id;
      expect(uuidString, id);
    });
  });
  group("_fieldList tests", () {
    test("_fieldList has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final FieldList fieldList1 =
          FieldList(uuidString, "list1", uuid.v4(), DateTime.now());
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList1, entries, 0, 1, Duration());
      final fieldListId = studyPeriod.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(
          () => StudyPeriod(uuid.v4(), fieldList, entries, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("resetCurrentQuestionCounterToZero() test", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, 10, 1, Duration());
      studyPeriod.resetCurrentQuestionCounterToZero();
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
    });
    test("increaseCurrentQuestionCounterByOne() test", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, 10, 1, Duration());
      studyPeriod.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(11, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, 3, 1, Duration());
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(() => StudyPeriod(uuid.v4(), fieldList, entries, 0, 0, Duration()),
          throwsArgumentError);
      expect(
          () => StudyPeriod(uuid.v4(), fieldList, entries, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, 0, 3, Duration());
      var triesNumber = studyPeriod.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
        () {
      expect(() {
        final studyPeriod =
            StudyPeriod(uuid.v4(), fieldList, entries, 0, 3, Duration());
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(
            uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      var elapsedTime = studyPeriod.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      studyPeriod.elapsedTime = Duration(minutes: 1);
      elapsedTime = studyPeriod.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
  group("_entries tests", () {
    test("_entries cannot be an empty list", () {
      expect(
          () => StudyPeriod(uuid.v4(), fieldList, List<TextEntry>.empty(), 0, 3,
              Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries cannot be a growable list", () {
      expect(
          () => StudyPeriod(uuid.v4(), fieldList, entries.toList(), 0, 3,
              Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries cannot has the same entries more than once", () {
      final stringUuid1 = uuid.v4();
      final textEntry = TextEntry(stringUuid1, "question", "answer", uuid.v4(),
          DateTime.utc(2020, 1, 1));
      // TODO Should I test the equality by overriding the == operator on TextEntry?
      expect(
          () => StudyPeriod(
              uuid.v4(),
              fieldList,
              List.unmodifiable([textEntry, textEntry]),
              0,
              3,
              Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries has been assigned the correct value", () {
      final entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(uuid.v4(), "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries1, 0, 3, Duration(seconds: 10));
      final entries2 = studyPeriod.entries;
      expect(entries1, entries2);
    });
  });
  group("checkAnAnswer method tests", () {
    test("DO_NOT_IGNORE_CASE", () {
      FieldList fieldList1 = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("IGNORE_CASE", () {
      var entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final fieldList1 = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.IGNORE_CASE);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_IGNORE_CASE", () {
      var entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answr1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1, anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1, \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 ,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_DO_NOT_IGNORE_CASE", () {
      var entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answr1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1, anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    aNswer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1,    answEr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answER1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1, \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 ,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = List<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    aNswer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1    answEr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answER1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
  });
  test("Session workflow test", () {
    var textEntryId1 = uuid.v4();
    FieldList fieldList1 = FieldList(
        uuid.v4(), "list1", uuid.v4(), DateTime.now(),
        checkType: CheckType.DO_NOT_IGNORE_CASE);
    var entries1 = List<TextEntry>.unmodifiable([
      TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
          DateTime.utc(2020, 1, 1))
    ]);
    var studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
    TextEntry currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer1 answer1");
    var triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    var repeatedEntries = studyPeriod.repeatedEntries;
    expect(0, repeatedEntries.length);
    studyPeriod.next();
    var currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    var isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 3, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer1 answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(0, repeatedEntries.length);
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 3, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(0, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    studyPeriod.checkAnAnswer("answer1 answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(2, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 3, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(0, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(2, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(0, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(3, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 3, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(0, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    studyPeriod.checkAnAnswer("answer answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(2, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(0, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    studyPeriod.checkAnAnswer("answer1 answer1");
    triesCounter = studyPeriod.triesCounter;
    expect(3, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    var textEntryId2 = uuid.v4();
    var textEntryId3 = uuid.v4();
    entries1 = List<TextEntry>.unmodifiable([
      TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
          DateTime.utc(2020, 1, 1)),
      TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
          DateTime.utc(2020, 1, 1)),
      TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
          DateTime.utc(2020, 1, 1))
    ]);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 3, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer1 answer1");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(0, repeatedEntries.length);
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer2 answer2");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(0, repeatedEntries.length);
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(2, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer3 answer3");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(0, repeatedEntries.length);
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(3, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod = StudyPeriod(
        uuid.v4(), fieldList1, entries1, 0, 3, Duration(seconds: 10));
    currentEntry = studyPeriod.currentEntry;
    expect(textEntryId1, currentEntry.id);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer1");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(0, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer1 answer1");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(2, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(1, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer2");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(2, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    expect(true, repeatedEntries.contains(studyPeriod.entries[1]));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer2");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(2, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(2, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    expect(true, repeatedEntries.contains(studyPeriod.entries[1]));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(1, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer answer2");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(3, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(2, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    expect(true, repeatedEntries.contains(studyPeriod.entries[1]));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(2, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(false, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
    studyPeriod.checkAnAnswer("answer3 answer3");
    expect(() {
      studyPeriod.checkAnAnswer("userAnswerff");
    }, throwsStateError);
    triesCounter = studyPeriod.triesCounter;
    expect(1, triesCounter);
    repeatedEntries = studyPeriod.repeatedEntries;
    expect(2, repeatedEntries.length);
    expect(true, repeatedEntries.contains(currentEntry));
    expect(true, repeatedEntries.contains(studyPeriod.entries[1]));
    studyPeriod.next();
    currentQuestionCounter = studyPeriod.currentQuestionCounter;
    expect(3, currentQuestionCounter);
    isCompleted = studyPeriod.isCompleted;
    expect(true, isCompleted);
    expect(() {
      studyPeriod.next();
    }, throwsStateError);
  });
}
