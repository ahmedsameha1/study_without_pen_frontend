import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/router_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/watch_entries_usecase.dart';
import '../bloc/entries_bloc.dart';
import '../bloc/entries_event.dart';
import '../bloc/entries_state.dart';

/// This page displays the list of entries
class EntriesPage extends StatelessWidget {
  const EntriesPage({
    required this.fieldId,
    required this.fieldListId,
    super.key,
  });
  final String fieldId;
  final String fieldListId;

  @override
  Widget build(BuildContext context) => BlocProvider<EntriesBloc>(
    create: (context) =>
        EntriesBloc(context.read<WatchEntriesUsecase>())
          ..add(EntriesSubscriptionRequested(fieldListId)),
    child: EntriesPageView(fieldId: fieldId, fieldListId: fieldListId),
  );
}

class EntriesPageView extends StatelessWidget {
  const EntriesPageView({
    required this.fieldId,
    required this.fieldListId,
    super.key,
  });
  final String fieldId;
  final String fieldListId;

  @override
  Widget build(BuildContext context) => BlocBuilder<EntriesBloc, EntriesState>(
    builder: (context, state) {
      if (state.status == EntriesStatus.loading ||
          state.status == EntriesStatus.initial) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
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
                : DefaultTabController(
                    length: 5,
                    child: NestedScrollView(
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                context,
                              ),
                          sliver: SliverAppBar(
                            floating: true,
                            title: Text(state.entriesPageData!.fieldList.name),
                            actions: [
                              SearchAnchor(
                                builder: (context, controller) =>
                                    const IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.search),
                                    ),
                                suggestionsBuilder: (context, controller) => [],
                              ),
                            ],
                          ),
                        ),
                      ],
                      body: const Text('X'),
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => GoRouter.of(context).go(
              '$fieldListsPath$fieldId$entriesPath'
              '${state.entriesPageData!.fieldList.id!}$createEntry',
            ),
            child: const Icon(Icons.add),
          ),
        );
      }
    },
  );
}
