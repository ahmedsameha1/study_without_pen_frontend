import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_state.dart';

class CreateFieldListBloc
    extends Bloc<CreateFieldListEvent, CreateFieldListState> {
  CreateFieldListBloc(this._createFieldListUsecase):super(CreateFieldListState());
  CreateFieldListUsecase _createFieldListUsecase;
}
