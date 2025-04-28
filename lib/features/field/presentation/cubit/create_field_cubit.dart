import 'package:flutter_bloc/flutter_bloc.dart';

enum CreateFieldState { initial }

class CreateFieldCubit extends Cubit<CreateFieldState> {
  CreateFieldCubit() : super(CreateFieldState.initial);
}
