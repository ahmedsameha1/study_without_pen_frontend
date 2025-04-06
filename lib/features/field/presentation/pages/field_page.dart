import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/database/app_database.dart';
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
          showDialog<Field>(
            context: context,
            builder: (context) {
              Color defaultColor = Colors.red;
              return StatefulBuilder(builder: (ctx, ss) {
                return AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.createNewField,
                    textAlign: TextAlign.center,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ColorIndicator(
                        color: defaultColor,
                        onSelect: () async {
                          final Color newColor = await showColorPickerDialog(
                              context, defaultColor,
                              pickersEnabled: <ColorPickerType, bool>{
                                ColorPickerType.accent: false,
                                ColorPickerType.primary: false,
                                ColorPickerType.wheel: true,
                              });
                          ss(() {
                            defaultColor = newColor;
                          });
                        },
                      )
                    ],
                  ),
                );
              });
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
