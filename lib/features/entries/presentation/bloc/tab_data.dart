import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/entry_entity.dart';

part 'tab_data.freezed.dart';

enum TabDataStatus { loading, ready }

@freezed
abstract class TabData with _$TabData {
  const factory TabData({
    required String name,
    required String description,
    @Default(TabDataStatus.loading) TabDataStatus status,
    @Default(true) bool outdated,
    @Default([]) List<EntryEntity> entries,
  }) = _TabData;
}
