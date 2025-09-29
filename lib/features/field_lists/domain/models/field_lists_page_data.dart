import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

part 'field_lists_page_data.freezed.dart';

@freezed
abstract class FieldListsPageData with _$FieldListsPageData {
  const factory FieldListsPageData({String? fieldName,
  required List<FieldListEntity> fieldLists}) = _FieldListsPageData;
}
