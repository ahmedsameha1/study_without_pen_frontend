sealed class StudyTestEvent {}

class ChangeEntry extends StudyTestEvent {
  ChangeEntry(this.index);
  int index;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ChangeEntry &&
        runtimeType == other.runtimeType &&
        index == other.index;
  }

  @override
  int get hashCode => index.hashCode;
}

class ChangeTab extends StudyTestEvent {
  ChangeTab(this.tab);
  int tab;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ChangeTab &&
        runtimeType == other.runtimeType &&
        tab == other.tab;
  }

  @override
  int get hashCode => tab.hashCode;
}
