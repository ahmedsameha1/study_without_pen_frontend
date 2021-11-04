import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/notes.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FieldNote("", "note"), throwsArgumentError);
      expect(() => FieldNote("hewh", "note"), throwsArgumentError);
      expect(() => FieldNote(uuid.v4(), "note"), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldNote = FieldNote(uuidString, "note");
      final id = fieldNote.id;
      expect(uuidString, id);
    });
  });
  group("_text tests", () {
    test("_text isn't empty String", () {
      expect(() => FieldNote(uuid.v4(), ""), throwsArgumentError);
      expect(() {
        final fieldNote = FieldNote(uuid.v4(), "note");
        fieldNote.text = "";
      }, throwsArgumentError);
    });
    test("_text has been assigned the correct value", () {
      final fieldNote = FieldNote(uuid.v4(), "note");
      var text = fieldNote.text;
      expect("note", text);
      fieldNote.text = "note2";
      text = fieldNote.text;
      expect("note2", text);
    });
  });
}
