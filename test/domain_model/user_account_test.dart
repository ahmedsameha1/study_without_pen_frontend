import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/user_account.dart';

main() {
  group("id tests", () {
    test("id isn't empty", () {
      expect(
          () => UserAccount(
              "",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
    });
    test("id doesn't contain any whitespace characters", () {
      expect(
          () => UserAccount(
              " ",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "\t",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "\n",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "f\t",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "f ",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "\nf ",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "\tf",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "f\tf",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "f",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
    });
    test("id has been assigned the correct value", () {
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
      final id = userAccount.id;
      expect("id", id);
    });
  });
  group("firstName tests", () {
    test("firstName isn't empty", () {
      expect(
          () => UserAccount(
              "id",
              "",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "";
      }, throwsArgumentError);
    });
    test(
        "firstName doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => UserAccount(
              "id",
              " ",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              " f",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "f ",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              " f ",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "f",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "f t",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "ff tty",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "ff tty b",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "ff tty b vtewro",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "ff .tty b vtewro",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.firstName = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("firstName has been assigned the correct value", () {
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
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
          () => UserAccount(
              "id",
              "name",
              null,
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = null;
      }, returnsNormally);
    });
    test("middleNames isn't empty", () {
      expect(
          () => UserAccount("id", "name", "", "name", DateTime.utc(1989, 11, 9),
              Gender.MALE, null, false, DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "";
      }, throwsArgumentError);
    });
    test(
        "middleNames doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => UserAccount(
              "id",
              "name",
              " ",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              " f",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              "f ",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              " f ",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              "f",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "f t",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "ff tty",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "ff tty b",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "ff tty b vtewro",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "ff .tty b vtewro",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.middleNames = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("middleNames has been assigned the correct value", () {
      var userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
      var middleNames = userAccount.middleNames;
      expect("names", middleNames);
      userAccount.middleNames = null;
      middleNames = userAccount.middleNames;
      expect(null, middleNames);
      userAccount = UserAccount(
          "id",
          "name",
          null,
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
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
          () => UserAccount(
              "id",
              "name",
              "names",
              "",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "";
      }, throwsArgumentError);
    });
    test(
        "lastName doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              " ",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              " f",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "f ",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              " f ",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "f",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "f t",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "ff tty",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "ff tty b",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "ff tty b vtewro",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "ff .tty b vtewro",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = " ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = " f";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = " f ";
      }, throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "f";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "f t";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "ff tty";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "ff tty b";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "ff tty b vtewro";
      }, returnsNormally);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.lastName = "ff .tty b vtewro";
      }, returnsNormally);
    });
    test("lastName has been assigned the correct value", () {
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
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
              false,
              DateTime.utc(2020, 7, 7)),
          throwsArgumentError);
      expect(() {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.birthDay = DateTime.now().add(Duration(days: 500));
      }, throwsArgumentError);
    });
    test("birthDay has been assigned the correct value", () {
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
      var birthDay = userAccount.birthDay;
      expect(DateTime.utc(1989, 11, 9), birthDay);
      userAccount.birthDay = DateTime.utc(1999, 11, 11);
      birthDay = userAccount.birthDay;
      expect(DateTime.utc(1999, 11, 11), birthDay);
    });
  });
  group("gender tests", () {
    test("gender has been assigned the correct value", () {
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "names",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
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
          () => UserAccount(
              "id",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7)),
          returnsNormally);
      expect(() {
        var userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            "abc@abc.com",
            false,
            DateTime.utc(2020, 7, 7));
        userAccount.email = null;
      }, returnsNormally);
    });
    test("email has been assigned the correct value", () {
      var userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          false,
          DateTime.utc(2020, 7, 7));
      var email = userAccount.email;
      expect(null, email);
      userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          "abc@abc.com",
          false,
          DateTime.utc(2020, 7, 7));
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
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7));
      var isEmailVerified = userAccount.isEmailVerified;
      expect(true, isEmailVerified);
      userAccount.isEmailVerified = false;
      isEmailVerified = userAccount.isEmailVerified;
      expect(false, isEmailVerified);
    });
  });
  group("_createdAt tests", () {
    test("_createdAt can be null", () {
      expect(
          () => UserAccount("id", "name", "names", "name",
              DateTime.utc(1989, 11, 9), Gender.MALE, null, true, null),
          returnsNormally);
      expect(() {
        var userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7));
        userAccount.createdAt = null;
      }, returnsNormally);
    });
    test("_created has been assigned the correct value", () {
      var userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7));
      var createdAt = userAccount.createdAt;
      expect(DateTime.utc(2020, 7, 7), createdAt);
      userAccount.createdAt = null;
      createdAt = userAccount.createdAt;
      expect(null, createdAt);
      userAccount = UserAccount("id", "name", "names", "name",
          DateTime.utc(1989, 11, 9), Gender.MALE, null, true, null);
      createdAt = userAccount.createdAt;
      expect(null, createdAt);
      userAccount.createdAt = DateTime.utc(2020, 7, 7);
      createdAt = userAccount.createdAt;
      expect(DateTime.utc(2020, 7, 7), createdAt);
    });
  });
}
