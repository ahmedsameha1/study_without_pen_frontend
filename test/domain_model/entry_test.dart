import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => Entry("", "answer", uuid.v4()), throwsArgumentError);
      expect(() => Entry("uewf", "answer", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "answer", uuid.v4()), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final entry = Entry(uuidString, "answer", uuid.v4());
      final id = entry.id;
      expect(uuidString, id);
    });
  });
  group("_answer tests", () {
    test("_answer isn't an empty string", () {
      expect(() => Entry(uuid.v4(), "", uuid.v4()), throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "";
      }, throwsArgumentError);
    });
    test(
        "_answer doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(() => Entry(uuid.v4(), " ", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), " f", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "f ", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), " f ", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "f\t", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "\nf", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "\rf", uuid.v4()), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "f", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "f t", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "ff tt", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "ff tt h", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "ff tt. h", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "ff\ttt. h", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "ff\ntt. h", uuid.v4()), returnsNormally);
      expect(() => Entry(uuid.v4(), "ff tt.\rh", uuid.v4()), returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = " ";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = " f";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "f ";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = " f ";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "f\t";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "\nf";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "\rf";
      }, throwsArgumentError);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "f";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "f t";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "ff tt";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "ff tt h";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "ff tt. h";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "ff\rtt. h";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "ff\ntt. h";
      }, returnsNormally);
      expect(() {
        final entry = Entry(uuid.v4(), "ff", uuid.v4());
        entry.answer = "ff tt.\th";
      }, returnsNormally);
    });
    test("_answer has been assigned the correct value", () {
      var entry = Entry(uuid.v4(), "answer", uuid.v4());
      var answer = entry.answer;
      expect("answer", answer);
      entry.answer = "answer2";
      answer = entry.answer;
      expect("answer2", answer);
    });
  });
  group("_fieldListId tests", () {
    test("_fieldListId is a valid UUID", () {
      expect(() => Entry(uuid.v4(), "answer", ""), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "answer", "ohgewh"), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "answer", uuid.v4()), returnsNormally);
    });
    test("_fieldListId has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final entry = Entry(uuid.v4(), "answer", uuidString);
      final fieldListId = entry.fieldListId;
      expect(uuidString, fieldListId);
    });
  });
  group("_askedCount tests", () {
    test("_askedCount isn't a negative integer", () {
      expect(() => Entry(uuid.v4(), "answer", uuid.v4(), askedCount: -1),
          throwsArgumentError);
    });
    test("_askedCount has been assigned the correct value", () {
      var entry = Entry(uuid.v4(), "answer", uuid.v4());
      var askedCount = entry.askedCount;
      expect(Entry.ASKED_COUNT_DEFAULT, askedCount);
      entry = Entry(uuid.v4(), "answer", uuid.v4(), askedCount: 10);
      askedCount = entry.askedCount;
      expect(10, askedCount);
      entry.increaseAskedCountByOne();
      askedCount = entry.askedCount;
      expect(11, askedCount);
    });
  });
  group("_wronglyAnsweredCount tests", () {
    test("_wronglyAnsweredCount isn't a negative integer", () {
      expect(
          () => Entry(uuid.v4(), "answer", uuid.v4(), wronglyAnsweredCount: -1),
          throwsArgumentError);
    });
    test("_wronglyAnsweredCount has been assigned the correct value", () {
      var entry = Entry(uuid.v4(), "answer", uuid.v4());
      var wronglyAnsweredCount = entry.wronglyAnsweredCount;
      expect(Entry.ASKED_COUNT_DEFAULT, wronglyAnsweredCount);
      entry = Entry(uuid.v4(), "answer", uuid.v4(), wronglyAnsweredCount: 10);
      wronglyAnsweredCount = entry.wronglyAnsweredCount;
      expect(10, wronglyAnsweredCount);
      entry.increaseWronglyAnsweredCountByOne();
      wronglyAnsweredCount = entry.wronglyAnsweredCount;
      expect(11, wronglyAnsweredCount);
    });
  });
}
