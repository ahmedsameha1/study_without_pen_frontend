import 'package:flutter/foundation.dart';

sealed class FieldsEvent {}

@immutable
class FieldsSubscriptionRequested extends FieldsEvent {
  FieldsSubscriptionRequested(this.userAccountId);
  final String userAccountId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is FieldsSubscriptionRequested &&
        runtimeType == other.runtimeType &&
        userAccountId == other.userAccountId;
  }

  @override
  int get hashCode => userAccountId.hashCode;
}

@immutable
class DeleteField extends FieldsEvent {
  DeleteField(this.fieldId);
  final String fieldId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is DeleteField &&
        runtimeType == other.runtimeType &&
        fieldId == other.fieldId;
  }

  @override
  int get hashCode => fieldId.hashCode;
}
