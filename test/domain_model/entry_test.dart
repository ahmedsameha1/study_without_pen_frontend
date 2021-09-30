import 'package:clock/clock.dart';
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
  test("_rank has been assigned the correct value", () {
    var entry = Entry(uuid.v4(), "answer", uuid.v4());
    var rank = entry.rank;
    expect(Entry.RANK_DEFAULT, rank);
    entry = Entry(uuid.v4(), "answer", uuid.v4(), rank: Rank.IMPORTANT);
    rank = entry.rank;
    expect(Rank.IMPORTANT, rank);
    entry.rank = Rank.MODERATE;
    rank = entry.rank;
    expect(Rank.MODERATE, rank);
  });
  group("_emulatedCreatedAt tests", () {
    test("_emulatedCreatedAt cannot be set to past DateTime", () {
      withClock(Clock.fixed(clock.now()), () {
        expect(() {
          var entry = Entry(uuid.v4(), "answer", uuid.v4());
          entry.emulatedCreatedAt = clock.now().subtract(Duration(days: 500));
        }, throwsArgumentError);
      });
    });
    test("_emulatedCreatedAt has been assigned the correct value", () {
      var entry = Entry(uuid.v4(), "answer", uuid.v4());
      var emulateCreatedAt = entry.emulatedCreatedAt;
      expect(Entry.EMULATED_CREATED_AT_DEFAULT, emulateCreatedAt);
      entry = Entry(uuid.v4(), "answer", uuid.v4(),
          emulatedCreatedAt: DateTime.utc(2020, 1, 1));
      emulateCreatedAt = entry.emulatedCreatedAt;
      expect(DateTime.utc(2020, 1, 1), emulateCreatedAt);
      withClock(Clock.fixed(clock.now()), () {
        entry.emulatedCreatedAt = clock.now().add(Duration(days: 500));
        emulateCreatedAt = entry.emulatedCreatedAt;
        expect(clock.now().add(Duration(days: 500)), emulateCreatedAt);
      });
      entry.emulatedCreatedAt = null;
      emulateCreatedAt = entry.emulatedCreatedAt;
      expect(null, emulateCreatedAt);
    });
  });
  test("_didAskedAtCurrentTestRound has been assigned the correct value", () {
    var entry = Entry(uuid.v4(), "answer", uuid.v4());
    var didAskedAtCurrentTestRound = entry.didAskedAtCurrentTestRound;
    expect(Entry.DID_ASKED_AT_CURRENT_TEST_ROUND_DEFAULT,
        didAskedAtCurrentTestRound);
    entry = Entry(uuid.v4(), "answer", uuid.v4(),
        didAskedAtCurrentTestRound: false);
    didAskedAtCurrentTestRound = entry.didAskedAtCurrentTestRound;
    expect(false, didAskedAtCurrentTestRound);
    entry.didAskedAtCurrentTestRound = true;
    didAskedAtCurrentTestRound = entry.didAskedAtCurrentTestRound;
    expect(true, didAskedAtCurrentTestRound);
  });
  group("_order tests", () {
    test("_order cannot be smaller than one", () {
      expect(() => Entry(uuid.v4(), "answer", uuid.v4(), order: -1),
          throwsArgumentError);
      expect(() => Entry(uuid.v4(), "answer", uuid.v4(), order: 0),
          throwsArgumentError);
      expect(() {
        var entry = Entry(uuid.v4(), "answer", uuid.v4());
        entry.order = 0;
      }, throwsArgumentError);
      expect(() {
        var entry = Entry(uuid.v4(), "answer", uuid.v4());
        entry.order = -1;
      }, throwsArgumentError);
    });
    test("_order has been assigned the correct value", () {
      var entry = Entry(uuid.v4(), "answer", uuid.v4());
      var order = entry.order;
      expect(Entry.ORDER_DEFAULT, order);
      entry = Entry(uuid.v4(), "answer", uuid.v4(), order: 3);
      order = entry.order;
      expect(3, order);
      entry = Entry(uuid.v4(), "answer", uuid.v4(), order: null);
      order = entry.order;
      expect(null, order);
      entry.order = 5;
      order = entry.order;
      expect(5, order);
      entry.order = null;
      order = entry.order;
      expect(null, order);
    });
  });
}
