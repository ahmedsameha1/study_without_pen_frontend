import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../fields/domain/models/field_entity.dart';
import 'field_list_entity.dart';

part 'field_lists_page_data.freezed.dart';

@freezed
abstract class FieldListsPageData with _$FieldListsPageData {
  const factory FieldListsPageData({
    FieldEntity? field,
    required List<(FieldListEntity, int)> fieldListsWithEntriesCount,
  }) = _FieldListsPageData;
}
