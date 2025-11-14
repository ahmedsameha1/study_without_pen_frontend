import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_field_list_state.freezed.dart';

@freezed
abstract class CreateFieldListState with _$CreateFieldListState{
  const factory CreateFieldListState()= _CreateFieldListState;
}