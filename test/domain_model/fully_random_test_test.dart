import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:study_without_pen_by_flutter/domain_model/fully_random_test.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final FieldList fieldList =
      FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FullyRandomTest("", fieldList, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => FullyRandomTest("weuwe", fieldList, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => FullyRandomTest(uuid.v4(), fieldList, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fullyRandomTest =
          FullyRandomTest(uuidString, fieldList, 0, 1, Duration());
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
          FullyRandomTest(uuid.v4(), fieldList1, 0, 1, Duration());
      final fieldListId = fullyRandomTest.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(() => FullyRandomTest(uuid.v4(), fieldList, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("increaseCurrentQuestionCounterByOne method test", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, 3, 1, Duration());
      fullyRandomTest.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(4, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, 3, 1, Duration());
      var currentQuestionCounter = fullyRandomTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(() => FullyRandomTest(uuid.v4(), fieldList, 0, 0, Duration()),
          throwsArgumentError);
      expect(() => FullyRandomTest(uuid.v4(), fieldList, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, 0, 3, Duration());
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
            FullyRandomTest(uuid.v4(), fieldList, 0, 3, Duration());
        fullyRandomTest.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final fullyRandomTest =
            FullyRandomTest(uuid.v4(), fieldList, 0, 3, Duration(seconds: 10));
        fullyRandomTest.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final fullyRandomTest =
          FullyRandomTest(uuid.v4(), fieldList, 0, 3, Duration(seconds: 10));
      var elapsedTime = fullyRandomTest.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      fullyRandomTest.elapsedTime = Duration(minutes: 1);
      elapsedTime = fullyRandomTest.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
}
