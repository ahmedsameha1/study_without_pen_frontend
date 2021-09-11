import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/user_account.dart';

main() {
  group("id tests", () {
   test("id isn't empty", () {
    expect(() => UserAccount("", "name"), throwsArgumentError);
   });
   test("id doesn't contain any whitespace characters", () {
     expect(() => UserAccount(" ", "name"), throwsArgumentError);
     expect(() => UserAccount("\t", "name"), throwsArgumentError);
     expect(() => UserAccount("\n", "name"), throwsArgumentError);
     expect(() => UserAccount("f\t", "name"), throwsArgumentError);
     expect(() => UserAccount("f ", "name"), throwsArgumentError);
     expect(() => UserAccount("\nf ", "name"), throwsArgumentError);
     expect(() => UserAccount("\tf", "name"), throwsArgumentError);
     expect(() => UserAccount("f\tf", "name"), throwsArgumentError);
     expect(() => UserAccount("f", "name"), returnsNormally);
   });
  });
  group("firstName tests", () {
    test("firstName isn't empty", () {
      expect(() => UserAccount("id", ""), throwsArgumentError);
    });
    test("firstName doesn't start with whitespace and doesn't end with whitespace", () {
      expect(() => UserAccount("id", " "), throwsArgumentError);
      expect(() => UserAccount("id", " f"), throwsArgumentError);
      expect(() => UserAccount("id", "f "), throwsArgumentError);
      expect(() => UserAccount("id", " f "), throwsArgumentError);
      expect(() => UserAccount("id", " f "), throwsArgumentError);
      expect(() => UserAccount("id", "f").firstName, returnsNormally);
      expect(() => UserAccount("id", "f t").firstName, returnsNormally);
      expect(() => UserAccount("id", "ff tty").firstName, returnsNormally);
      expect(() => UserAccount("id", "ff tty b").firstName, returnsNormally);
      expect(() => UserAccount("id", "ff tty b vtewro").firstName, returnsNormally);
      expect(() => UserAccount("id", "ff .tty b vtewro").firstName, returnsNormally);
    });
    test("firstName has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name");
      final firstName = userAccount.firstName;
      expect("name", firstName);
    });
  });
}