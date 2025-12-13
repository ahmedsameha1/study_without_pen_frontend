import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class FieldListsPage extends StatelessWidget {
  const FieldListsPage(this.fieldId, {super.key});
  final String fieldId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FieldListsBloc>(
      create: (context) =>
          FieldListsBloc(context.read<WatchFieldListsUsecase>())
            ..add(FieldListsSubscriptionRequested(fieldId)),
      child: const FieldListsPageView(),
    );
  }
}

class FieldListsPageView extends StatelessWidget {
  const FieldListsPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FieldListsBloc, FieldListsState>(
        builder: (context, state) {
      if (state.status == FieldListsStatus.loading ||
          state.status == FieldListsStatus.initial) {
        return Scaffold(body: const Center(child: CircularProgressIndicator()));
      } else if (state.status == FieldListsStatus.failure) {
        return Scaffold(
            body: Center(
                child: Text(AppLocalizations.of(context)!.failureLoadingData)),
            floatingActionButton: FloatingActionButton(
              onPressed: () => GoRouter.of(context).go(
                  '$fieldListsPath${state.fieldListsPageData!.field!.id!}$createFieldList'),
              child: Icon(Icons.add),
            ));
      } else {
        // FieldListsStatus.success
        String fieldName = state.fieldListsPageData!.field!.name;
        return Scaffold(
            appBar: AppBar(
              title: Text(fieldName),
            ),
            body: state.fieldListsPageData!.fieldLists.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.noFieldLists))
                : Scrollbar(
                    thumbVisibility: true,
                    trackVisibility: true,
                    interactive: true,
                    thickness: 10,
                    radius: const Radius.circular(8),
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.all(10),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      itemCount: state.fieldListsPageData!.fieldLists.length,
                      itemBuilder: (BuildContext context, int index) {
                        final fieldList =
                            state.fieldListsPageData!.fieldLists[index];
                        final color = Color(fieldList.color);
                        return Card(
                          color: color,
                          elevation: 2,
                          child: Padding(
                            key: Key("cardContentPadding"),
                            padding: EdgeInsetsGeometry.all(10.0),
                            child: Center(
                              child: Text(
                                fieldList.name,
                                style: TextStyle(
                                    color: color.computeLuminance() > 0.5
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => GoRouter.of(context).go(
                  '$fieldListsPath${state.fieldListsPageData!.field!.id!}$createFieldList'),
              child: Icon(Icons.add),
            ));
      }
    });
  }
}
