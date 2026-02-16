import 'package:flutter/foundation.dart';

@immutable
sealed class EntriesEvent {
  const EntriesEvent();
}

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
  const PrepareTab(this.tabIndex);
  final int tabIndex;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareTab &&
        runtimeType == other.runtimeType &&
        tabIndex == other.tabIndex;
  }

  @override
  int get hashCode => tabIndex.hashCode;
}
