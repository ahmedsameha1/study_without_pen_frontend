import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Supports value equality', () {
    String fieldListId = const Uuid().v4();
    DateTime creationAt = DateTime.now();
    EntriesPageData entriesPageData = EntriesPageData(
      fieldList: FieldListEntity(
        fieldId: const Uuid().v4(),
        name: 'name',
        creationAt: creationAt,
        lastModificationAt: creationAt,
      ),
      entries: [],
    );
    expect(
      EntriesSubscriptionRequested(fieldListId),
      EntriesSubscriptionRequested(fieldListId),
    );
    expect(
      EntriesSubscriptionRequested(fieldListId),
      isNot(const EntriesSubscriptionRequested('ohwtgetgw')),
    );
    expect(PrepareScoreTab(), PrepareScoreTab());
    expect(PrepareStrugglingTab(), PrepareStrugglingTab());
    expect(PrepareTodayTab(), PrepareTodayTab());
    expect(PrepareUnseenTab(), PrepareUnseenTab());
    expect(PrepareBrowseTab(), PrepareBrowseTab());
    expect(SwitchToSearchTab(), SwitchToSearchTab());
    expect(OpenSearch(), OpenSearch());
    expect(CloseSearch(), CloseSearch());
    expect(const SearchInputChanged('a'), const SearchInputChanged('a'));
    expect(const SearchInputChanged('a'), isNot(const SearchInputChanged('b')));
    expect(const SubmitSearch('a'), const SubmitSearch('a'));
    expect(const SubmitSearch('a'), isNot(const SubmitSearch('b')));
  });
}
