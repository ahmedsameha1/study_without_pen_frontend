import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/domain_model/so_basic.dart';

abstract class Entry extends HasRelationalId {
  static const int ASKED_COUNT_DEFAULT = 0;
  static const int WRONGLY_ANSWERED_COUNT_DEFAULT = 0;
  static const Rank RANK_DEFAULT = Rank.LOW;
  static const DateTime? EMULATED_CREATED_AT_DEFAULT = null;
  static const bool DID_ASKED_AT_CURRENT_TEST_ROUND_DEFAULT = true;
  static const int? ORDER_DEFAULT = null;
  late String _answer;
  int _askedCount = ASKED_COUNT_DEFAULT;
  int _wronglyAnsweredCount = WRONGLY_ANSWERED_COUNT_DEFAULT;
  Rank _rank = RANK_DEFAULT;
  DateTime? _emulatedCreatedAt = EMULATED_CREATED_AT_DEFAULT;
  bool _didAskedAtCurrentTestRound = DID_ASKED_AT_CURRENT_TEST_ROUND_DEFAULT;
  int? _order = ORDER_DEFAULT;
  late DateTime _createdAt;
  // TODO Do we need last modification at or last fetch time

  Entry(String uuid, String answer, String fieldListId, DateTime createdAt,
      {int askedCount = ASKED_COUNT_DEFAULT,
      int wronglyAnsweredCount = WRONGLY_ANSWERED_COUNT_DEFAULT,
      Rank rank = RANK_DEFAULT,
      DateTime? emulatedCreatedAt = EMULATED_CREATED_AT_DEFAULT,
      bool didAskedAtCurrentTestRound = DID_ASKED_AT_CURRENT_TEST_ROUND_DEFAULT,
      int? order = ORDER_DEFAULT})
      : super(uuid, fieldListId) {
    /////////////////////////////////////////////////////////////////////////
    // _answer validation
    if (answer.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}(\s*\S)*\s{0}$");
      if (!regExp.hasMatch(answer)) {
        throw ArgumentError(
            "_answer cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("_answer cannot be an empty String");
    }
    this._answer = answer;
    /////////////////////////////////////////////////////////////////////////
    // _askedCount validation
    if (askedCount < ASKED_COUNT_DEFAULT) {
      throw ArgumentError("_askedCount cannot be negative integer");
    }
    this._askedCount = askedCount;
    /////////////////////////////////////////////////////////////////////////
    // _wronglyAnsweredCount validation
    if (wronglyAnsweredCount < WRONGLY_ANSWERED_COUNT_DEFAULT) {
      throw ArgumentError("_wronglyAnsweredCount cannot be negative integer");
    }
    this._wronglyAnsweredCount = wronglyAnsweredCount;
    this._rank = rank;
    this._emulatedCreatedAt = emulatedCreatedAt;
    this._didAskedAtCurrentTestRound = didAskedAtCurrentTestRound;
    /////////////////////////////////////////////////////////////////////////
    // _order validation
    if (order != null && order < 1) {
      throw ArgumentError("_order cannot be smaller than 1");
    }
    this._order = order;
    /////////////////////////////////////////////////////////////////////////
    // _createdAt validation
    if (createdAt.isAfter(clock.now())) {
      throw ArgumentError("_createdAt cannot be in the future");
    }
    this._createdAt = createdAt;
  }

  String get answer => _answer;
  String get fieldListId => relationalId;
  int get askedCount => _askedCount;
  int get wronglyAnsweredCount => _wronglyAnsweredCount;
  Rank get rank => _rank;
  DateTime? get emulatedCreatedAt => _emulatedCreatedAt;
  bool get didAskedAtCurrentTestRound => _didAskedAtCurrentTestRound;
  int? get order => _order;
  DateTime get createdAt => _createdAt;

  set answer(String answer) {
    /////////////////////////////////////////////////////////////////////////
    // _answer validation
    if (answer.isNotEmpty) {
      final regExp = RegExp(r"^\s{0}\S{1}(\s*\S)*\s{0}$");
      if (!regExp.hasMatch(answer)) {
        throw ArgumentError(
            "firstName cannot start with whitespace characters and cannot end with whitespace characters");
      }
    } else {
      throw ArgumentError("firstName cannot be an empty String");
    }
    this._answer = answer;
  }

  set rank(Rank rank) {
    this._rank = rank;
  }

  set emulatedCreatedAt(DateTime? emulatedCreatedAt) {
    if (emulatedCreatedAt != null && emulatedCreatedAt.isBefore(clock.now())) {
      throw ArgumentError("_emulatedCreatedAt cannot be in the past");
    }
    this._emulatedCreatedAt = emulatedCreatedAt;
  }

  set didAskedAtCurrentTestRound(bool didAskedAtCurrentTestRound) {
    this._didAskedAtCurrentTestRound = didAskedAtCurrentTestRound;
  }

  set order(int? order) {
    /////////////////////////////////////////////////////////////////////////
    // _order validation
    if (order != null && order < 1) {
      throw ArgumentError("_order cannot be smaller than 1");
    }
    this._order = order;
  }

  increaseAskedCountByOne() {
    _askedCount++;
  }

  increaseWronglyAnsweredCountByOne() {
    _wronglyAnsweredCount++;
  }
}

enum Rank { LOW, MODERATE, IMPORTANT, VITAL }
