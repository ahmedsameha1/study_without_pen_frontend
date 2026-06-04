import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart' as nonso;

import '../../../../common/router_config.dart';
import '../../../../common/widgets/ok_cancel.dart';
import '../../../../common/widgets/pick_color.dart';
import '../../../../database/app_database.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/create_field_usecase.dart';
import '../bloc/create_field_bloc.dart';
import '../bloc/create_field_event.dart';
import '../bloc/create_field_state.dart';

class CreateFieldPage extends StatelessWidget {
  const CreateFieldPage({this.usecaseValidationTest = false, super.key});
  final bool usecaseValidationTest;

  @override
  Widget build(BuildContext context) => BlocProvider<CreateFieldBloc>(
    create: (ctx) => CreateFieldBloc(
      ctx.read<CreateFieldUsecase>(),
      context.read<nonso.AuthBloc>().state.user!.uid,
    ),
    child: CreateFieldPageView(usecaseValidationTest),
  );
}

class CreateFieldPageView extends StatefulWidget {
  const CreateFieldPageView(this.usecaseValidationTest, {super.key});
  final bool usecaseValidationTest;

  @override
  State<CreateFieldPageView> createState() => _CreateFieldPageViewState();
}

class _CreateFieldPageViewState extends State<CreateFieldPageView> {
  final GlobalKey<FormState> _nameFormKey = GlobalKey();
  bool isNameValid = false;

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<CreateFieldBloc, CreateFieldState>(
    listener: (context, state) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (state.status == CreateFieldStatus.validationFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.fieldNameValidationError(
                Fields.MINIMUM_LENGTH_OF_NAME,
                Fields.MAXIMUM_LENGTH_OF_NAME,
              ),
            ),
          ),
        );
      } else if (state.status == CreateFieldStatus.persistenceFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.creationError)),
        );
      } else if (state.status == CreateFieldStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.created)),
        );
        GoRouter.of(context).go(rootPath);
      }
    },
    builder: (context, state) => Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.createField)),
      body: SafeArea(
        child: Center(
          key: const Key('center'),
          child:
              state.status == CreateFieldStatus.loading ||
                  state.status == CreateFieldStatus.success
              ? const CircularProgressIndicator()
              : Card(
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      key: const Key('paddingAroundColumn'),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        key: const Key('column'),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: _nameFormKey,
                            child: TextFormField(
                              decoration: InputDecoration(
                                label: Text(
                                  AppLocalizations.of(context)!.fieldName,
                                ),
                              ),
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              autofocus: true,
                              validator: (value) {
                                if (value == null) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.fieldNameValidationError(
                                    Fields.MINIMUM_LENGTH_OF_NAME,
                                    Fields.MAXIMUM_LENGTH_OF_NAME,
                                  );
                                }
                                int trimmedValue = value.trim().length;
                                if (trimmedValue <
                                        Fields.MINIMUM_LENGTH_OF_NAME ||
                                    trimmedValue >
                                        Fields.MAXIMUM_LENGTH_OF_NAME) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.fieldNameValidationError(
                                    Fields.MINIMUM_LENGTH_OF_NAME,
                                    Fields.MAXIMUM_LENGTH_OF_NAME,
                                  );
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  isNameValid =
                                      _nameFormKey.currentState != null &&
                                      _nameFormKey.currentState!.validate();
                                });
                                context.read<CreateFieldBloc>().add(
                                  CreateFieldNameChanged(value),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            key: Key('sizedBoxBetweenFormAndStack'),
                            height: 25,
                          ),
                          PickColor(
                            color: Colors.white.toARGB32(),
                            callback: (Color newColor) {
                              context.read<CreateFieldBloc>().add(
                                CreateFieldColorChanged(newColor.toARGB32()),
                              );
                            },
                          ),
                          const SizedBox(
                            key: Key('sizedBoxBetweenStackAndButtons'),
                            height: 25,
                          ),
                          OkCancel(
                            valid: isNameValid,
                            usecaseValidationTest: widget.usecaseValidationTest,
                            okCallback: () async {
                              context.read<CreateFieldBloc>().add(
                                const CreateFieldSubmitted(),
                              );
                            },
                            cancelCallback: () {
                              GoRouter.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    ),
  );
}
