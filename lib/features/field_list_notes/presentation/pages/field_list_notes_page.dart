import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
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
  Widget build(
    BuildContext context,
  ) => BlocBuilder<FieldListNotesBloc, FieldListNotesState>(
    builder: (context, state) => Scaffold(
      appBar: state.status == FieldListNotesStatus.success
          ? AppBar(
              centerTitle: true,
              title: Column(
                children: [
                  Tooltip(
                    message: state.fieldListNotesPageData!.fieldList.name,
                    child: Text(state.fieldListNotesPageData!.fieldList.name),
                  ),
                  Text(
                    AppLocalizations.of(context)!.notes,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ],
              ),
            )
          : null,
      body: switch (state.status) {
        FieldListNotesStatus.success => Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          interactive: true,
          thickness: 10,
          radius: const Radius.circular(8),
          child: Padding(
            padding: const EdgeInsetsGeometry.all(10),
            child: ListView.builder(
              itemCount: state.fieldListNotesPageData!.fieldListNotes.length,
              itemBuilder: (context, index) => Column(
                children: [
                  Text(
                    state.fieldListNotesPageData!.fieldListNotes[index].text,
                  ),
                  const Divider(),
                ],
              ),
            ),
          ),
        ),
        FieldListNotesStatus.failure => Center(
          child: Text(AppLocalizations.of(context)!.failureLoadingNotes),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    ),
  );
}
