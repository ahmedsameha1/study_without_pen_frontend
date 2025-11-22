import 'dart:async';

import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

class WatchFieldListsUsecase {
  WatchFieldListsUsecase(this._fieldsRepository, this._fieldListsRepository);
  final FieldsRepository _fieldsRepository;
  final FieldListsRepository _fieldListsRepository;
  Stream<FieldListsPageData> call(String fieldId) {
    StreamController<FieldListsPageData> streamController =
        StreamController<FieldListsPageData>();
    List<FieldListEntity>? fieldListEntityList;
    FieldEntity? field;
    bool fieldreturned = false;
    _fieldListsRepository.watch(fieldId).listen((list) {
      fieldListEntityList = list;
      if (fieldreturned) {
        streamController.add(
            FieldListsPageData(field: field, fieldLists: fieldListEntityList!));
      }
    });
    _fieldsRepository.watchField(fieldId).listen((field) {
      fieldreturned = true;
      if (fieldListEntityList != null) {
        streamController.add(
            FieldListsPageData(field: field, fieldLists: fieldListEntityList!));
      }
      fieldreturned = false;
    });
    return streamController.stream;
  }
}
