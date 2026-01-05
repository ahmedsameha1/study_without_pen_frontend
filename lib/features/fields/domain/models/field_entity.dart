import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'field_entity.freezed.dart';

//TODO implement correct validation
@freezed
abstract class FieldEntity with _$FieldEntity {
  FieldEntity._(this.name)
      : assert(
            name.trim().length >= Fields.MINIMUM_LENGTH_OF_NAME &&
            //TODO remove this trim
                name.trim().length <= Fields.MAXIMUM_LENGTH_OF_NAME,
            'Field name must be between 1 and 64 characters');
  factory FieldEntity(
      String? id,
      String userAccountId,
      String name,
      DateTime creationAt,
      DateTime lastModificationAt,
      int usageCount,
      int color) = _FieldEntity;

  @override
  final String name;
}
