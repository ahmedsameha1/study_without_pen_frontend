import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_period.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final FieldList fieldList = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  final List<TextEntry> entries = List<TextEntry>.unmodifiable([TextEntry(uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1))]);
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
      final studyPeriod = StudyPeriod(uuidString, fieldList, entries, 0, 1, Duration());
      final id = studyPeriod.id;
      expect(uuidString, id);
    });
  });
  group("_fieldList tests", () {
    test("_fieldList has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final FieldList fieldList1 = FieldList(uuidString, "list1", uuid.v4(), DateTime.now());
      final studyPeriod = StudyPeriod(uuid.v4(), fieldList1, entries, 0, 1, Duration());
      final fieldListId = studyPeriod.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(() => StudyPeriod(uuid.v4(), fieldList, entries, -1, 1, Duration()),
          throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries, 0, 1, Duration());
        studyPeriod.currentQuestionCounter = -1;
      }, throwsArgumentError);
    });
    test(
        "_currentQuestionCounter cannot be set to be smaller than or equal its current value",
        () {
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries, 3, 1, Duration());
        studyPeriod.currentQuestionCounter = 3;
      }, throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries, 3, 1, Duration());
        studyPeriod.currentQuestionCounter = 2;
      }, throwsArgumentError);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries, 3, 1, Duration());
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      studyPeriod.currentQuestionCounter = 5;
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(5, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(() => StudyPeriod(uuid.v4(), fieldList, entries, 0, 0, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), fieldList, entries, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries, 0, 3, Duration());
      var triesNumber = studyPeriod.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
        () {
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries, 0, 3, Duration());
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final studyPeriod =
            StudyPeriod(uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), fieldList, entries, 0, 3, Duration(seconds: 10));
      var elapsedTime = studyPeriod.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      studyPeriod.elapsedTime = Duration(minutes: 1);
      elapsedTime = studyPeriod.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
  group("_entries tests", () {
   test("_entries cannot be an empty list", () {
     expect(() =>
         StudyPeriod(uuid.v4(), fieldList, List<TextEntry>.empty(), 0, 3,
             Duration(seconds: 10)),
         throwsArgumentError);
   });
   test("_entries cannot be a growable list", () {
     expect(() =>
         StudyPeriod(uuid.v4(), fieldList, entries.toList(), 0, 3, Duration(seconds: 10)),
         throwsArgumentError);
   });
   test("_entries cannot has the same entries more than once", () {
    final stringUuid1 = uuid.v4();
    final textEntry = TextEntry(stringUuid1, "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
    // TODO Should I test the equality by overriding the == operator on TextEntry?
    expect(() =>
        StudyPeriod(uuid.v4(), fieldList, List.unmodifiable([textEntry, textEntry]), 0, 3, Duration(seconds: 10)),
        throwsArgumentError);
   });
   test("_entries has been assigned the correct value", () {
     final entries1 = List<TextEntry>.unmodifiable([TextEntry(uuid.v4(), "question1", "answer1", uuid.v4(), DateTime.utc(2020, 1, 1)),
       TextEntry(uuid.v4(), "question2", "answer2", uuid.v4(), DateTime.utc(2020, 1, 1))]);
    final studyPeriod = StudyPeriod(uuid.v4(), fieldList, entries1, 0, 3, Duration(seconds: 10));
    final entries2 = studyPeriod.entries;
    expect(entries1, entries2);
   });
  });
}
