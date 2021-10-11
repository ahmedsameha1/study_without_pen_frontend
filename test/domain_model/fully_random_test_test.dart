import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/sessions.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final FieldList fieldList =
      FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  final Set<TextEntry> entries = Set<TextEntry>.unmodifiable([
    TextEntry(
        uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1))
  ]);
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FullyRandomTest("", fieldList, entries, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () => FullyRandomTest("weuwe", fieldList, entries, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () =>
              FullyRandomTest(uuid.v4(), fieldList, entries, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fullyRandomTest =
          FullyRandomTest(uuidString, fieldList, entries, 0, 1, Duration());
      final id = fullyRandomTest.id;
      expect(uuidString, id);
    });
  });
  group("_fieldList tests", () {
    test("_fieldList has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final FieldList fieldList1 =
          FieldList(uuidString, "list1", uuid.v4(), DateTime.now());
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList1, entries, 0, 1, Duration());
      final fieldListId = fullyRandomTest.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(
          () =>
              FullyRandomTest(uuid.v4(), fieldList, entries, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("increaseCurrentQuestionCounterByOne method test", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
      fullyRandomTest.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(4, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_entries tests", () {
    test("_entries cannot be an empty list", () {
      expect(
          () => FullyRandomTest(uuid.v4(), fieldList,
              Set<TextEntry>.unmodifiable([]), 0, 3, Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries cannot be a growable list", () {
      expect(
          () => FullyRandomTest(uuid.v4(), fieldList, entries.toList().toSet(),
              0, 3, Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries has been assigned the correct value", () {
      final entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(uuid.v4(), "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries1, 0, 3, Duration(seconds: 10));
      final entries2 = fullyRandomTest.entries;
      expect(entries1, entries2);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(
          () =>
              FullyRandomTest(uuid.v4(), fieldList, entries, 0, 0, Duration()),
          throwsArgumentError);
      expect(
          () =>
              FullyRandomTest(uuid.v4(), fieldList, entries, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, entries, 0, 3, Duration());
      var triesNumber = fullyRandomTest.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
        () {
      expect(() {
        final fullyRandomTest =
            FullyRandomTest(uuid.v4(), fieldList, entries, 0, 3, Duration());
        fullyRandomTest.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final fullyRandomTest = FullyRandomTest(
            uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
        fullyRandomTest.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      var elapsedTime = fullyRandomTest.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      fullyRandomTest.elapsedTime = Duration(minutes: 1);
      elapsedTime = fullyRandomTest.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
  group("checkAnAnswer method tests", () {
    test("DO_NOT_IGNORE_CASE", () {
      FieldList fieldList1 = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final fieldList1 = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.IGNORE_CASE);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answr1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1, anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1, \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 ,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_DO_NOT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answr1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1, anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    aNswer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1,    answEr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answER1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1, \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 ,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    aNswer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1    answEr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answER1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
  });
  test("_wrongAnswers is an empty Map while object construction", () {
    final fullyRandomTest = FullyRandomTest(
        uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
    Map<String, List<String>> wrongAnswers = fullyRandomTest.wrongAnswers;
    expect(0, wrongAnswers.length);
  });
}
