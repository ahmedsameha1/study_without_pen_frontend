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
