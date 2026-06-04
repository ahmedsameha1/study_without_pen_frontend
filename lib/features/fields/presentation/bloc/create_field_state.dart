import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_field_state.freezed.dart';

enum CreateFieldStatus {
  initial,
  loading,
  success,
  validationFailure,
  persistenceFailure,
}

@freezed
abstract class CreateFieldState with _$CreateFieldState {
  const factory CreateFieldState({
    @Default(CreateFieldStatus.initial) CreateFieldStatus status,
    required String userAccountId,
    @Default('') String name,
    @Default(4294967295) int color,
  }) = _CreateFieldState;
}
