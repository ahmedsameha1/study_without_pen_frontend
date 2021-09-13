import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/user_account.dart';

main() {
  group("id tests", () {
    test("id isn't empty", () {
      expect(
          () => UserAccount("", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
    });
    test("id doesn't contain any whitespace characters", () {
      expect(
          () => UserAccount(" ", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("\t", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("\n", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("f\t", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("f ", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("\nf ", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("\tf", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("f\tf", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("f", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
    });
    test("id has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      final id = userAccount.id;
      expect("id", id);
    });
  });
  group("firstName tests", () {
    test("firstName isn't empty", () {
      expect(
          () => UserAccount("id", "", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "";
      }, throwsArgumentError);
    });
    test(
        "firstName doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => UserAccount("id", " ", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", " f", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "f ", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", " f ", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "f", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "f t", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "ff tty", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "ff tty b", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "ff tty b vtewro", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "ff .tty b vtewro", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.firstName = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("firstName has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      var firstName = userAccount.firstName;
      expect("name", firstName);
      userAccount.firstName = "name2";
      firstName = userAccount.firstName;
      expect("name2", firstName);
    });
  });
  group("middleNames tests", () {
    test("middleNames can be null", () {
      expect(
          () => UserAccount("id", "name", null, "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = null;
      }, returnsNormally);
    });
    test("middleNames isn't empty", () {
      expect(
          () => UserAccount("id", "name", "", "name", DateTime.utc(1989, 11, 9),
              Gender.MALE, null, false),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "";
      }, throwsArgumentError);
    });
    test(
        "middleNames doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => UserAccount("id", "name", " ", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", " f", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", "f ", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", " f ", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", "f", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "f t", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "ff tty", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "ff tty b", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "ff tty b vtewro", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "ff .tty b vtewro", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.middleNames = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("middleNames has been assigned the correct value", () {
      var userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      var middleNames = userAccount.middleNames;
      expect("names", middleNames);
      userAccount.middleNames = null;
      middleNames = userAccount.middleNames;
      expect(null, middleNames);
      userAccount = UserAccount("id", "name", null, "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      middleNames = userAccount.middleNames;
      expect(null, middleNames);
      userAccount.middleNames = "names";
      middleNames = userAccount.middleNames;
      expect("names", middleNames);
    });
  });
  group("lastName tests", () {
    test("lastName isn't empty", () {
      expect(
          () => UserAccount("id", "name", "names", "",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "";
      }, throwsArgumentError);
    });
    test(
        "lastName doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => UserAccount("id", "name", "names", " ",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", "names", " f",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", "names", "f ",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", "names", " f ",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          throwsArgumentError);
      expect(
          () => UserAccount("id", "name", "names", "f",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "names", "f t",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "names", "ff tty",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "names", "ff tty b",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "names", "ff tty b vtewro",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(
          () => UserAccount("id", "name", "names", "ff .tty b vtewro",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.lastName = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("lastName has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      var lastName = userAccount.lastName;
      expect("name", lastName);
      userAccount.lastName = "name2";
      lastName = userAccount.lastName;
      expect("name2", lastName);
    });
  });
  group("birthDay tests", () {
    test("birthDay is before now", () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "name",
              DateTime.now().add(Duration(days: 500)),
              Gender.MALE,
              null,
              false),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount("id", "name", "names", "name",
            DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
        userAccount.birthDay = DateTime.now().add(Duration(days: 500));
      }, throwsArgumentError);
    });
    test("birthDay has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      var birthDay = userAccount.birthDay;
      expect(DateTime.utc(1989, 11, 9), birthDay);
      userAccount.birthDay = DateTime.utc(1999, 11, 11);
      birthDay = userAccount.birthDay;
      expect(DateTime.utc(1999, 11, 11), birthDay);
    });
  });
  group("gender tests", () {
    test("gender has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names", "names",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      var gender = userAccount.gender;
      expect(Gender.MALE, gender);
      userAccount.gender = Gender.FEMALE;
      gender = userAccount.gender;
      expect(Gender.FEMALE, gender);
    });
  });
  group("email tests", () {
    test("email can be null", () {
      expect(
          () => UserAccount("id", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, false),
          returnsNormally);
    });
    test("email has been assigned the correct value", () {
      var userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, false);
      var email = userAccount.email;
      expect(null, email);
      userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, "abc@abc.com", false);
      email = userAccount.email;
      expect("abc@abc.com", email);
      userAccount.email = "abc@abc.com";
      email = userAccount.email;
      expect("abc@abc.com", email);
      userAccount.email = null;
      email = userAccount.email;
      expect(null, email);
    });
  });
  group("_isEmailVerified tests", () {
    test("_isEmailVerified has been assigned the correct value", () {
      final userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, true);
      var isEmailVerified = userAccount.isEmailVerified;
      expect(true, isEmailVerified);
      userAccount.isEmailVerified = false;
      isEmailVerified = userAccount.isEmailVerified;
      expect(false, isEmailVerified);
    });
  });
}
