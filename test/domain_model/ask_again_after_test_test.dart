import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/ask_again_after_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final FieldList fieldList = FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  final List<TextEntry> entries = List<TextEntry>.unmodifiable([TextEntry(uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1))]);
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => AskAgainAfterTest("", fieldList, entries,  0, 1, Duration()),
          throwsArgumentError);
      expect(() => AskAgainAfterTest("weuwe", fieldList, entries,  0, 1, Duration()),
          throwsArgumentError);
      expect(() => AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final askAgainAfterTest = AskAgainAfterTest(uuidString, fieldList, entries,  0, 1, Duration());
      final id = askAgainAfterTest.id;
      expect(uuidString, id);
    });
  });
  group("_fieldList tests", () {
    test("_fieldList has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final FieldList fieldList1 = FieldList(uuidString, "list1", uuid.v4(), DateTime.now());
      final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList1, entries, 0, 1, Duration());
      final fieldListId = askAgainAfterTest.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(() => AskAgainAfterTest(uuid.v4(), fieldList, entries, -1, 1, Duration()),
          throwsArgumentError);
      expect(() {
        final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 1, Duration());
        askAgainAfterTest.currentQuestionCounter = -1;
      }, throwsArgumentError);
    });
    test(
        "_currentQuestionCounter cannot be set to be smaller than or equal its current value",
            () {
          expect(() {
            final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
            askAgainAfterTest.currentQuestionCounter = 3;
          }, throwsArgumentError);
          expect(() {
            final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
            askAgainAfterTest.currentQuestionCounter = 2;
          }, throwsArgumentError);
        });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList, entries, 3, 1, Duration());
      var currentQuestionCounter = askAgainAfterTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      askAgainAfterTest.currentQuestionCounter = 5;
      currentQuestionCounter = askAgainAfterTest.currentQuestionCounter;
      expect(5, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(() => AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 0, Duration()),
          throwsArgumentError);
      expect(() => AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 3, Duration());
      var triesNumber = askAgainAfterTest.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
            () {
          expect(() {
            final askAgainAfterTest = AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 3, Duration());
            askAgainAfterTest.elapsedTime = Duration();
          }, throwsArgumentError);
          expect(() {
            final askAgainAfterTest =
            AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 3, Duration(seconds: 10));
            askAgainAfterTest.elapsedTime = Duration();
          }, throwsArgumentError);
        });
    test("_elapsedTime has been assigned the correct value", () {
      final askAgainAfterTest =
      AskAgainAfterTest(uuid.v4(), fieldList, entries,  0, 3, Duration(seconds: 10));
      var elapsedTime = askAgainAfterTest.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      askAgainAfterTest.elapsedTime = Duration(minutes: 1);
      elapsedTime = askAgainAfterTest.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
}
