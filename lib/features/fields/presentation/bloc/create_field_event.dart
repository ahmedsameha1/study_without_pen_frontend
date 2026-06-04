sealed class CreateFieldEvent {
  const CreateFieldEvent();
}

class CreateFieldNameChanged extends CreateFieldEvent {
  const CreateFieldNameChanged(this.name);
  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldNameChanged &&
        runtimeType == other.runtimeType &&
        name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}

class CreateFieldColorChanged extends CreateFieldEvent {
  const CreateFieldColorChanged(this.color);
  final int color;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldColorChanged &&
        runtimeType == other.runtimeType &&
        color == other.color;
  }

  @override
  int get hashCode => color.hashCode;
}

class CreateFieldSubmitted extends CreateFieldEvent {
  const CreateFieldSubmitted();
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CreateFieldSubmitted && runtimeType == other.runtimeType;
  }
}
