sealed class FieldListNotesEvent {
  const FieldListNotesEvent();
}

class FieldListNotesSubscriptionRequested extends FieldListNotesEvent {
  FieldListNotesSubscriptionRequested(this.fieldListId);
  String fieldListId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FieldListNotesSubscriptionRequested &&
        runtimeType == other.runtimeType &&
        fieldListId == other.fieldListId;
  }

  @override
  int get hashCode => fieldListId.hashCode;
}
