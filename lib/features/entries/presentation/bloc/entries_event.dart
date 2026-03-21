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

class PrepareScoreTab extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareScoreTab;
  }
}

class PrepareStrugglingTab extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareStrugglingTab;
  }
}

class PrepareTodayTab extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareTodayTab;
  }
}

class PrepareUnseenTab extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareUnseenTab;
  }
}

class PrepareBrowseTab extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is PrepareBrowseTab;
  }
}

class SwitchToSearchTab extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is SwitchToSearchTab;
  }
}

class SearchInputChanged extends EntriesEvent {
  const SearchInputChanged(this.searchText);
  final String searchText;
}

class SubmitSearch extends EntriesEvent {
  const SubmitSearch(this.searchText);
  final String searchText;
}

class OpenSearch extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is OpenSearch;
  }
}

class CloseSearch extends EntriesEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is CloseSearch;
  }
}
