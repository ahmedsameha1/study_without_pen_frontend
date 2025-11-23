import 'dart:async';
import 'package:rxdart/rxdart.dart';


import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';

class WatchFieldListsUsecase {
  WatchFieldListsUsecase(this._fieldsRepository, this._fieldListsRepository);
  final FieldsRepository _fieldsRepository;
  final FieldListsRepository _fieldListsRepository;
  Stream<FieldListsPageData> call(String fieldId) {
    Stream<FieldListsPageData> streamOfFieldListsPageData =
        Rx.combineLatest2(_fieldListsRepository.watch(fieldId),
            _fieldsRepository.watchField(fieldId),
            (fieldLists, field) =>
                FieldListsPageData(fieldLists: fieldLists, field: field));
    return streamOfFieldListsPageData;
  }
}
