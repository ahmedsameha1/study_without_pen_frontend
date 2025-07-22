import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/cubit/field_lists_cubit.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/cubit/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';

class FieldListsPage extends StatelessWidget {
  const FieldListsPage(this.fieldId, {super.key});
  final String fieldId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FieldListsCubit>(
      create: (context) =>
          FieldListsCubit(context.read<WatchFieldUsecase>())..watch(fieldId),
      child: const _FieldListsPageView(),
    );
  }
}

class _FieldListsPageView extends StatelessWidget {
  const _FieldListsPageView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldListsCubit, FieldListsState>(
        builder: (context, state) {
      if (state.stateStatus == StateStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      } else {
        String fieldName = state.fieldName;
        return Scaffold(
          appBar: AppBar(
            title: Text(fieldName),
          ),
        );
      }
    });
  }
}
