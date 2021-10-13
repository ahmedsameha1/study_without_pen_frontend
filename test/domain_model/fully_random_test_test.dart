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
  final Map<String, List<String>> hints = {textEntryId: []};
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(
          () =>
              FullyRandomTest("", fieldList, entries, hints, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () => FullyRandomTest(
              "weuwe", fieldList, entries, hints, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () => FullyRandomTest(
              uuid.v4(), fieldList, entries, hints, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fullyRandomTest = FullyRandomTest(
          uuidString, fieldList, entries, hints, 0, 1, Duration());
      final id = fullyRandomTest.id;
      expect(uuidString, id);
    });
  });
  group("_fieldList tests", () {
    test("_fieldList has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final FieldList fieldList1 =
          FieldList(uuidString, "list1", uuid.v4(), DateTime.now());
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries, hints, 0, 1, Duration());
      final fieldListId = fullyRandomTest.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(
          () => FullyRandomTest(
              uuid.v4(), fieldList, entries, hints, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("increaseCurrentQuestionCounterByOne method test", () {
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 3, 1, Duration());
      fullyRandomTest.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(4, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 3, 1, Duration());
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_entries tests", () {
    test("_entries cannot be an empty list", () {
      expect(
          () => FullyRandomTest(
              uuid.v4(),
              fieldList,
              Set<TextEntry>.unmodifiable([]),
              hints,
              0,
              3,
              Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries cannot be a growable list", () {
      expect(
          () => FullyRandomTest(uuid.v4(), fieldList, entries.toList().toSet(),
              hints, 0, 3, Duration(seconds: 10)),
          throwsArgumentError);
    });
    test("_entries has been assigned the correct value", () {
      var textEntryId1 = uuid.v4(), textEntryId2 = uuid.v4();
      final entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final Map<String, List<String>> hints1 = {
        textEntryId1: [],
        textEntryId2: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries1, hints1, 0, 3, Duration(seconds: 10));
      final entries2 = fullyRandomTest.entries;
      expect(entries1, entries2);
    });
  });
  group("hints tests", () {
    test("hints must match entries in entries ids", () {
      var textEntryId1 = uuid.v4(), textEntryId2 = uuid.v4();
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(uuid.v4(), "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(uuid.v4(), "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: [], textEntryId2: []};
      expect(
          () => FullyRandomTest(uuid.v4(), fieldList, entries1, hints, 0, 3,
              Duration(seconds: 10)),
          throwsArgumentError);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      expect(
          () => FullyRandomTest(uuid.v4(), fieldList, entries1, hints, 0, 3,
              Duration(seconds: 10)),
          returnsNormally);
    });
    test("hints has been assigned the correct value", () {
      var textEntryId1 = uuid.v4(), textEntryId2 = uuid.v4();
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: [], textEntryId2: []};
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries1, hints, 0, 3, Duration(seconds: 10));
      final gotenHints = fullyRandomTest.hints;
      expect(hints, gotenHints);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(
          () => FullyRandomTest(
              uuid.v4(), fieldList, entries, hints, 0, 0, Duration()),
          throwsArgumentError);
      expect(
          () => FullyRandomTest(
              uuid.v4(), fieldList, entries, hints, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration());
      var triesNumber = fullyRandomTest.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
        () {
      expect(() {
        final fullyRandomTest = FullyRandomTest(
            uuid.v4(), fieldList, entries, hints, 0, 3, Duration());
        fullyRandomTest.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final fullyRandomTest = FullyRandomTest(
            uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
        fullyRandomTest.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
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
        TextEntry(textEntryId, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      final fieldList1 = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.IGNORE_CASE);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answr1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1, anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1, \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 ,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_DO_NOT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      var fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answr1");
      var result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1, anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,    aNswer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1,    answEr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answER1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1,    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1, \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 ,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1,\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1, answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1,\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1   nswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("ansWer1 anwer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("Answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    answer1\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\tanSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1    aNswer1\t");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\ranSwer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\t\ranSwer1    answEr1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answER1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("\nanSwer1    answer1\r");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \nanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\tanswer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1 \r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\n\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("anSwer1\t\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(false, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1\r\n answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1    answer1\r\n");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
      fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      fullyRandomTest.checkAnAnswer("answer1\r answer1");
      result = fullyRandomTest.lastCheckedAnswerResult;
      expect(true, result);
    });
  });
  test(
      "_wrongAnswers is populated with an empty list for each entry in entries while object construction",
      () {
    final fullyRandomTest = FullyRandomTest(
        uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
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
      Map<String, List<String>> hints = {textEntryId1: []};
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {textEntryId1: []};
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {textEntryId1: []};
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {textEntryId1: []};
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answe answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {textEntryId1: []};
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answe answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer1 answer1");
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("answe answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer2 answer2");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer3 answer3");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      expect([], wrongAnswers[textEntryId3]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer answer2");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer3 answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer2 answer2");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer3 answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect([], wrongAnswers[textEntryId1]);
      expect([], wrongAnswers[textEntryId2]);
      expect([], wrongAnswers[textEntryId3]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer1 answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer1 answer1");
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer2 answer2");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect([], wrongAnswers[textEntryId2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect([], wrongAnswers[textEntryId2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer3 answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect([], wrongAnswers[textEntryId2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
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
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer1 answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer answer1");
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId2, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer2");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer2 answer2");
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer answer2");
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId3, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer3 answer3");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("nswer2 answer2", wrongAnswers[textEntryId2]![1]);
      expect("nswer answer2", wrongAnswers[textEntryId2]![2]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      expect("nswer answer3", wrongAnswers[textEntryId3]![2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(3, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
    });
    test(
        "Three entries, three tries, two answered wrongly, one answered correctly",
        () {
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
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: []
      };
      final fullyRandomTest = FullyRandomTest(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      TextEntry currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer1");
      var triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      var wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      var isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer1 answer1");
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(0, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer answer1");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId2, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer2");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("answer2 answer2");
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      currentEntry = fullyRandomTest.currentEntry;
      expect(textEntryId3, currentEntry.id);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
      fullyRandomTest.checkAnAnswer("answer answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(1, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer3 answer3");
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(2, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(1, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(false, isCompleted);
      fullyRandomTest.checkAnAnswer("nswer answer3");
      expect(() {
        fullyRandomTest.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = fullyRandomTest.triesCounter;
      expect(3, triesCounter);
      fullyRandomTest.next();
      currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      wrongAnswers = fullyRandomTest.wrongAnswers;
      expect("answer answer1", wrongAnswers[textEntryId1]![0]);
      expect("nswer1 answer1", wrongAnswers[textEntryId1]![1]);
      expect("nswer answer1", wrongAnswers[textEntryId1]![2]);
      expect("answer answer2", wrongAnswers[textEntryId2]![0]);
      expect("answer answer3", wrongAnswers[textEntryId3]![0]);
      expect("nswer3 answer3", wrongAnswers[textEntryId3]![1]);
      expect("nswer answer3", wrongAnswers[textEntryId3]![2]);
      triesCounter = fullyRandomTest.triesCounter;
      expect(0, triesCounter);
      wrongAnswerCounter = fullyRandomTest.wrongAnswerCounter;
      expect(2, wrongAnswerCounter);
      isCompleted = fullyRandomTest.isCompleted;
      expect(true, isCompleted);
      expect(() {
        fullyRandomTest.next();
      }, throwsStateError);
    });
  });
}
