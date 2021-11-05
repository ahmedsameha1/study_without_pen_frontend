import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/notes.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FieldListNote("", "note", uuid.v4()), throwsArgumentError);
      expect(() => FieldListNote("hewh", "note", uuid.v4()), throwsArgumentError);
      expect(() => FieldListNote(uuid.v4(), "note", uuid.v4()), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldListNote = FieldListNote(uuidString, "note", uuid.v4());
      final id = fieldListNote.id;
      expect(uuidString, id);
    });
  });
  group("_text tests", () {
    test("_text isn't empty String", () {
      expect(() => FieldListNote(uuid.v4(), "", uuid.v4()), throwsArgumentError);
      expect(() {
        final fieldListNote = FieldListNote(uuid.v4(), "note", uuid.v4());
        fieldListNote.text = "";
      }, throwsArgumentError);
    });
    test("_text has been assigned the correct value", () {
      final fieldListNote = FieldListNote(uuid.v4(), "note", uuid.v4());
      var text = fieldListNote.text;
      expect("note", text);
      fieldListNote.text = "note2";
      text = fieldListNote.text;
      expect("note2", text);
    });
    test("lastModifiedAt has been updated when _text reassigned", () {
      withClock(Clock.fixed(clock.now()), () {
        final fieldListNote = FieldListNote(uuid.v4(), "note", uuid.v4());
        fieldListNote.text = "note2";
        final lastModifiedAt = fieldListNote.lastModifiedAt;
        expect(clock.now(), lastModifiedAt);
      });
    });
  });
  group("_fieldListId tests", () {
    test("_fieldListId is a valid UUID", () {
      expect(() => FieldListNote(uuid.v4(), "note", ""), throwsArgumentError);
      expect(() => FieldListNote(uuid.v4(), "note", "eufb"), throwsArgumentError);
      expect(() => FieldListNote(uuid.v4(), "note", uuid.v4()), returnsNormally);
    });
    test("_fieldListId has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldListNote = FieldListNote(uuid.v4(), "note", uuidString);
      final fieldListId = fieldListNote.fieldListId;
      expect(uuidString, fieldListId);
    });
  });
}
