import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/entries_page_data.dart';

import '../../domain/models/entry_entity.dart';
import 'tab_data.dart';

part 'entries_state.freezed.dart';

enum EntriesStatus { initial, loading, success, failure }

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

@freezed
abstract class EntriesState with _$EntriesState {
  const factory EntriesState({
    @Default(EntriesStatus.initial) EntriesStatus status,
    EntriesPageData? entriesPageData,
    @Default(0) int currentTabIndex,
    @Default([
      TabData(
        status: TabDataStatus.loading,
        outdated: true,
        name: scoreTabName,
        description: scoreTabDescription,
        entries: <EntryEntity>[],
      ),
      TabData(
        status: TabDataStatus.loading,
        outdated: true,
        name: strugglingTabName,
        description: strugglingTabDescription,
        entries: <EntryEntity>[],
      ),
      TabData(
        status: TabDataStatus.loading,
        outdated: true,
        name: todayTabName,
        description: todayTabDescription,
        entries: <EntryEntity>[],
      ),
      TabData(
        status: TabDataStatus.loading,
        outdated: true,
        name: unseenTabName,
        description: unseenTabDescription,
        entries: <EntryEntity>[],
      ),
      TabData(
        status: TabDataStatus.loading,
        outdated: true,
        name: browseTabName,
        description: browseTabDescription,
        entries: <EntryEntity>[],
      ),
    ])
    List<TabData> tabs,
  }) = _EntriesState;
}
