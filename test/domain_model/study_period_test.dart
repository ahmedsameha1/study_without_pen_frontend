import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/study_period.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => StudyPeriod("", uuid.v4()), throwsArgumentError);
      expect(() => StudyPeriod("weuwe", uuid.v4()), throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4()), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod = StudyPeriod(uuidString, uuid.v4());
      final id = studyPeriod.id;
      expect(uuidString, id);
    });
  });
  group("_fieldListId tests", () {
    test("_fieldListId is a valid UUID", () {
      expect(() => StudyPeriod(uuid.v4(), ""), throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), "weuwe"), throwsArgumentError);
      expect(() => StudyPeriod(uuid.v4(), uuid.v4()), returnsNormally);
    });
    test("_fieldListId has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final studyPeriod = StudyPeriod(uuid.v4(), uuidString);
      final fieldListId = studyPeriod.fieldListId;
      expect(uuidString, fieldListId);
    });
  });
}