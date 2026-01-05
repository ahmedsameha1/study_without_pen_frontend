import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/common/widgets/ok_cancel.dart';
import 'package:study_without_pen_by_flutter/common/widgets/pick_color.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_state.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class CreateFieldListPage extends StatelessWidget {
  const CreateFieldListPage({required this.fieldId, super.key});
  final String fieldId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateFieldListBloc>(
      create: (context) =>
          CreateFieldListBloc(context.read<CreateFieldListUsecase>(), fieldId),
      child: const CreateFieldListPageView(),
    );
  }
}

class CreateFieldListPageView extends StatefulWidget {
  const CreateFieldListPageView({super.key});

  @override
  State<CreateFieldListPageView> createState() =>
      _CreateFieldListPageViewState();
}

class _CreateFieldListPageViewState extends State<CreateFieldListPageView> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isNameValid = false;
  @override
  Widget build(BuildContext context) {
    String fieldId = context.select(
      (CreateFieldListBloc bloc) => bloc.state.fieldId,
    );
    return BlocListener<CreateFieldListBloc, CreateFieldListState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == CreateFieldListStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.created)),
          );
          GoRouter.of(context).go('$fieldListsPath$fieldId');
        } else if (state.status == CreateFieldListStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.creationError),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.createFieldList),
        ),
        body: SafeArea(
          child: Center(
            child:
                context.select(
                      (CreateFieldListBloc bloc) => bloc.state.status,
                    ) ==
                    CreateFieldListStatus.loading
                ? CircularProgressIndicator()
                : Card(
                    margin: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        key: Key('paddingAroundColumn'),
                        padding: EdgeInsets.all(16),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            key: Key('column'),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                initialValue: context.select(
                                  (CreateFieldListBloc bloc) => bloc.state.name,
                                ),
                                key: Key('fieldListNameTextField'),
                                decoration: InputDecoration(
                                  label: Text(
                                    AppLocalizations.of(context)!.fieldListName,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                                autofocus: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.fieldListNameValidationError(
                                      FieldLists.MINIMUM_LENGTH_OF_NAME,
                                      FieldLists.MAXIMUM_LENGTH_OF_NAME,
                                    );
                                  }
                                  final trimmedValueLength = value
                                      .trim()
                                      .length;
                                  if (trimmedValueLength >
                                          FieldLists.MAXIMUM_LENGTH_OF_NAME ||
                                      trimmedValueLength <
                                          FieldLists.MINIMUM_LENGTH_OF_NAME) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.fieldListNameValidationError(
                                      FieldLists.MINIMUM_LENGTH_OF_NAME,
                                      FieldLists.MAXIMUM_LENGTH_OF_NAME,
                                    );
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    isNameValid =
                                        _formKey.currentState != null &&
                                        _formKey.currentState!.validate();
                                  });
                                  if (isNameValid) {
                                    context.read<CreateFieldListBloc>().add(
                                      CreateFieldListNameChanged(value),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                key: Key(
                                  'sizedBoxBetweenTextFormFieldAndDropdownMenuFormField',
                                ),
                                height: 25,
                              ),
                              DropdownMenuFormField<CheckType>(
                                maxLines: 2,
                                initialSelection: context.select(
                                  (CreateFieldListBloc bloc) =>
                                      bloc.state.checkType,
                                ),
                                label: Text(
                                  AppLocalizations.of(context)!.selectCheckType,
                                ),
                                helperText: AppLocalizations.of(
                                  context,
                                )!.howAppCheckAnswers,
                                dropdownMenuEntries: [
                                  DropdownMenuEntry<CheckType>(
                                    value: CheckType.NON_STRICT_IGNORE_CASE,
                                    label: AppLocalizations.of(
                                      context,
                                    )!.nonStrictIgnoreCase,
                                  ),
                                  DropdownMenuEntry<CheckType>(
                                    value: CheckType.IGNORE_CASE,
                                    label: AppLocalizations.of(
                                      context,
                                    )!.ignoreCase,
                                  ),
                                  DropdownMenuEntry<CheckType>(
                                    value:
                                        CheckType.NON_STRICT_DO_NOT_IGNORE_CASE,
                                    label: AppLocalizations.of(
                                      context,
                                    )!.nonStrictDoNotIgnoreCase,
                                  ),
                                  DropdownMenuEntry<CheckType>(
                                    value: CheckType.DO_NOT_IGNORE_CASE,
                                    label: AppLocalizations.of(
                                      context,
                                    )!.doNotIgnoreCase,
                                  ),
                                ],
                                onSelected: (newValue) {
                                  if (newValue != null) {
                                    context.read<CreateFieldListBloc>().add(
                                      CreateFieldListCheckTypeChanged(newValue),
                                    );
                                  }
                                },
                              ),
                              SizedBox(
                                key: Key(
                                  'sizedBoxBetweenDropdownMenuFormFieldAndCheckboxListTile',
                                ),
                                height: 25,
                              ),
                              CheckboxListTile(
                                value: context.select(
                                  (CreateFieldListBloc bloc) =>
                                      bloc.state.readAnswer,
                                ),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    context.read<CreateFieldListBloc>().add(
                                      CreateFieldListReadAnswerChanged(
                                        //TODO trim the value
                                        newValue,
                                      ),
                                    );
                                  }
                                },
                                title: Text(
                                  AppLocalizations.of(context)!.readAnswer,
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.whenAnsweredCorrectly,
                                ),
                              ),
                              SizedBox(
                                key: Key(
                                  'sizedBoxBetweenCheckboxListTileAndPickColor',
                                ),
                                height: 25,
                              ),
                              PickColor(
                                color: context.select(
                                  (CreateFieldListBloc bloc) =>
                                      bloc.state.color,
                                ),
                                callback: (newValue) {
                                  context.read<CreateFieldListBloc>().add(
                                    CreateFieldListColorChanged(
                                      newValue.toARGB32(),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                key: Key(
                                  'sizedBoxBetweenCheckboxListTileAndOkCancel',
                                ),
                                height: 25,
                              ),
                              OkCancel(
                                valid: isNameValid,
                                usecaseValidationTest: false,
                                okCallback: () {
                                  context.read<CreateFieldListBloc>().add(
                                    const CreateFieldListSubmitted(),
                                  );
                                },
                                cancelCallback: () {
                                  GoRouter.of(
                                    context,
                                  ).go('$fieldListsPath$fieldId');
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
      ),
    );
  }
}
