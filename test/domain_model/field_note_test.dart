import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/notes.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FieldNote(""), throwsArgumentError);
      expect(() => FieldNote("hewh"), throwsArgumentError);
      expect(() => FieldNote(uuid.v4()), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldNote = FieldNote(uuidString);
      final id = fieldNote.id;
      expect(uuidString, id);
    });
  });
}
