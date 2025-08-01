sealed class FieldListsEvent {
  const FieldListsEvent();
}

final class FieldListsSubscriptionRequested extends FieldListsEvent {
  const FieldListsSubscriptionRequested(this.fieldId);
  final String fieldId;
}