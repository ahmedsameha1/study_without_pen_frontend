import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FieldList("", "name"), throwsArgumentError);
      expect(() => FieldList("whfw", "name"), throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name"), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldList = FieldList(uuidString, "name");
      final id = fieldList.id;
      expect(uuidString, id);
    });
  });
  group("_name tests", () {
    test("_name isn't empty", () {
      expect(() => FieldList(uuid.v4(), ""), throwsArgumentError);
      expect(() {
        final field = FieldList(uuid.v4(), "name");
        field.name = "";
      }, throwsArgumentError);
    });
    test("_name has length that is not greater than 64 character", () {
      expect(() => FieldList(uuid.v4(), """
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
        final field = FieldList(uuid.v4(), "name");
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
      final field = FieldList(uuid.v4(), "name");
      var name = field.name;
      expect("name", name);
      field.name = "name2";
      name = field.name;
      expect("name2", name);
    });
  });
  test("_locale has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name");
    var locale = fieldList.locale;
    expect(null, locale);
    fieldList = FieldList(uuid.v4(), "name", locale: null);
    locale = fieldList.locale;
    expect(null, locale);
    fieldList.locale = Locale("fr", "CA");
    locale = fieldList.locale;
    expect(Locale("fr", "CA"), locale);
    fieldList = FieldList(uuid.v4(), "name", locale: Locale("fr", "CA"));
    locale = fieldList.locale;
    expect(Locale("fr", "CA"), locale);
    fieldList.locale = null;
    locale = fieldList.locale;
    expect(null, locale);
  });
  test("_checkType has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name");
    var checkType = fieldList.checkType;
    expect(CheckType.NON_STRICT_IGNORE_CASE, checkType);
    fieldList =
        FieldList(uuid.v4(), "name", checkType: CheckType.DO_NOT_IGNORE_CASE);
    checkType = fieldList.checkType;
    expect(CheckType.DO_NOT_IGNORE_CASE, checkType);
    fieldList.checkType = CheckType.IGNORE_CASE;
    checkType = fieldList.checkType;
    expect(CheckType.IGNORE_CASE, checkType);
  });
}
