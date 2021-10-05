import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/enhanced_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  final FieldList fieldList =
      FieldList(uuid.v4(), "list1", uuid.v4(), DateTime.now());
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => EnhancedTest("", fieldList, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => EnhancedTest("weuwe", fieldList, 0, 1, Duration()),
          throwsArgumentError);
      expect(() => EnhancedTest(uuid.v4(), fieldList, 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final enhancedTest =
          EnhancedTest(uuidString, fieldList, 0, 1, Duration());
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
          EnhancedTest(uuid.v4(), fieldList1, 0, 1, Duration());
      final fieldListId = enhancedTest.fieldList.id;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(() => EnhancedTest(uuid.v4(), fieldList, -1, 1, Duration()),
          throwsArgumentError);
    });
    test("increaseCurrentQuestionCounterByOne method test", () {
      final enhancedTest = EnhancedTest(uuid.v4(), fieldList, 3, 1, Duration());
      enhancedTest.increaseCurrentQuestionCounterByOne();
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(4, currentQuestionCounter);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final enhancedTest = EnhancedTest(uuid.v4(), fieldList, 3, 1, Duration());
      var currentQuestionCounter = enhancedTest.currentQuestionCounter;
      expect(3, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(() => EnhancedTest(uuid.v4(), fieldList, 0, 0, Duration()),
          throwsArgumentError);
      expect(() => EnhancedTest(uuid.v4(), fieldList, 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final enhancedTest = EnhancedTest(uuid.v4(), fieldList, 0, 3, Duration());
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
            EnhancedTest(uuid.v4(), fieldList, 0, 3, Duration());
        enhancedTest.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final enhancedTest =
            EnhancedTest(uuid.v4(), fieldList, 0, 3, Duration(seconds: 10));
        enhancedTest.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final enhancedTest =
          EnhancedTest(uuid.v4(), fieldList, 0, 3, Duration(seconds: 10));
      var elapsedTime = enhancedTest.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      enhancedTest.elapsedTime = Duration(minutes: 1);
      elapsedTime = enhancedTest.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
}
