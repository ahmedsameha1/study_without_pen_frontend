import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => Entry("", "answer"), throwsArgumentError);
      expect(() => Entry("uewf", "answer"), throwsArgumentError);
      expect(() => Entry(uuid.v4(), "answer"), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final entry = Entry(uuidString, "answer");
      final id = entry.id;
      expect(uuidString, id);
    });
  });
  group("_answer tests", () {
   test("_answer isn't an empty string", () {
     expect(() => Entry(uuid.v4(), ""), throwsArgumentError);
     expect(() {
      final entry = Entry(uuid.v4(), "ff");
      entry.answer = "";
     }, throwsArgumentError);
   });
   test("_answer doesn't start with whitespace and doesn't end with whitespace", () {
     expect(() => Entry(uuid.v4(), " "), throwsArgumentError);
     expect(() => Entry(uuid.v4(), " f"), throwsArgumentError);
     expect(() => Entry(uuid.v4(), "f "), throwsArgumentError);
     expect(() => Entry(uuid.v4(), " f "), throwsArgumentError);
     expect(() => Entry(uuid.v4(), "f\t"), throwsArgumentError);
     expect(() => Entry(uuid.v4(), "\nf"), throwsArgumentError);
     expect(() => Entry(uuid.v4(), "\rf"), throwsArgumentError);
     expect(() => Entry(uuid.v4(), "f"), returnsNormally);
     expect(() => Entry(uuid.v4(), "f t"), returnsNormally);
     expect(() => Entry(uuid.v4(), "ff tt"), returnsNormally);
     expect(() => Entry(uuid.v4(), "ff tt h"), returnsNormally);
     expect(() => Entry(uuid.v4(), "ff tt. h"), returnsNormally);
     expect(() => Entry(uuid.v4(), "ff\ttt. h"), returnsNormally);
     expect(() => Entry(uuid.v4(), "ff\ntt. h"), returnsNormally);
     expect(() => Entry(uuid.v4(), "ff tt.\rh"), returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = " ";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = " f";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "f ";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = " f ";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "f\t";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "\nf";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "\rf";
     }, throwsArgumentError);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "f";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "f t";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "ff tt";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "ff tt h";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "ff tt. h";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "ff\rtt. h";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "ff\ntt. h";
     }, returnsNormally);
     expect(() {
       final entry = Entry(uuid.v4(), "ff");
       entry.answer = "ff tt.\th";
     }, returnsNormally);
   });
   test("_answer has been assigned the correct value", () {
    var entry = Entry(uuid.v4(), "answer");
    var answer = entry.answer;
    expect("answer", answer);
    entry.answer = "answer2";
    answer = entry.answer;
    expect("answer2", answer);
   });
  });
}