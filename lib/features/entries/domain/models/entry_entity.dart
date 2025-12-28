import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
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
             question.trim().length <= Entrys.maximumTextLength,
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
         rank >= Rank.low.index && rank <= Rank.vital.index,
         'rank must be between ${Rank.low.index} and ${Rank.vital.index}',
       ),
       assert(
         askedCount >= Entrys.ASKED_COUNT_MINIMUM_VALUE.toInt(),
         'askedCount must be zero or bigger',
       ),
       assert(
         wronglyAnsweredCount >=
             Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE.toInt(),
         'wronglyAnsweredCount must be zero or bigger',
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
    @Default(1) int rank,
    @Default(0) int askedCount,
    @Default(0) int wronglyAnsweredCount,
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
  final int rank;
  @override
  final int askedCount;
  @override
  final int wronglyAnsweredCount;
}
