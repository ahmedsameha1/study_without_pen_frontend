import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/entry.dart';
import 'package:study_without_pen_by_flutter/domain_model/text_entry.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(
          () => TextEntry(
              "", "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry("uewf", "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final textEntry = TextEntry(uuidString, "question", "answer", uuid.v4(),
          DateTime.utc(2020, 1, 1));
      final id = textEntry.id;
      expect(uuidString, id);
    });
  });
  group("_answer tests", () {
    test("_answer isn't an empty string", () {
      expect(
          () => TextEntry(
              uuid.v4(), "question", "", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "";
      }, throwsArgumentError);
    });
    test(
        "_answer doesn't start with whitespace and doesn't end with whitespace",
        () {
      expect(
          () => TextEntry(
              uuid.v4(), "question", " ", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "question", " f", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "question", "f ", uuid.v4(), DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", " f ", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "f\t", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "\nf", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "\rf", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(
              uuid.v4(), "question", "f", uuid.v4(), DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "f t", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "ff tt", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "ff tt h", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "ff tt. h", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "ff\ttt. h", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "ff\ntt. h", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(
          () => TextEntry(uuid.v4(), "question", "ff tt.\rh", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = " ";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = " f";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "f ";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = " f ";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "f\t";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "\nf";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "\rf";
      }, throwsArgumentError);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "f";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "f t";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "ff tt";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "ff tt h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "ff tt. h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "ff\rtt. h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "ff\ntt. h";
      }, returnsNormally);
      expect(() {
        final textEntry = TextEntry(
            uuid.v4(), "question", "ff", uuid.v4(), DateTime.utc(2020, 1, 1));
        textEntry.answer = "ff tt.\th";
      }, returnsNormally);
    });
    test("_answer has been assigned the correct value", () {
      var textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      var answer = textEntry.answer;
      expect("answer", answer);
      textEntry.answer = "answer2";
      answer = textEntry.answer;
      expect("answer2", answer);
    });
  });
  group("_fieldListId tests", () {
    test("_fieldListId is a valid UUID", () {
      expect(
          () => TextEntry(
              uuid.v4(), "question", "answer", "", DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", "ohgewh",
              DateTime.utc(2020, 1, 1)),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1)),
          returnsNormally);
    });
    test("_fieldListId has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final textEntry = TextEntry(uuid.v4(), "question", "answer", uuidString,
          DateTime.utc(2020, 1, 1));
      final fieldListId = textEntry.fieldListId;
      expect(uuidString, fieldListId);
    });
  });
  group("_askedCount tests", () {
    test("_askedCount isn't a negative integer", () {
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1),
              askedCount: -1),
          throwsArgumentError);
    });
    test("_askedCount has been assigned the correct value", () {
      var textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      var askedCount = textEntry.askedCount;
      expect(Entry.ASKED_COUNT_DEFAULT, askedCount);
      textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
          askedCount: 10);
      askedCount = textEntry.askedCount;
      expect(10, askedCount);
      textEntry.increaseAskedCountByOne();
      askedCount = textEntry.askedCount;
      expect(11, askedCount);
    });
  });
  group("_wronglyAnsweredCount tests", () {
    test("_wronglyAnsweredCount isn't a negative integer", () {
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1),
              wronglyAnsweredCount: -1),
          throwsArgumentError);
    });
    test("_wronglyAnsweredCount has been assigned the correct value", () {
      var textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      var wronglyAnsweredCount = textEntry.wronglyAnsweredCount;
      expect(Entry.ASKED_COUNT_DEFAULT, wronglyAnsweredCount);
      textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
          wronglyAnsweredCount: 10);
      wronglyAnsweredCount = textEntry.wronglyAnsweredCount;
      expect(10, wronglyAnsweredCount);
      textEntry.increaseWronglyAnsweredCountByOne();
      wronglyAnsweredCount = textEntry.wronglyAnsweredCount;
      expect(11, wronglyAnsweredCount);
    });
  });
  test("_rank has been assigned the correct value", () {
    var textEntry = TextEntry(
        uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
    var rank = textEntry.rank;
    expect(Entry.RANK_DEFAULT, rank);
    textEntry = TextEntry(
        uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
        rank: Rank.IMPORTANT);
    rank = textEntry.rank;
    expect(Rank.IMPORTANT, rank);
    textEntry.rank = Rank.MODERATE;
    rank = textEntry.rank;
    expect(Rank.MODERATE, rank);
  });
  group("_emulatedCreatedAt tests", () {
    test("_emulatedCreatedAt cannot be set to past DateTime", () {
      withClock(Clock.fixed(clock.now()), () {
        expect(() {
          var textEntry = TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1));
          textEntry.emulatedCreatedAt =
              clock.now().subtract(Duration(days: 500));
        }, throwsArgumentError);
      });
    });
    test("_emulatedCreatedAt has been assigned the correct value", () {
      var textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      var emulateCreatedAt = textEntry.emulatedCreatedAt;
      expect(Entry.EMULATED_CREATED_AT_DEFAULT, emulateCreatedAt);
      textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
          emulatedCreatedAt: DateTime.utc(2020, 1, 1));
      emulateCreatedAt = textEntry.emulatedCreatedAt;
      expect(DateTime.utc(2020, 1, 1), emulateCreatedAt);
      withClock(Clock.fixed(clock.now()), () {
        textEntry.emulatedCreatedAt = clock.now().add(Duration(days: 500));
        emulateCreatedAt = textEntry.emulatedCreatedAt;
        expect(clock.now().add(Duration(days: 500)), emulateCreatedAt);
      });
      textEntry.emulatedCreatedAt = null;
      emulateCreatedAt = textEntry.emulatedCreatedAt;
      expect(null, emulateCreatedAt);
    });
  });
  test("_didAskedAtCurrentTestRound has been assigned the correct value", () {
    var textEntry = TextEntry(
        uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
    var didAskedAtCurrentTestRound = textEntry.didAskedAtCurrentTestRound;
    expect(Entry.DID_ASKED_AT_CURRENT_TEST_ROUND_DEFAULT,
        didAskedAtCurrentTestRound);
    textEntry = TextEntry(
        uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
        didAskedAtCurrentTestRound: false);
    didAskedAtCurrentTestRound = textEntry.didAskedAtCurrentTestRound;
    expect(false, didAskedAtCurrentTestRound);
    textEntry.didAskedAtCurrentTestRound = true;
    didAskedAtCurrentTestRound = textEntry.didAskedAtCurrentTestRound;
    expect(true, didAskedAtCurrentTestRound);
  });
  group("_order tests", () {
    test("_order cannot be smaller than one", () {
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1),
              order: -1),
          throwsArgumentError);
      expect(
          () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
              DateTime.utc(2020, 1, 1),
              order: 0),
          throwsArgumentError);
      expect(() {
        var textEntry = TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
            DateTime.utc(2020, 1, 1));
        textEntry.order = 0;
      }, throwsArgumentError);
      expect(() {
        var textEntry = TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
            DateTime.utc(2020, 1, 1));
        textEntry.order = -1;
      }, throwsArgumentError);
    });
    test("_order has been assigned the correct value", () {
      var textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      var order = textEntry.order;
      expect(Entry.ORDER_DEFAULT, order);
      textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
          order: 3);
      order = textEntry.order;
      expect(3, order);
      textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1),
          order: null);
      order = textEntry.order;
      expect(null, order);
      textEntry.order = 5;
      order = textEntry.order;
      expect(5, order);
      textEntry.order = null;
      order = textEntry.order;
      expect(null, order);
    });
  });
  group("_createdAt test", () {
    test("_createdAt cannot be in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        expect(
            () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
                clock.now().add(Duration(days: 500))),
            throwsArgumentError);
        expect(
            () => TextEntry(
                uuid.v4(), "question", "answer", uuid.v4(), clock.now()),
            returnsNormally);
        expect(
            () => TextEntry(uuid.v4(), "question", "answer", uuid.v4(),
                clock.now().subtract(Duration(days: 500))),
            returnsNormally);
      });
    });
    test("_createdAt has been assigned the correct value", () {
      final textEntry = TextEntry(
          uuid.v4(), "question", "answer", uuid.v4(), DateTime.utc(2020, 1, 1));
      final createdAt = textEntry.createdAt;
      expect(DateTime.utc(2020, 1, 1), createdAt);
    });
  });
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
