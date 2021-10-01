import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_period.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => StudyPeriod("", uuid.v4(), 0, 1, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod("weuwe", uuid.v4(), 0, 1, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), 0, 1, Duration()),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod = StudyPeriod(uuidString, uuid.v4(), 0, 1, Duration());
      final id = studyPeriod.id;
      expect(uuidString, id);
    });
  });
  group("_fieldListId tests", () {
    test("_fieldListId is a valid UUID", () {
      expect(() => StudyPeriod(uuid.v4(), "", 0, 1, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), "weuwe", 0, 1, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), 0, 1, Duration()),
          returnsNormally);
    });
    test("_fieldListId has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod = StudyPeriod(uuid.v4(), uuidString, 0, 1, Duration());
      final fieldListId = studyPeriod.fieldListId;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), -1, 1, Duration()),
          throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 0, 1, Duration());
        studyPeriod.currentQuestionCounter = -1;
      }, throwsArgumentError);
    });
    test(
        "_currentQuestionCounter cannot be set to be smaller than or equal its current value",
        () {
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 3, 1, Duration());
        studyPeriod.currentQuestionCounter = 3;
      }, throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 3, 1, Duration());
        studyPeriod.currentQuestionCounter = 2;
      }, throwsArgumentError);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 3, 1, Duration());
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      studyPeriod.currentQuestionCounter = 5;
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(5, currentQuestionCounter);
    });
  });
  group("_triesNumber tests", () {
    test("_triesNumber cannot be smaller than one", () {
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), 0, 0, Duration()),
          throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), 0, -1, Duration()),
          throwsArgumentError);
    });
    test("_triesNumber has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 0, 3, Duration());
      var triesNumber = studyPeriod.triesNumber;
      expect(3, triesNumber);
    });
  });
  group("_elapsedTime tests", () {
    test(
        "_elapsedTime cannot be set to be smaller than or equal the current value",
        () {
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 0, 3, Duration());
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
      expect(() {
        final studyPeriod =
            StudyPeriod(uuid.v4(), uuid.v4(), 0, 3, Duration(seconds: 10));
        studyPeriod.elapsedTime = Duration();
      }, throwsArgumentError);
    });
    test("_elapsedTime has been assigned the correct value", () {
      final studyPeriod =
          StudyPeriod(uuid.v4(), uuid.v4(), 0, 3, Duration(seconds: 10));
      var elapsedTime = studyPeriod.elapsedTime;
      expect(Duration(seconds: 10), elapsedTime);
      studyPeriod.elapsedTime = Duration(minutes: 1);
      elapsedTime = studyPeriod.elapsedTime;
      expect(Duration(minutes: 1), elapsedTime);
    });
  });
}
