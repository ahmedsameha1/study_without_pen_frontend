import 'package:flutter/foundation.dart';

import '../../domain/models/entries_page_data.dart';

@immutable
sealed class EntriesEvent {
  const EntriesEvent();
}

class PrepareScoreTab extends EntriesEvent {}

class PrepareStrugglingTab extends EntriesEvent {}

class EntriesSubscriptionRequested extends EntriesEvent {
  const EntriesSubscriptionRequested(this.fieldListId);
  final String fieldListId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is EntriesSubscriptionRequested &&
        runtimeType == other.runtimeType &&
        fieldListId == other.fieldListId;
  }

  @override
  int get hashCode => fieldListId.hashCode;
}

class PrepareTab extends EntriesEvent {
  const PrepareTab(this.tabIndex, this.now);
  final int tabIndex;
  final DateTime now;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareTab &&
        runtimeType == other.runtimeType &&
        tabIndex == other.tabIndex &&
        now == other.now;
  }

  @override
  int get hashCode => Object.hashAll([tabIndex, now]);
}

class NewData extends EntriesEvent {
  const NewData(this.data);
  final EntriesPageData data;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is NewData &&
        runtimeType == other.runtimeType &&
        data == other.data;
  }

  @override
  int get hashCode => data.hashCode;
}
