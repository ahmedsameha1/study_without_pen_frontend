sealed class EntriesEvent {
  const EntriesEvent();
}

class EntriesSubscriptionRequested extends EntriesEvent {
  const EntriesSubscriptionRequested(this.fieldListId);
  final String fieldListId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is EntriesSubscriptionRequested &&
        runtimeType == other.runtimeType &&
        fieldListId == other.fieldListId;
  }

  @override
  int get hashCode => fieldListId.hashCode;
}
