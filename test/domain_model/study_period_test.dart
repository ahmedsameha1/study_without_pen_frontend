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
      expect(() => StudyPeriod("", fieldList, entries, hints, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () =>
              StudyPeriod("weuwe", fieldList, entries, hints, 0, 1, Duration()),
          throwsArgumentError);
      expect(
          () => StudyPeriod(
              uuid.v4(), fieldList, entries, hints, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod =
          StudyPeriod(uuidString, fieldList, entries, hints, 0, 1, Duration());
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
          StudyPeriod(uuid.v4(), fieldList1, entries, hints, 0, 1, Duration());
      final fieldListId = studyPeriod.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(
          () => StudyPeriod(
              uuid.v4(), fieldList, entries, hints, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("resetCurrentQuestionCounterToZero() test", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, hints, 10, 1, Duration());
      studyPeriod.resetCurrentQuestionCounterToZero();
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
    });
    test("increaseCurrentQuestionCounterByOne() test", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, hints, 10, 1, Duration());
      studyPeriod.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(11, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, hints, 3, 1, Duration());
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(
          () => StudyPeriod(
              uuid.v4(), fieldList, entries, hints, 0, 0, Duration()),
          throwsArgumentError);
      expect(
          () => StudyPeriod(
              uuid.v4(), fieldList, entries, hints, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, hints, 0, 3, Duration());
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
            StudyPeriod(uuid.v4(), fieldList, entries, hints, 0, 3, Duration());
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(
            uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
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
          () => StudyPeriod(
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
          () => StudyPeriod(uuid.v4(), fieldList, entries.toList().toSet(),
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
      Map<String, List<String>> hints = {textEntryId1: [], textEntryId2: []};
      final studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries1, hints, 0, 3, Duration(seconds: 10));
      final entries2 = studyPeriod.entries;
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
          () => StudyPeriod(uuid.v4(), fieldList, entries1, hints, 0, 3,
              Duration(seconds: 10)),
          throwsArgumentError);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      expect(
          () => StudyPeriod(uuid.v4(), fieldList, entries1, hints, 0, 3,
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
      final studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries1, hints, 0, 3, Duration(seconds: 10));
      final gotenHints = studyPeriod.hints;
      expect(hints, gotenHints);
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
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
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
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answr1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1, anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1, \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 ,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_IGNORE_CASE);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
    test("NON_STRICT_DO_NOT_IGNORE_CASE", () {
      var entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1, answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      var fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answr1");
      var result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1, anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,    aNswer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1,    answEr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answER1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1,    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1, \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 ,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1,\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1, answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1,\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      entries1 = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      fieldList1 = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1   nswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("ansWer1 anwer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("Answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    answer1\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\tanSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1    aNswer1\t");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\ranSwer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\t\ranSwer1    answEr1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answER1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("\nanSwer1    answer1\r");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \nanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\tanswer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1 \r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\n\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("anSwer1\t\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(false, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1\r\n answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1 answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1    answer1\r\n");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
      studyPeriod = StudyPeriod(
          uuid.v4(), fieldList1, entries1, hints, 0, 1, Duration(seconds: 10));
      studyPeriod.checkAnAnswer("answer1\r answer1");
      result = studyPeriod.lastCheckedAnswerResult;
      expect(true, result);
    });
  });
  group("Session workflow tests", () {
    test("one entry, one try, one round, answered correctly", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: []};
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 1, Duration(seconds: 10));
      TextEntry currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer1 answer1");
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test("one entry, one try, three rounds", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: []};
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 1, Duration(seconds: 10));
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer answer1");
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      var newEntries = studyPeriod.entries;
      expect(1, newEntries.length);
      expect(textEntryId1, newEntries.elementAt(0).id);
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      //Second Round
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      newEntries = studyPeriod.entries;
      expect(1, newEntries.length);
      expect(textEntryId1, newEntries.elementAt(0).id);
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      //Third Round
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test("one entry, three tries, one round", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: []};
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer1 answer1");
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test("one entry, three tries, answered at second try, one round", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: []};
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer answer1");
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test("one entry, three tries, two rounds", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: []};
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer answer1");
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(currentEntry));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      var newEntries = studyPeriod.entries;
      expect(1, newEntries.length);
      expect(textEntryId1, newEntries.elementAt(0).id);
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      //Second round
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test("one entry, three tries, answered at the third try, one round", () {
      var textEntryId1 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {textEntryId1: []};
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer answer1");
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.checkAnAnswer("answer answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.checkAnAnswer("answer1 answer1");
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test(
        "three entries, three tries, all answered correctly first try, one round",
        () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      Set<TextEntry> entries = Set<TextEntry>.unmodifiable([
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
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10));
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer1 answer1");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
    test(
        "First Round 5, second round 3, third round 3, fourth round 2, last round 1",
        () {
      var textEntryId1 = uuid.v4();
      var textEntryId2 = uuid.v4();
      var textEntryId3 = uuid.v4();
      var textEntryId4 = uuid.v4();
      var textEntryId5 = uuid.v4();
      var entries = Set<TextEntry>.unmodifiable([
        TextEntry(textEntryId1, "question1", "answer1 answer1", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId2, "question2", "answer2 answer2", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId3, "question3", "answer3 answer3", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId4, "question4", "answer4 answer4", uuid.v4(),
            DateTime.utc(2020, 1, 1)),
        TextEntry(textEntryId5, "question5", "answer5 answer5", uuid.v4(),
            DateTime.utc(2020, 1, 1))
      ]);
      Map<String, List<String>> hints = {
        textEntryId1: [],
        textEntryId2: [],
        textEntryId3: [],
        textEntryId4: [],
        textEntryId5: []
      };
      FieldList fieldList = FieldList(
          uuid.v4(), "list1", uuid.v4(), DateTime.now(),
          checkType: CheckType.DO_NOT_IGNORE_CASE);
      var studyPeriod = StudyPeriod(
          uuid.v4(), fieldList, entries, hints, 0, 3, Duration(seconds: 10),
          seed: 1);
      var currentEntry = studyPeriod.currentEntry;
      expect(textEntryId1, currentEntry.id);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
      studyPeriod.checkAnAnswer("answer answer1");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      var triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      var repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      var shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      var isCompleted = studyPeriod.isCompleted;
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer2 answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
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
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer4 answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(4, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(4, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(4, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(3, repeatedEntries.length);
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(1)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(3)));
      expect(true, repeatedEntries.contains(studyPeriod.entries.elementAt(4)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(4, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer5 answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      var newEntries = studyPeriod.entries;
      expect(3, newEntries.length);
      expect(true, newEntries.contains(entries.elementAt(1)));
      expect(true, newEntries.contains(entries.elementAt(3)));
      expect(true, newEntries.contains(entries.elementAt(4)));
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(entries.elementAt(4), currentEntry);
      //Second Round all will be answered wrongly
      studyPeriod.checkAnAnswer("answer answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer5 answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer4 answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(3, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(3, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(3, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(4)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer2 answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      newEntries = studyPeriod.entries;
      expect(3, newEntries.length);
      expect(true, newEntries.contains(entries.elementAt(1)));
      expect(true, newEntries.contains(entries.elementAt(3)));
      expect(true, newEntries.contains(entries.elementAt(4)));
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(entries.elementAt(1), currentEntry);
      //Third Round two will be answered wrongly
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer2 answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer4 answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(2, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      expect(true, repeatedEntries.contains(entries.elementAt(3)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(2, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer5 answer5");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      newEntries = studyPeriod.entries;
      expect(2, newEntries.length);
      expect(true, newEntries.contains(entries.elementAt(1)));
      expect(true, newEntries.contains(entries.elementAt(3)));
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(entries.elementAt(3), currentEntry);
      //Fourth Round one will be answered wrongly
      studyPeriod.checkAnAnswer("answer4 answer4");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(3, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(true, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      triesCounter = studyPeriod.triesCounter;
      expect(0, triesCounter);
      studyPeriod.checkAnAnswer("answer answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(1, repeatedEntries.length);
      expect(true, repeatedEntries.contains(entries.elementAt(1)));
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      studyPeriod.checkAnAnswer("answer2 answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(2, triesCounter);
      studyPeriod.next();
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(0, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(false, isCompleted);
      newEntries = studyPeriod.entries;
      expect(1, newEntries.length);
      expect(true, newEntries.contains(entries.elementAt(1)));
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      currentEntry = studyPeriod.currentEntry;
      expect(entries.elementAt(1), currentEntry);
      //Fifth Round answer the only entry correctly
      studyPeriod.checkAnAnswer("answer2 answer2");
      expect(() {
        studyPeriod.checkAnAnswer("userAnswerff");
      }, throwsStateError);
      triesCounter = studyPeriod.triesCounter;
      expect(1, triesCounter);
      studyPeriod.next();
      repeatedEntries = studyPeriod.repeatedEntries;
      expect(0, repeatedEntries.length);
      shouldShowTheCorrectAnswer = studyPeriod.shouldShowTheCorrectAnswer;
      expect(false, shouldShowTheCorrectAnswer);
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(1, currentQuestionCounter);
      isCompleted = studyPeriod.isCompleted;
      expect(true, isCompleted);
      expect(() {
        studyPeriod.next();
      }, throwsStateError);
    });
  });
}
