import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class FieldPage extends StatelessWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.materialAppTitle,
        ),
        actions: [
          BlocBuilder<nonso.AuthBloc, nonso.AuthState>(
            key: const Key("authBlocBuilder"),
            builder: (context, state) => IconButton(
                onPressed: () {
                  context.read<nonso.AuthBloc>().signOut();
                },
                icon: Icon(
                  Icons.logout,
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go(createFieldPath);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
