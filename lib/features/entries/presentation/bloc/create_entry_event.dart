import '../../../../database/entrys_dao.dart';

sealed class CreateEntryEvent {
  const CreateEntryEvent();
}

class CreateEntryRankChanged extends CreateEntryEvent {
  const CreateEntryRankChanged(this.rank);
  final Rank rank;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateEntryRankChanged &&
        runtimeType == other.runtimeType &&
        rank == other.rank;
  }

  @override
  int get hashCode => rank.hashCode;
}

class CreateEntryQuestionChanged extends CreateEntryEvent {
  const CreateEntryQuestionChanged(this.question);
  final String question;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateEntryQuestionChanged &&
        runtimeType == other.runtimeType &&
        question == other.question;
  }

  @override
  int get hashCode => question.hashCode;
}

class CreateEntryAnswerChanged extends CreateEntryEvent {
  const CreateEntryAnswerChanged(this.answer);
  final String answer;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateEntryAnswerChanged &&
        runtimeType == other.runtimeType &&
        answer == other.answer;
  }

  @override
  int get hashCode => answer.hashCode;
}

class CreateEntryOrderChanged extends CreateEntryEvent {
  const CreateEntryOrderChanged(this.order);
  final String order;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateEntryOrderChanged &&
        runtimeType == other.runtimeType &&
        order == other.order;
  }

  @override
  int get hashCode => order.hashCode;
}

class CreateEntrySubmitted extends CreateEntryEvent {
  const CreateEntrySubmitted();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateEntrySubmitted && runtimeType == other.runtimeType;
  }
}

class CreateEntrySubscriptionRequested extends CreateEntryEvent {
  const CreateEntrySubscriptionRequested(this.fieldListId);
  final String fieldListId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateEntrySubscriptionRequested &&
        runtimeType == other.runtimeType &&
        fieldListId == other.fieldListId;
  }

  @override
  int get hashCode => fieldListId.hashCode;
}
