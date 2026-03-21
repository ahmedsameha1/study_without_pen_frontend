import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/entry_entity.dart';

part 'tab_data.freezed.dart';

enum TabDataStatus { loading, ready, failure }

@freezed
abstract class TabData with _$TabData {
  const factory TabData({
    required String name,
    required String description,
    @Default(TabDataStatus.loading) TabDataStatus status,
    @Default([]) List<EntryEntity> entries,
  }) = _TabData;
}
