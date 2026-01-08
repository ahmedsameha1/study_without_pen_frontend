import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/watch_entries_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_state.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class EntriesPage extends StatelessWidget {
  const EntriesPage(this.fieldListId, {super.key});
  final String fieldListId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EntriesBloc>(
      create: (context) =>
          EntriesBloc(context.read<WatchEntriesUsecase>())
            ..add(EntriesSubscriptionRequested(fieldListId)),
      child: const EntriesPageView(),
    );
  }
}

class EntriesPageView extends StatelessWidget {
  const EntriesPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntriesBloc, EntriesState>(
      builder: (context, state) {
        if (state.status == EntriesStatus.loading ||
            state.status == EntriesStatus.initial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state.status == EntriesStatus.failure) {
          return Scaffold(
            body: Center(
              child: Text(AppLocalizations.of(context)!.failureLoadingEntries),
            ),
          );
        } else {
          // EntriesStatus.success
          return Scaffold(
            appBar: AppBar(title: Text(state.entriesPageData!.fieldList.name)),
            body: Center(
              child: state.entriesPageData!.entries.isEmpty
                  ? Text(AppLocalizations.of(context)!.noEntries)
                  : Placeholder(),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: null,
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }
}
