import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => Field("", "name"), throwsArgumentError);
      expect(() => Field("whfw", "name"), throwsArgumentError);
      expect(() => Field(uuid.v4(), "name"), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final field = Field(uuidString, "name");
      final id = field.id;
      expect(uuidString, id);
    });
  });
  group("_name tests", () {
    test("_name isn't empty", () {
      expect(() => Field(uuid.v4(), ""), throwsArgumentError);
      expect(() {
        final field = Field(uuid.v4(), "name");
        field.name = "";
      }, throwsArgumentError);
    });
    test("_name has length that is not greater than 64 character", () {
      expect(() => Field(uuid.v4(), """
    fffffffffffffffffffff
    fffffffffffffffff
    fffffffffffffffff
    ffffffffffffffffff
    ffffffffffffffffff
    fffffffffffffffff
    fffffffffffffffff
    fffffffffffffffffff
    fffffffffffffffffff
    ffffffffffffffffff
    """), throwsArgumentError);
      expect(() {
        final field = Field(uuid.v4(), "name");
        field.name = """
    fffffffffffffffffffff
    fffffffffffffffff
    fffffffffffffffff
    ffffffffffffffffff
    ffffffffffffffffff
    fffffffffffffffff
    fffffffffffffffff
    fffffffffffffffffff
    fffffffffffffffffff
    ffffffffffffffffff
    """;
      }, throwsArgumentError);
    });
    test("_name has been assigned the correct value", () {
      final field = Field(uuid.v4(), "name");
      var name = field.name;
      expect("name", name);
      field.name = "name2";
      name = field.name;
      expect("name2", name);
    });
  });
  group("_color test", () {
    test("_color can be null", () {
      expect(() => Field(uuid.v4(), "name", null), returnsNormally);
      expect(() {
        final field = Field(uuid.v4(), "name", 0x0000ff00);
        field.color = null;
      }, returnsNormally);
    });
    test(
        "_color must be equal or smaller than 0xffffffff and must be equal or greater than 0x00000000",
        () {
      expect(() => Field(uuid.v4(), "name", 0xff00ff001), throwsArgumentError);
      expect(() => Field(uuid.v4(), "name", -0x00000001), throwsArgumentError);
      expect(() => Field(uuid.v4(), "name", 0xff00ff00), returnsNormally);
      expect(() {
        final field = Field(uuid.v4(), "name");
        field.color = 0xff00ff001;
      }, throwsArgumentError);
      expect(() {
        final field = Field(uuid.v4(), "name");
        field.color = -0x00000001;
      }, throwsArgumentError);
      expect(() {
        final field = Field(uuid.v4(), "name");
        field.color = 0xff00ff00;
      }, returnsNormally);
    });
    test("_color has been assigned the correct value", () {
      var field = Field(uuid.v4(), "name", null);
      var color = field.color;
      expect(null, color);
      field.color = 0xff00ff00;
      color = field.color;
      expect(0xff00ff00, color);
      field = Field(uuid.v4(), "name", 0xff00ff00);
      color = field.color;
      expect(0xff00ff00, color);
      field.color = null;
      color = field.color;
      expect(null, color);
    });
  });
}
