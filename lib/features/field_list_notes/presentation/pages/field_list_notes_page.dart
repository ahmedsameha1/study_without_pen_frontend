import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/watch_field_list_notes_usecase.dart';
import '../bloc/field_list_notes_bloc.dart';
import '../bloc/field_list_notes_event.dart';
import '../bloc/field_list_notes_state.dart';

class FieldListNotesPage extends StatelessWidget {
  const FieldListNotesPage({required this.fieldListId, super.key});
  final String fieldListId;

  @override
  Widget build(BuildContext context) => BlocProvider<FieldListNotesBloc>(
    create: (context) =>
        FieldListNotesBloc(context.read<WatchFieldListNotesUsecase>())
          ..add(FieldListNotesSubscriptionRequested(fieldListId)),
    child: const FieldListNotesPageView(),
  );
}

class FieldListNotesPageView extends StatelessWidget {
  const FieldListNotesPageView({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<FieldListNotesBloc, FieldListNotesState>(
        builder: (context, state) => const Placeholder(),
      );
}
