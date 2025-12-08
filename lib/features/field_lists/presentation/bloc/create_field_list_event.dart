import 'package:study_without_pen_by_flutter/database/app_database.dart';

sealed class CreateFieldListEvent {
  const CreateFieldListEvent();
}

class CreateFieldListNameChanged extends CreateFieldListEvent {
  const CreateFieldListNameChanged(this.name);
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldListNameChanged &&
        runtimeType == other.runtimeType &&
        name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}

class CreateFieldListCheckTypeChanged extends CreateFieldListEvent {
  const CreateFieldListCheckTypeChanged(this.checkType);
  final CheckType checkType;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldListCheckTypeChanged &&
        runtimeType == other.runtimeType &&
        checkType == other.checkType;
  }

  @override
  int get hashCode => checkType.hashCode;
}

class CreateFieldListReadAnswerChanged extends CreateFieldListEvent {
  const CreateFieldListReadAnswerChanged(this.readAnswer);
  final bool readAnswer;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldListReadAnswerChanged &&
        runtimeType == other.runtimeType &&
        readAnswer == other.readAnswer;
  }

  @override
  int get hashCode => readAnswer.hashCode;
}

class CreateFieldListColorChanged extends CreateFieldListEvent {
  const CreateFieldListColorChanged(this.color);
  final int color;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldListColorChanged &&
        runtimeType == other.runtimeType &&
        color == other.color;
  }

  @override
  int get hashCode => color.hashCode;
}

class CreateFieldListSubmitted extends CreateFieldListEvent {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldListSubmitted &&
        runtimeType == other.runtimeType;
  }
}
