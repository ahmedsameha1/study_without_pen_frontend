import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/entries_page_data.dart';

import 'tab_data.dart';

part 'entries_state.freezed.dart';

enum EntriesStatus { initial, loading, success, failure, search }

const scoreTabName = 'score';
const scoreTabDescription = 'scoreDescription';
const strugglingTabName = 'struggling';
const strugglingTabDescription = 'strugglingDescription';
const todayTabName = 'today';
const todayTabDescription = 'todayDescription';
const unseenTabName = 'unseen';
const unseenTabDescription = 'unseenDescription';
const browseTabName = 'browse';
const browseTabDescription = 'browseDescription';
const searchTabName = 'search';
const searchTabDescription = 'searchDescription';

@freezed
abstract class EntriesState with _$EntriesState {
  const factory EntriesState({
    @Default(EntriesStatus.initial) EntriesStatus status,
    EntriesPageData? entriesPageData,
    @Default(0) int currentTabIndex,
    String? searchText,
    @Default([
      TabData(name: scoreTabName, description: scoreTabDescription),
      TabData(name: strugglingTabName, description: strugglingTabDescription),
      TabData(name: todayTabName, description: todayTabDescription),
      TabData(name: unseenTabName, description: unseenTabDescription),
      TabData(name: browseTabName, description: browseTabDescription),
      TabData(
        status: TabDataStatus.ready,
        name: searchTabName,
        description: searchTabDescription,
      ),
    ])
    List<TabData> tabs,
  }) = _EntriesState;
}
