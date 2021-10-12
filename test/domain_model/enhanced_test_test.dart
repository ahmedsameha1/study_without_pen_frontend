import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/sessions.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final textEntryId = uuid.v4();
  final FieldList fieldList =
      FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  final Set<TextEntry> entries = Set<TextEntry>.unmodifiable([
    TextEntry(
        textEntryId, "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1))
  ]);
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => EnhancedTest("", fieldList, entries, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => EnhancedTest("weuwe", fieldList, entries, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () => EnhancedTest(uuid.v4(), fieldList, entries, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final enhancedTest =
          EnhancedTest(uuidString, fieldList, entries, 0, 1, Duration());
      final id = enhancedTest.id;
      expect(uuidString, id);
    });
  });
  group("_fieldList tests", () {
    test("_fieldList has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final FieldList fieldList1 =
          FieldList(uuidString, "list1", uuid.v4(), DateTime.now());
      final enhancedTest =
          EnhancedTest(uuid.v4(), fieldList1, entries, 0, 1, Duration());
      final fieldListId = enhancedTest.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(
          () => EnhancedTest(uuid.v4(), fieldList, entries, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("increaseCurrentQuestionCounterByOne method test", () {
      final enhancedTest =
          EnhancedTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
      enhancedTest.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(4, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final enhancedTest =
          EnhancedTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_entries tests", () {
    test("_entries cannot be an empty list", () {
      expect(
          () => EnhancedTest(uuid.v4(), fieldList,
              Set<TextEntry>.unmodifiable([]), 0, 3, Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries cannot be a growable list", () {
      expect(
          () => EnhancedTest(uuid.v4(), fieldList, entries.toList().toSet(), 0,
              3, Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries has been assigned the correct value", () {
      final entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(uuid.v4(), "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries1, 0, 3, Duration(seconds: 10));
      final entries2 = enhancedTest.entries;
      expect(entries1, entries2);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(
          () => EnhancedTest(uuid.v4(), fieldList, entries, 0, 0, Duration()),
          throwsArgumentError);
      expect(
          () => EnhancedTest(uuid.v4(), fieldList, entries, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final enhancedTest =
          EnhancedTest(uuid.v4(), fieldList, entries, 0, 3, Duration());
      var triesNumber = enhancedTest.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
        () {
      expect(() {
        final enhancedTest =
            EnhancedTest(uuid.v4(), fieldList, entries, 0, 3, Duration());
        enhancedTest.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final enhancedTest = EnhancedTest(
            uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
        enhancedTest.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      var elapsedTime = enhancedTest.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      enhancedTest.elapsedTime = Duration(minutes: 1);
      elapsedTime = enhancedTest.elapsedTime;
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
      var enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("Answer1 answer1");
      var result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answr1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1   nswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("ansWer1 anwer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
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
      var enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answr1");
      var result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1   nswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("ansWer1 anwer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("Answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      var enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1, answr1");
      var result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,   nswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("ansWer1, anwer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1, answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("Answer1, answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\tanSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1\t");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\ranSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\t\ranSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1\r\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1,    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1, \nanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,\tanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1 ,\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\n,\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,\t\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,\r\n answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answr1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1   nswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("ansWer1 anwer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("Answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\tanSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1\t");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\ranSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\t\ranSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1\r\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1 \nanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\tanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1 \r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\n\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\t\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\r\n answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_DO_NOT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      var enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1, answr1");
      var result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,   nswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("ansWer1, anwer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("Answer1, answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    answer1\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\tanSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,    aNswer1\t");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\ranSwer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\t\ranSwer1,    answEr1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answER1,    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1,    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1, \nanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,\tanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1 ,\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\n,\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1,\t\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,\r\n answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1, answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,    answer1\r\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1,\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answr1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1   nswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("ansWer1 anwer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("Answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    answer1\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\tanSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1    aNswer1\t");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\ranSwer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\t\ranSwer1    answEr1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answER1    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("\nanSwer1    answer1\r");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1 \nanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\tanswer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1 \r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\n\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("anSwer1\t\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(false, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1\r\n answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1 answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1    answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1    answer1\r\n");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
      enhancedTest = EnhancedTest(
          uuid.v4(), fieldList1, entries1, 0, 1, Duration(seconds: 10));
      enhancedTest.checkAnAnswer("answer1\r answer1");
      result = enhancedTest.lastCheckedAnswerResult;
      expect(true, result);
    });
  });
  test("_wrongAnswers is populated with an empty list for each entry in entries while object construction", () {
    final fullyRandomTest = FullyRandomTest(
        uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
    Map<String, List<String>> wrongAnswers = fullyRandomTest.wrongAnswers;
    expect(1, wrongAnswers.length);
    expect(true, wrongAnswers.containsKey(textEntryId));
  });
  group("Session workflow tests", () {
    test("One entry, one try, answered correctly", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer1 answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("One entry, one try, answered wrongly", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("One entry, three tries, answered correctly", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer1 answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("One entry, three tries, answered correctly in the third try", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answe answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer1 answer1");
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("One entry, three tries, answered wrongly", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answe answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer1 answer1");
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("Three entries, one try, answered correctly", () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer1 answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer2 answer2");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer3 answer3");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      expect([], wrongAnswers[textEntryId3]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("Three entries, one try, answered two wrongly, one correctly", () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer1 answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer answer2");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer3 answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("Three entries, three tries, answered correctly", () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer1 answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer2 answer2");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer3 answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      expect([], wrongAnswers[textEntryId3]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("Three entries, three tries, answered correctly, two after tries", () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer1 answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer1 answer1");
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer2 answer2");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect([], wrongAnswers[textEntryId2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect([], wrongAnswers[textEntryId2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer3 answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect([], wrongAnswers[textEntryId2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("Three entries, three tries, all answered wrongly", () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer1 answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer answer1");
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = enhancedTest.currentEntry;
      expect(textEntryId2, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer2");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer2 answer2");
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer answer2");
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = enhancedTest.currentEntry;
      expect(textEntryId3, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer3 answer3");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      expect("nswer answer3", wrongAnswers[textEntryId3]![2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(3, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
    test("Three entries, three tries, two answered wrongly, one answered correctly", () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final enhancedTest = EnhancedTest(
          uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = enhancedTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer1");
      var triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      var wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer1 answer1");
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer answer1");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = enhancedTest.currentEntry;
      expect(textEntryId2, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer2");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("answer2 answer2");
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = enhancedTest.currentEntry;
      expect(textEntryId3, currentEntry.id);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
      enhancedTest.checkAnAnswer("answer answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = enhancedTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer3 answer3");
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      triesCounter = enhancedTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(false, isCompleted);
      enhancedTest.checkAnAnswer("nswer answer3");
      expect(() {
        enhancedTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = enhancedTest.triesCounter;
      expect(3, triesCounter);
      enhancedTest.next();
      currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = enhancedTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      expect("nswer answer3", wrongAnswers[textEntryId3]![2]);
      triesCounter = enhancedTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = enhancedTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = enhancedTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        enhancedTest.next();
      }, throwsStateError);
    });
  });
}
