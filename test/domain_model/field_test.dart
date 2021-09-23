import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => Field("", "name", "id"), throwsArgumentError);
      expect(() => Field("whfw", "name", "id"), throwsArgumentError);
      expect(() => Field(uuid.v4(), "name", "id"), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final field = Field(uuidString, "name", "id");
      final id = field.id;
      expect(uuidString, id);
    });
  });
  group("_name tests", () {
    test("_name isn't empty", () {
      expect(() => Field(uuid.v4(), "", "id"), throwsArgumentError);
      expect(() {
        final field = Field(uuid.v4(), "name", "id");
        field.name = "";
      }, throwsArgumentError);
    });
    test("_name has length that is not greater than 64 character", () {
      expect(
          () => Field(
              uuid.v4(),
              """
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
    """,
              "id"),
          throwsArgumentError);
      expect(() {
        final field = Field(uuid.v4(), "name", "id");
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
      final field = Field(uuid.v4(), "name", "id");
      var name = field.name;
      expect("name", name);
      field.name = "name2";
      name = field.name;
      expect("name2", name);
    });
  });
  test("_color has been assigned the correct value", () {
    var field = Field(uuid.v4(), "name", "id");
    var color = field.color;
    expect(Color(0xffffffff), color);
    field.color = Color(0xff00ff00);
    color = field.color;
    expect(Color(0xff00ff00), color);
    field = Field(uuid.v4(), "name", "id", color: Color(0xff00ff00));
    color = field.color;
    expect(Color(0xff00ff00), color);
  });
  group("_userAccountId tests", () {
    test("_userAccountId has been assigned the correct value", () {
      var field = Field(uuid.v4(), "name", "id");
      var userAccountId = field.userAccountId;
      expect("id", userAccountId);
    });
  });
}
