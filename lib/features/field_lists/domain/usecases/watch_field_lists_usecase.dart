import 'dart:async';

import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';

class WatchFieldListsUsecase {
  WatchFieldListsUsecase(this._fieldsRepository, this._fieldListsRepository);
  final FieldsRepository _fieldsRepository;
  final FieldListsRepository _fieldListsRepository;
  Stream<FieldListsPageData> call(String fieldId) {
    StreamController<FieldListsPageData> streamController = StreamController<FieldListsPageData>();
    List<FieldListEntity>? fieldListEntityList;
    String? fieldName;
    bool fieldreturned = false;
    _fieldListsRepository.watch(fieldId).listen((list) {
      fieldListEntityList = list;
      if (fieldreturned) {
        streamController.add(FieldListsPageData(
            fieldName: fieldName, fieldLists: fieldListEntityList!));
      }
    });
    _fieldsRepository.watchField(fieldId).listen((field) {
      fieldreturned = true;
      if (field != null) {
        fieldName = field.name;
      }
      if (fieldListEntityList != null) {
        streamController.add(FieldListsPageData(
            fieldName: fieldName, fieldLists: fieldListEntityList!));
      }
    });
    return streamController.stream;
  }
}
