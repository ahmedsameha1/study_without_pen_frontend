import 'package:clock/clock.dart';
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.middleNames = null;
      }, returnsNormally);
    });
    test("middleNames isn't empty", () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              false,
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      var isEmailVerified = userAccount.isEmailVerified;
      expect(true, isEmailVerified);
      userAccount.isEmailVerified = false;
      isEmailVerified = userAccount.isEmailVerified;
      expect(false, isEmailVerified);
    });
  });
  group("_createdAt tests", () {
    test("_createdAt can be null while UserAccount construction", () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              true,
              null,
              DateTime.utc(2020, 10, 10),
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
          returnsNormally);
    });
    test("_createdAt cannot be set to null using its setter", () {
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.createdAt = null;
      }, throwsArgumentError);
    });
    test("_createdAt cannot be set if it has a non-null value", () {
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.createdAt = DateTime(2020, 1, 1);
      }, throwsArgumentError);
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
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      var createdAt = userAccount.createdAt;
      expect(DateTime.utc(2020, 7, 7), createdAt);
      userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          null,
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      createdAt = userAccount.createdAt;
      expect(null, createdAt);
      userAccount.createdAt = DateTime.utc(2020, 7, 7);
      createdAt = userAccount.createdAt;
      expect(DateTime.utc(2020, 7, 7), createdAt);
    });
  });
  group("_lastModificationAt tests", () {
    test("_lastModificationAt can be null while UserAccount construction", () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              true,
              DateTime.utc(2020, 7, 7),
              null,
              DateTime.utc(2020, 11, 11),
              DateTime.utc(2020, 12, 12)),
          returnsNormally);
    });
    test(
        "_lastModificationAt cannot be equal or after now while UserAccount construction",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 11, 11)), () {
        expect(
            () => UserAccount(
                "id",
                "name",
                "names",
                "name",
                DateTime.utc(1989, 11, 9),
                Gender.MALE,
                null,
                true,
                DateTime.utc(2020, 7, 7),
                clock.now().add(Duration(days: 500)),
                DateTime.utc(2020, 11, 11),
                DateTime.utc(2020, 12, 12)),
            throwsArgumentError);
        expect(
            () => UserAccount(
                "id",
                "name",
                "names",
                "name",
                DateTime.utc(1989, 11, 9),
                Gender.MALE,
                null,
                true,
                DateTime.utc(2020, 7, 7),
                clock.now(),
                DateTime.utc(2020, 11, 11),
                DateTime.utc(2020, 12, 12)),
            throwsArgumentError);
      });
    });
    test("_lastModificationAt has been updated when firstName has been updated",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.firstName = "name2";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), lastModificationAt);
      });
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.firstName = "name";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), isNot(equals(lastModificationAt)));
      });
    });
    test(
        "_lastModificationAt has been updated when _middleNames has been updated",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.middleNames = "names2";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), lastModificationAt);
      });
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.middleNames = "names";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), isNot(equals(lastModificationAt)));
      });
    });
    test("_lastModificationAt has been updated when _lastName has been updated",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.lastName = "name2";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), lastModificationAt);
      });
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.lastName = "name";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), isNot(equals(lastModificationAt)));
      });
    });
    test("_lastModificationAt has been updated when _birthDay has been updated",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.birthDay = DateTime.utc(1989, 6, 6);
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), lastModificationAt);
      });
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.birthDay = DateTime.utc(1989, 11, 9);
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), isNot(equals(lastModificationAt)));
      });
    });
    test("_lastModificationAt has been updated when _gender has been updated",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.gender = Gender.FEMALE;
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), lastModificationAt);
      });
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.gender = Gender.MALE;
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), isNot(equals(lastModificationAt)));
      });
    });
    test("_lastModificationAt has been updated when _email has been updated",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            null,
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.email = "abc@abc.com";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), lastModificationAt);
      });
      withClock(Clock.fixed(DateTime.utc(2020, 12, 14)), () {
        final userAccount = UserAccount(
            "id",
            "name",
            "names",
            "name",
            DateTime.utc(1989, 11, 9),
            Gender.MALE,
            "abc@abc.com",
            true,
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.email = "abc@abc.com";
        final lastModificationAt = userAccount.lastModificationAt;
        expect(DateTime.utc(2020, 12, 14), isNot(equals(lastModificationAt)));
      });
    });
    test("_lastModificationAt has been assigned the correct value", () {
      var userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      final lastModificationAt = userAccount.lastModificationAt;
      expect(DateTime.utc(2020, 10, 10), lastModificationAt);
    });
  });
  group("_lastSignInAt tests", () {
    test("_lastSignInAt can be null while UserAccount construction", () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              true,
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 8, 8),
              null,
              DateTime.utc(2020, 12, 12)),
          returnsNormally);
    });
    test("_lastSignInAt cannot be set to null using its setter", () {
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.lastSignInAt = null;
      }, throwsArgumentError);
    });
    test("_lastSignInAt has been assigned the correct value", () {
      var userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          null,
          DateTime.utc(2020, 12, 12));
      var lastSignInAt = userAccount.lastSignInAt;
      expect(null, lastSignInAt);
      userAccount.lastSignInAt = DateTime.utc(2020, 11, 11);
      lastSignInAt = userAccount.lastSignInAt;
      expect(DateTime.utc(2020, 11, 11), lastSignInAt);
      userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      lastSignInAt = userAccount.lastSignInAt;
      expect(DateTime.utc(2020, 11, 11), lastSignInAt);
    });
  });
  group("_lastSignOutAt tests", () {
    test("_lastSignOutAt can be null while UserAccount construction", () {
      expect(
          () => UserAccount(
              "id",
              "name",
              "names",
              "name",
              DateTime.utc(1989, 11, 9),
              Gender.MALE,
              null,
              true,
              DateTime.utc(2020, 7, 7),
              DateTime.utc(2020, 8, 8),
              DateTime.utc(2020, 11, 11),
              null),
          returnsNormally);
    });
    test(
        "_lastSignOutAt cannot be equal or after now while UserAccount construction",
        () {
      withClock(Clock.fixed(DateTime.utc(2020, 11, 11)), () {
        expect(
            () => UserAccount(
                "id",
                "name",
                "names",
                "name",
                DateTime.utc(1989, 11, 9),
                Gender.MALE,
                null,
                true,
                DateTime.utc(2020, 7, 7),
                DateTime.utc(2020, 8, 8),
                DateTime.utc(2020, 11, 11),
                clock.now().add(Duration(days: 500))),
            throwsArgumentError);
        expect(
            () => UserAccount(
                "id",
                "name",
                "names",
                "name",
                DateTime.utc(1989, 11, 9),
                Gender.MALE,
                null,
                true,
                DateTime.utc(2020, 7, 7),
                DateTime.utc(2020, 8, 8),
                DateTime.utc(2020, 11, 11),
                clock.now()),
            throwsArgumentError);
      });
    });
    test("_lastSignOutAt cannot be set to null using its setter", () {
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.lastSignOutAt = null;
      }, throwsArgumentError);
    });
    test(
        "_lastSignOutAt cannot be set to be equal or before _lastSignInAt using its setter",
        () {
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.lastSignOutAt = DateTime.utc(2020, 11, 11);
      }, throwsArgumentError);
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
            DateTime.utc(2020, 7, 7),
            DateTime.utc(2020, 10, 10),
            DateTime.utc(2020, 11, 11),
            DateTime.utc(2020, 12, 12));
        userAccount.lastSignOutAt = DateTime.utc(2020, 11, 1);
      }, throwsArgumentError);
    });
    test("_lastSignOutAt has been assigned the correct value", () {
      var userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          null);
      var lastSignOutAt = userAccount.lastSignOutAt;
      expect(null, lastSignOutAt);
      userAccount.lastSignOutAt = DateTime.utc(2020, 11, 13);
      lastSignOutAt = userAccount.lastSignOutAt;
      expect(DateTime.utc(2020, 11, 13), lastSignOutAt);
      userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      lastSignOutAt = userAccount.lastSignOutAt;
      expect(DateTime.utc(2020, 12, 12), lastSignOutAt);
    });
    test("fullName getter return the correct full name", () {
      final userAccount = UserAccount(
          "id",
          "name",
          "names",
          "name",
          DateTime.utc(1989, 11, 9),
          Gender.MALE,
          null,
          true,
          DateTime.utc(2020, 7, 7),
          DateTime.utc(2020, 10, 10),
          DateTime.utc(2020, 11, 11),
          DateTime.utc(2020, 12, 12));
      var fullName = userAccount.fullName;
      expect("name names name", fullName);
      userAccount.middleNames = null;
      fullName = userAccount.fullName;
      expect("name name", fullName);
    });
  });
}
