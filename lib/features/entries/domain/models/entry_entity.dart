import 'package:clock/clock.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../database/app_database.dart';
import '../../../../database/entrys_dao.dart';
import 'package:uuid/validation.dart';

part 'entry_entity.freezed.dart';

@freezed
abstract class EntryEntity with _$EntryEntity {
  EntryEntity._({
    required this.fieldListId,
    required this.answer,
    required this.question,
    required this.creationAt,
    required this.lastModificationAt,
    required this.order,
    required this.didAskedAtCurrentTestRound,
    required this.rank,
    required this.askedCount,
    required this.wronglyAnsweredCount,
    this.lastAskedAt,
  }) : assert(
         UuidValidation.isValidUUID(fromString: fieldListId),
         'fieldListId is not a valid UUID v4',
       ),
       assert(
         answer.trim().length >= Entrys.minimumTextLength &&
             answer.length <= Entrys.maximumTextLength,
         'answer must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
       ),
       assert(
         question.trim().length >= Entrys.minimumTextLength &&
             question.length <= Entrys.maximumTextLength,
         'question must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
       ),
       assert(
         lastModificationAt == creationAt ||
             lastModificationAt.isAfter(creationAt),
         'lastModificationAt must be equal or after creationAt',
       ),
       assert(
         order >= Entrys.ORDER_MINIMUM_VALUE &&
             order <= Entrys.ORDER_MAXIMUM_VALUE,
         'order must be between ${Entrys.ORDER_MINIMUM_VALUE} and ${Entrys.ORDER_MAXIMUM_VALUE}',
       ),
       assert(
         askedCount >= Entrys.ASKED_COUNT_MINIMUM_VALUE.toInt(),
         'askedCount must be zero or bigger',
       ),
       assert(
         wronglyAnsweredCount >=
             Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE.toInt(),
         'wronglyAnsweredCount must be zero or bigger',
       ),
       assert(
         lastAskedAt == null || !lastAskedAt.isAfter(clock.now()),
         'lastAskedAt cannot be in the future',
       );
  factory EntryEntity({
    String? id,
    required String fieldListId,
    required String answer,
    required String question,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    @Default(Entrys.ORDER_MINIMUM_VALUE) int order,
    @Default(true) bool didAskedAtCurrentTestRound,
    DateTime? emulatedCreatedAt,
    @Default(Rank.normal) Rank rank,
    @Default(0) int askedCount,
    @Default(0) int wronglyAnsweredCount,
    DateTime? lastAskedAt,
  }) = _EntryEntity;
  @override
  final String fieldListId;
  @override
  final String answer;
  @override
  final String question;
  @override
  final DateTime creationAt;
  @override
  final DateTime lastModificationAt;
  @override
  final int order;
  @override
  final bool didAskedAtCurrentTestRound;
  @override
  final Rank rank;
  @override
  final int askedCount;
  @override
  final int wronglyAnsweredCount;
  @override
  double get wrongness {
    if (askedCount == 0) {
      return 0;
    } else {
      return wronglyAnsweredCount / askedCount;
    }
  }

  @override
  final DateTime? lastAskedAt;
}
