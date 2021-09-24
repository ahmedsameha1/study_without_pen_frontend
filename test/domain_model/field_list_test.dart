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
  test("_sortBy has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name");
    var sortBy = fieldList.sortBy;
    expect(SortBy.CREATION_DATE_DESC, sortBy);
    fieldList = FieldList(uuid.v4(), "name", sortBy: SortBy.ANSWER_ASC);
    sortBy = fieldList.sortBy;
    expect(SortBy.ANSWER_ASC, sortBy);
    fieldList.sortBy = SortBy.QUESTION_ASC;
    sortBy = fieldList.sortBy;
    expect(SortBy.QUESTION_ASC, sortBy);
  });
  test("_color has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name");
    var color = fieldList.color;
    expect(Color(0xffffffff), color);
    fieldList = FieldList(uuid.v4(), "name", color: Color(0xff00ff00));
    color = fieldList.color;
    expect(Color(0xff00ff00), color);
    fieldList.color = Color(0xff0000ff);
    color = fieldList.color;
    expect(Color(0xff0000ff), color);
  });
  group("_questionAreaSize tests", () {
    test("_questionAreaSize cannot be smaller than 1", () {
      expect(() => FieldList(uuid.v4(), "name", questionAreaSize: 0),
          throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name", questionAreaSize: -1),
          throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name");
        fieldList.questionAreaSize = 0;
      }, throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name");
        fieldList.questionAreaSize = -1;
      }, throwsArgumentError);
    });
    test("_questionAreaSize has been assigned the correct value", () {
      var fieldList = FieldList(uuid.v4(), "name");
      var questionAreaSize = fieldList.questionAreaSize;
      expect(1, questionAreaSize);
      fieldList = FieldList(uuid.v4(), "name", questionAreaSize: 2);
      questionAreaSize = fieldList.questionAreaSize;
      expect(2, questionAreaSize);
      fieldList.questionAreaSize = 3;
      questionAreaSize = fieldList.questionAreaSize;
      expect(3, questionAreaSize);
    });
  });
  group("_answerAreaSize tests", () {
    test("_answerAreaSize cannot be smaller than 1", () {
      expect(() => FieldList(uuid.v4(), "name", answerAreaSize: 0),
          throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name", answerAreaSize: -1),
          throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name");
        fieldList.answerAreaSize = 0;
      }, throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name");
        fieldList.answerAreaSize = -1;
      }, throwsArgumentError);
    });
    test("_answerAreaSize has been assigned the correct value", () {
      var fieldList = FieldList(uuid.v4(), "name");
      var answerAreaSize = fieldList.answerAreaSize;
      expect(1, answerAreaSize);
      fieldList = FieldList(uuid.v4(), "name", answerAreaSize: 2);
      answerAreaSize = fieldList.answerAreaSize;
      expect(2, answerAreaSize);
      fieldList.answerAreaSize = 3;
      answerAreaSize = fieldList.answerAreaSize;
      expect(3, answerAreaSize);
    });
  });
  test("_testTextSize tests", () {
    var fieldList = FieldList(uuid.v4(), "name");
    var testTextSize = fieldList.testTextSize;
    expect(FieldList.TEST_TEXT_SIZE_DEFAULT, testTextSize);
    fieldList = FieldList(uuid.v4(), "name", testTextSize: TestTextSize.SMALL);
    testTextSize = fieldList.testTextSize;
    expect(TestTextSize.SMALL, testTextSize);
    fieldList.testTextSize = TestTextSize.SO_LARGE;
    testTextSize = fieldList.testTextSize;
    expect(TestTextSize.SO_LARGE, testTextSize);
  });
}
