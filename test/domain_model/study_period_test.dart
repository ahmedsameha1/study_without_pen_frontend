import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_period.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => StudyPeriod("", uuid.v4(), 0), throwsArgumentError);
      expect(() => StudyPeriod("weuwe", uuid.v4(), 0), throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), 0), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod = StudyPeriod(uuidString, uuid.v4(), 0);
      final id = studyPeriod.id;
      expect(uuidString, id);
    });
  });
  group("_fieldListId tests", () {
    test("_fieldListId is a valid UUID", () {
      expect(() => StudyPeriod(uuid.v4(), "", 0), throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), "weuwe", 0), throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), 0), returnsNormally);
    });
    test("_fieldListId has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod = StudyPeriod(uuid.v4(), uuidString, 0);
      final fieldListId = studyPeriod.fieldListId;
      expect(uuidString, fieldListId);
    });
  });
  group("_currentQuestionCounter tests", () {
    test("_currentQuestionCounter cannot be negative", () {
      expect(() => StudyPeriod(uuid.v4(), uuid.v4(), -1), throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 0);
        studyPeriod.currentQuestionCounter = -1;
      }, throwsArgumentError);
    });
    test(
        "_currentQuestionCounter cannot be set to be smaller than or equal its current value",
        () {
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 3);
        studyPeriod.currentQuestionCounter = 3;
      }, throwsArgumentError);
      expect(() {
        final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 3);
        studyPeriod.currentQuestionCounter = 2;
      }, throwsArgumentError);
    });
    test("_currentQuestionCounter has been assigned the correct value", () {
      final studyPeriod = StudyPeriod(uuid.v4(), uuid.v4(), 3);
      var currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(3, currentQuestionCounter);
      studyPeriod.currentQuestionCounter = 5;
      currentQuestionCounter = studyPeriod.currentQuestionCounter;
      expect(5, currentQuestionCounter);
    });
  });
}
