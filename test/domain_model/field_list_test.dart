import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FieldList("", "name", uuid.v4()), throwsArgumentError);
      expect(() => FieldList("whfw", "name", uuid.v4()), throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name", uuid.v4()), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldList = FieldList(uuidString, "name", uuid.v4());
      final id = fieldList.id;
      expect(uuidString, id);
    });
  });
  group("_name tests", () {
    test("_name isn't empty", () {
      expect(() => FieldList(uuid.v4(), "", uuid.v4()), throwsArgumentError);
      expect(() {
        final field = FieldList(uuid.v4(), "name", uuid.v4());
        field.name = "";
      }, throwsArgumentError);
    });
    test("_name has length that is not greater than 64 character", () {
      expect(
          () => FieldList(
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
              uuid.v4()),
          throwsArgumentError);
      expect(() {
        final field = FieldList(uuid.v4(), "name", uuid.v4());
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
      final field = FieldList(uuid.v4(), "name", uuid.v4());
      var name = field.name;
      expect("name", name);
      field.name = "name2";
      name = field.name;
      expect("name2", name);
    });
  });
  group("_fieldId tests", () {
    test("_fieldId is a valid UUID", () {
      expect(() => FieldList(uuid.v4(), "name", ""), throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name", "huew"), throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name", uuid.v4()), returnsNormally);
    });
    test("_fieldId has been assigned the correct value", () {
      final uuidString = uuid.v4();
      final fieldList = FieldList(uuid.v4(), "name", uuidString);
      final fieldId = fieldList.fieldId;
      expect(uuidString, fieldId);
    });
  });
  test("_locale has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var locale = fieldList.locale;
    expect(null, locale);
    fieldList = FieldList(uuid.v4(), "name", uuid.v4(), locale: null);
    locale = fieldList.locale;
    expect(null, locale);
    fieldList.locale = Locale("fr", "CA");
    locale = fieldList.locale;
    expect(Locale("fr", "CA"), locale);
    fieldList =
        FieldList(uuid.v4(), "name", uuid.v4(), locale: Locale("fr", "CA"));
    locale = fieldList.locale;
    expect(Locale("fr", "CA"), locale);
    fieldList.locale = null;
    locale = fieldList.locale;
    expect(null, locale);
  });
  test("_checkType has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var checkType = fieldList.checkType;
    expect(FieldList.CHECK_TYPE_DEFAULT, checkType);
    fieldList = FieldList(uuid.v4(), "name", uuid.v4(),
        checkType: CheckType.DO_NOT_IGNORE_CASE);
    checkType = fieldList.checkType;
    expect(CheckType.DO_NOT_IGNORE_CASE, checkType);
    fieldList.checkType = CheckType.IGNORE_CASE;
    checkType = fieldList.checkType;
    expect(CheckType.IGNORE_CASE, checkType);
  });
  test("_sortBy has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var sortBy = fieldList.sortBy;
    expect(FieldList.SORT_BY_DEFAULT, sortBy);
    fieldList =
        FieldList(uuid.v4(), "name", uuid.v4(), sortBy: SortBy.ANSWER_ASC);
    sortBy = fieldList.sortBy;
    expect(SortBy.ANSWER_ASC, sortBy);
    fieldList.sortBy = SortBy.QUESTION_ASC;
    sortBy = fieldList.sortBy;
    expect(SortBy.QUESTION_ASC, sortBy);
  });
  test("_color has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var color = fieldList.color;
    expect(Color(0xffffffff), color);
    fieldList =
        FieldList(uuid.v4(), "name", uuid.v4(), color: Color(0xff00ff00));
    color = fieldList.color;
    expect(Color(0xff00ff00), color);
    fieldList.color = Color(0xff0000ff);
    color = fieldList.color;
    expect(Color(0xff0000ff), color);
  });
  group("_questionAreaSize tests", () {
    test("_questionAreaSize cannot be smaller than 1", () {
      expect(() => FieldList(uuid.v4(), "name", uuid.v4(), questionAreaSize: 0),
          throwsArgumentError);
      expect(
          () => FieldList(uuid.v4(), "name", uuid.v4(), questionAreaSize: -1),
          throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
        fieldList.questionAreaSize = 0;
      }, throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
        fieldList.questionAreaSize = -1;
      }, throwsArgumentError);
    });
    test("_questionAreaSize has been assigned the correct value", () {
      var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
      var questionAreaSize = fieldList.questionAreaSize;
      expect(1, questionAreaSize);
      fieldList = FieldList(uuid.v4(), "name", uuid.v4(), questionAreaSize: 2);
      questionAreaSize = fieldList.questionAreaSize;
      expect(2, questionAreaSize);
      fieldList.questionAreaSize = 3;
      questionAreaSize = fieldList.questionAreaSize;
      expect(3, questionAreaSize);
    });
  });
  group("_answerAreaSize tests", () {
    test("_answerAreaSize cannot be smaller than 1", () {
      expect(() => FieldList(uuid.v4(), "name", uuid.v4(), answerAreaSize: 0),
          throwsArgumentError);
      expect(() => FieldList(uuid.v4(), "name", uuid.v4(), answerAreaSize: -1),
          throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
        fieldList.answerAreaSize = 0;
      }, throwsArgumentError);
      expect(() {
        var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
        fieldList.answerAreaSize = -1;
      }, throwsArgumentError);
    });
    test("_answerAreaSize has been assigned the correct value", () {
      var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
      var answerAreaSize = fieldList.answerAreaSize;
      expect(1, answerAreaSize);
      fieldList = FieldList(uuid.v4(), "name", uuid.v4(), answerAreaSize: 2);
      answerAreaSize = fieldList.answerAreaSize;
      expect(2, answerAreaSize);
      fieldList.answerAreaSize = 3;
      answerAreaSize = fieldList.answerAreaSize;
      expect(3, answerAreaSize);
    });
  });
  test("_testTextSize has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var testTextSize = fieldList.testTextSize;
    expect(FieldList.TEST_TEXT_SIZE_DEFAULT, testTextSize);
    fieldList = FieldList(uuid.v4(), "name", uuid.v4(),
        testTextSize: TestTextSize.SMALL);
    testTextSize = fieldList.testTextSize;
    expect(TestTextSize.SMALL, testTextSize);
    fieldList.testTextSize = TestTextSize.SO_LARGE;
    testTextSize = fieldList.testTextSize;
    expect(TestTextSize.SO_LARGE, testTextSize);
  });
  test("_isInfoBarShown has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var isInfoBarShown = fieldList.isInfoBarShown;
    expect(FieldList.IS_INFO_BAR_SHOWN_DEFAULT, isInfoBarShown);
    fieldList = FieldList(uuid.v4(), "name", uuid.v4(), isInfoBarShown: false);
    isInfoBarShown = fieldList.isInfoBarShown;
    expect(false, isInfoBarShown);
    fieldList.isInfoBarShown = true;
    isInfoBarShown = fieldList.isInfoBarShown;
    expect(true, isInfoBarShown);
  });
  test("_doesReadAnswer has been assigned the correct value", () {
    var fieldList = FieldList(uuid.v4(), "name", uuid.v4());
    var doesReadAnswer = fieldList.doesReadAnswer;
    expect(FieldList.DOES_READ_ANSWER_DEFAULT, doesReadAnswer);
    fieldList = FieldList(uuid.v4(), "name", uuid.v4(), doesReadAnswer: true);
    doesReadAnswer = fieldList.doesReadAnswer;
    expect(true, doesReadAnswer);
    fieldList.doesReadAnswer = false;
    doesReadAnswer = fieldList.doesReadAnswer;
    expect(false, doesReadAnswer);
  });
  group("_usageCount tests", () {
    test("_usageCount cannot be negative", () {
      expect(() => FieldList(uuid.v4(), "name", uuid.v4(), usageCount: -1),
          throwsArgumentError);
      expect(() {
        final field = FieldList(uuid.v4(), "name", uuid.v4());
        field.usageCount = -1;
      }, throwsArgumentError);
      expect(() {
        final field = FieldList(uuid.v4(), "name", uuid.v4(), usageCount: 10);
        field.usageCount = 10;
      }, throwsArgumentError);
      expect(() {
        final field = FieldList(uuid.v4(), "name", uuid.v4(), usageCount: 10);
        field.usageCount = 9;
      }, throwsArgumentError);
    });
    test("_usageCount has been assigned the correct value", () {
      var field = FieldList(uuid.v4(), "name", uuid.v4());
      var usageCount = field.usageCount;
      expect(FieldList.USAGE_COUNT_DEFAULT, usageCount);
      field = FieldList(uuid.v4(), "name", uuid.v4(), usageCount: 10);
      usageCount = field.usageCount;
      expect(10, usageCount);
      field.usageCount = 11;
      usageCount = field.usageCount;
      expect(11, usageCount);
    });
  });
}
