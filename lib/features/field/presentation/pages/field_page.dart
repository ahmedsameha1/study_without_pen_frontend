import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/watch_fields_usecase.dart'
    as nonso;
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/fields_cubit.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/fields_state.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class FieldPage extends StatelessWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FieldsCubit>(
      create: (context) => FieldsCubit(context.read<nonso.WatchFieldsUsecase>())
        ..watch(
          context.read<nonso.AuthBloc>().state.user!.uid,
        ),
      child: const FieldPageView(),
    );
  }
}

class FieldPageView extends StatelessWidget {
  const FieldPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.materialAppTitle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.read<nonso.AuthBloc>().signOut();
              },
              icon: Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            GoRouter.of(context).go(createFieldPath);
          },
          child: Icon(Icons.add),
        ),
        body: BlocBuilder<FieldsCubit, FieldsState>(builder: (context, state) {
          if (state.fieldsStateStatus == FieldsStateStatus.loading) {
            return Center(child: const CircularProgressIndicator());
          } else if (state.fieldsStateStatus == FieldsStateStatus.failure) {
            return Center(
                child: Text(
              AppLocalizations.of(context)!.failureLoadingFields,
            ));
          } else {
            if (state.fields.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.noFields,
                ),
              );
            } else {
              return Scrollbar(
                thumbVisibility: true,
                trackVisibility: true,
                thickness: 10.0,
                radius: const Radius.circular(8.0),
                interactive: true,
                child: MasonryGridView.count(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: state.fields.length,
                  itemBuilder: (context, index) => Card(
                    child: Text(
                      state.fields[index].name,
                    ),
                  ),
                  crossAxisCount: 2,
                ),
              );
            }
          }
        }));
  }
}
