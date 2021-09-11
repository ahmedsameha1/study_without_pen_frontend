import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/user_account.dart';

main() {
  group("id tests", () {
    test("id isn't empty", () {
      expect(() => UserAccount("", "name", "names"), throwsArgumentError);
    });
    test("id doesn't contain any whitespace characters", () {
      expect(() => UserAccount(" ", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("\t", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("\n", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("f\t", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("f ", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("\nf ", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("\tf", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("f\tf", "name", "names"), throwsArgumentError);
      expect(() => UserAccount("f", "name", "names"), returnsNormally);
    });
    test("id has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names");
      final id = userAccount.id;
      expect("id", id);
    });
  });
  group("firstName tests", () {
    test("firstName isn't empty", () {
      expect(() => UserAccount("id", "", "names"), throwsArgumentError);
    });
    test(
        "firstName doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(() => UserAccount("id", " ", "names"), throwsArgumentError);
      expect(() => UserAccount("id", " f", "names"), throwsArgumentError);
      expect(() => UserAccount("id", "f ", "names"), throwsArgumentError);
      expect(() => UserAccount("id", " f ", "names"), throwsArgumentError);
      expect(() => UserAccount("id", "f", "names"), returnsNormally);
      expect(() => UserAccount("id", "f t", "names"), returnsNormally);
      expect(() => UserAccount("id", "ff tty", "names"), returnsNormally);
      expect(() => UserAccount("id", "ff tty b", "names"), returnsNormally);
      expect(
          () => UserAccount("id", "ff tty b vtewro", "names"), returnsNormally);
      expect(() => UserAccount("id", "ff .tty b vtewro", "names"),
          returnsNormally);
    });
    test("firstName has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names");
      final firstName = userAccount.firstName;
      expect("name", firstName);
    });
  });
  group("middleNames tests", () {
    test("middleNames can be null", () {
      expect(() => UserAccount("id", "name", null), returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = null;
      }, returnsNormally);
    });
    test("middleNames isn't empty", () {
      expect(() => UserAccount("id", "name", ""), throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "";
      }, throwsArgumentError);
    });
    test(
        "middleNames doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(() => UserAccount("id", "name", " "), throwsArgumentError);
      expect(() => UserAccount("id", "name", " f"), throwsArgumentError);
      expect(() => UserAccount("id", "name", "f "), throwsArgumentError);
      expect(() => UserAccount("id", "name", " f "), throwsArgumentError);
      expect(() => UserAccount("id", "name", "f"), returnsNormally);
      expect(() => UserAccount("id", "name", "f t"), returnsNormally);
      expect(() => UserAccount("id", "name", "ff tty"), returnsNormally);
      expect(() => UserAccount("id", "name", "ff tty b"), returnsNormally);
      expect(
          () => UserAccount("id", "name", "ff tty b vtewro"), returnsNormally);
      expect(
          () => UserAccount("id", "name", "ff .tty b vtewro"), returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names");
        userAccount.middleNames = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("middleNames has been assigned the correct value", () {
      var userAccount = UserAccount("id", "name", "names");
      var middleNames = userAccount.middleNames;
      expect("names", middleNames);
      userAccount.middleNames = null;
      middleNames = userAccount.middleNames;
      expect(null, middleNames);
      userAccount = UserAccount("id", "name", null);
      middleNames = userAccount.middleNames;
      expect(null, middleNames);
      userAccount.middleNames = "names";
      middleNames = userAccount.middleNames;
      expect("names", middleNames);
    });
  });
}
