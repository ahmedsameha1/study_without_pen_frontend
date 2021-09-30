import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_question tests", () {
    test("_question isn't an empty String", () {
      expect(
          () => TextEntry(
              uuid.v4(), "", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "";
      }, throwsArgumentError);
    });
    test(
        "_question doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => TextEntry(
              uuid.v4(), " ", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), " f", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "f ", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), " f ", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "f\t", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "\nf", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "\rf", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "f", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(
              uuid.v4(), "f t", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "ff tt", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "ff tt h", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "ff tt. h", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "ff\ttt. h", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "ff\ntt. h", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "ff tt.\rh", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = " ";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = " f";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "f ";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = " f ";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "f\t";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "\nf";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "\rf";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "f";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "f t";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "ff tt";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "ff tt h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "ff tt. h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "ff\rtt. h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "ff\ntt. h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "ff", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.question = "ff tt.\th";
      }, returnsNormally);
    });
    test("_question has been assigned the correct value", () {
      var textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      var question = textEntry.question;
      expect("question", question);
      textEntry.question = "question2";
      question = textEntry.question;
      expect("question2", question);
    });
  });
}
