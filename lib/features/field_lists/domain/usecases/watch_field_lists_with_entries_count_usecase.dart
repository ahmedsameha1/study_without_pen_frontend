import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../../../fields/data/repositories/fields_repository.dart';
import '../../data/repositories/field_lists_repository.dart';
import '../models/field_lists_page_data.dart';

class WatchFieldListsWithEntriesCountUsecase {
  WatchFieldListsWithEntriesCountUsecase(
    this._fieldsRepository,
    this._fieldListsRepository,
  );
  final FieldsRepository _fieldsRepository;
  final FieldListsRepository _fieldListsRepository;
  Stream<FieldListsPageData> call(String fieldId) {
    Stream<FieldListsPageData> streamOfFieldListsPageData = Rx.combineLatest2(
      _fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
      _fieldsRepository.watchField(fieldId),
      (fieldListsWithEntriesCount, field) => FieldListsPageData(
        fieldListsWithEntriesCount: fieldListsWithEntriesCount,
        field: field,
      ),
    );
    return streamOfFieldListsPageData;
  }
}
