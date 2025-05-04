class CreateFieldUseCase {
  void call(
      String fieldId,
      String userAccountId,
      String name,
      DateTime creationAt,
      DateTime lastModificationAt,
      int usageCount,
      int color) {
    throw ArgumentError('Field name cannot be blank');
  }
}
