import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/create_entry_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_state.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../../database/entrys_dao.dart';

class CreateEntryPage extends StatelessWidget {
  const CreateEntryPage({required this.fieldListId, super.key});
  final String fieldListId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateEntryBloc>(
      create: (context) =>
          CreateEntryBloc(context.read<CreateEntryUsecase>(), fieldListId)
            ..add(CreateEntrySubscriptionRequested(fieldListId)),
      child: CreateEntryPageView(fieldListId: fieldListId),
    );
  }
}

class CreateEntryPageView extends StatefulWidget {
  const CreateEntryPageView({required this.fieldListId, super.key});
  final String fieldListId;

  @override
  State<CreateEntryPageView> createState() => _CreateEntryPageViewState();
}

class _CreateEntryPageViewState extends State<CreateEntryPageView> {
  late final TextEditingController _questionTextEditingController;
  late final TextEditingController _answerTextEditingController;
  late final TextEditingController _orderTextEditingController;
  final GlobalKey<FormState> _questeionFormKey = GlobalKey();
  final GlobalKey<FormState> _answerFormKey = GlobalKey();
  final GlobalKey<FormState> _orderFormKey = GlobalKey();
  late Timer _timer;

  bool isValid = false;
  bool shouldUpdateIsValid = false;

  void updateIsValid() {
    if (shouldUpdateIsValid) {
      setState(() {
        isValid =
            validateQuestion(_questionTextEditingController.text) &&
            validateAnswer(_answerTextEditingController.text) &&
            validateOrder(_orderTextEditingController.text);
        shouldUpdateIsValid = false;
      });
    }
  }

  bool validateQuestion(String? value) {
    if (value == null) {
      return false;
    }
    final trimmedValueLength = value.trim().length;
    if (trimmedValueLength < Entrys.minimumTextLength ||
        //This is for completeness and is not tested because of maxLength
        trimmedValueLength > Entrys.maximumTextLength) {
      return false;
    }
    return true;
  }

  bool validateAnswer(String? value) {
    if (value == null) {
      return false;
    }
    final trimmedValueLength = value.trim().length;
    if (trimmedValueLength < Entrys.minimumTextLength ||
        //This is for completeness and is not tested because of maxLength
        trimmedValueLength > Entrys.maximumTextLength) {
      return false;
    }
    return true;
  }

  bool validateOrder(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      int? order = int.tryParse(value);
      if (order != null) {
        if (order < Entrys.ORDER_MINIMUM_VALUE ||
            order > Entrys.ORDER_MAXIMUM_VALUE) {
          return false;
        }
      } else {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _questionTextEditingController = TextEditingController();
    _answerTextEditingController = TextEditingController();
    _orderTextEditingController = TextEditingController();
    _timer = Timer.periodic(Durations.short2, (_) {
      updateIsValid();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _questionTextEditingController.dispose();
    _answerTextEditingController.dispose();
    _orderTextEditingController.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateEntryBloc, CreateEntryState>(
      listener: (context, state) {
        if (state.status == CreateEntryStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.created)),
          );
        } else if (state.status == CreateEntryStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.creationError),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        } else if (state.status == CreateEntryStatus.duplicationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.duplicatedEntry),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }

        _questionTextEditingController.text = state.question;
        _answerTextEditingController.text = state.answer;
        _orderTextEditingController.text = state.order;
      },
      child:
          context.select((CreateEntryBloc bloc) => bloc.state.status) ==
              CreateEntryStatus.loading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Column(
                  children: [
                    Text(
                      context.select(
                        (CreateEntryBloc bloc) => bloc.state.fieldList!.name,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.createEntry,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Scrollbar(
                  thumbVisibility: true,
                  thickness: 10,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            key: Key('question'),
                            height: 200,
                            child: Form(
                              key: _questeionFormKey,
                              child: TextFormField(
                                controller: _questionTextEditingController,
                                maxLength: Entrys.maximumTextLength,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                expands: true,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.multiline,
                                autocorrect: false,
                                enableSuggestions: false,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.question,
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                  filled: true,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (!validateQuestion(value)) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.questionValidationError(
                                      Entrys.minimumTextLength,
                                      Entrys.maximumTextLength,
                                    );
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _questeionFormKey.currentState != null &&
                                      _questeionFormKey.currentState!
                                          .validate();
                                  context.read<CreateEntryBloc>().add(
                                    CreateEntryQuestionChanged(value.trim()),
                                  );
                                  shouldUpdateIsValid = true;
                                },
                              ),
                            ),
                          ),
                          SizedBox(key: Key('question_answer'), height: 20),
                          SizedBox(
                            key: Key('answer'),
                            height: 200,
                            child: Form(
                              key: _answerFormKey,
                              child: TextFormField(
                                controller: _answerTextEditingController,
                                maxLength: Entrys.maximumTextLength,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced,
                                expands: true,
                                maxLines: null,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.multiline,
                                autocorrect: false,
                                enableSuggestions: false,
                                textInputAction: TextInputAction.newline,
                                decoration: InputDecoration(
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.answer,
                                  labelStyle: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                  filled: true,
                                  alignLabelWithHint: true,
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (!validateAnswer(value)) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.answerValidationError(
                                      Entrys.minimumTextLength,
                                      Entrys.maximumTextLength,
                                    );
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _answerFormKey.currentState != null &&
                                      _answerFormKey.currentState!.validate();
                                  context.read<CreateEntryBloc>().add(
                                    CreateEntryAnswerChanged(value.trim()),
                                  );
                                  shouldUpdateIsValid = true;
                                },
                              ),
                            ),
                          ),
                          SizedBox(key: Key('answer_rankorder'), height: 20),
                          Row(
                            key: Key('rank_order'),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                key: Key('rank'),
                                flex: 3,
                                child: Wrap(
                                  spacing: 10,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    ChoiceChip(
                                      label: Text(
                                        AppLocalizations.of(context)!.low,
                                      ),
                                      selected: context.select(
                                        (CreateEntryBloc bloc) =>
                                            bloc.state.rank == Rank.low,
                                      ),
                                      padding: EdgeInsets.all(0),
                                      onSelected: (value) =>
                                          context.read<CreateEntryBloc>().add(
                                            CreateEntryRankChanged(Rank.low),
                                          ),
                                    ),
                                    ChoiceChip(
                                      label: Text(
                                        AppLocalizations.of(context)!.normal,
                                      ),
                                      selected: context.select(
                                        (CreateEntryBloc bloc) =>
                                            bloc.state.rank == Rank.normal,
                                      ),
                                      padding: EdgeInsets.all(0),
                                      onSelected: (value) =>
                                          context.read<CreateEntryBloc>().add(
                                            CreateEntryRankChanged(Rank.normal),
                                          ),
                                    ),
                                    ChoiceChip(
                                      label: Text(
                                        AppLocalizations.of(context)!.important,
                                      ),
                                      selected: context.select(
                                        (CreateEntryBloc bloc) =>
                                            bloc.state.rank == Rank.important,
                                      ),
                                      padding: EdgeInsets.all(0),
                                      onSelected: (value) =>
                                          context.read<CreateEntryBloc>().add(
                                            CreateEntryRankChanged(
                                              Rank.important,
                                            ),
                                          ),
                                    ),
                                    ChoiceChip(
                                      label: Text(
                                        AppLocalizations.of(context)!.vital,
                                      ),
                                      selected: context.select(
                                        (CreateEntryBloc bloc) =>
                                            bloc.state.rank == Rank.vital,
                                      ),
                                      padding: EdgeInsets.all(0),
                                      onSelected: (value) =>
                                          context.read<CreateEntryBloc>().add(
                                            CreateEntryRankChanged(Rank.vital),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                key: Key('order'),
                                flex: 1,
                                child: Form(
                                  key: _orderFormKey,
                                  child: TextFormField(
                                    controller: _orderTextEditingController,
                                    maxLength:
                                        '${Entrys.ORDER_MAXIMUM_VALUE}'.length,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(
                                        context,
                                      )!.order,
                                      helperText: AppLocalizations.of(
                                        context,
                                      )!.optional,
                                      helperStyle: TextStyle(fontSize: 10),
                                      isDense: true,
                                      filled: true,
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (!validateOrder(value)) {
                                        return AppLocalizations.of(
                                          context,
                                        )!.orderValidationError(
                                          Entrys.ORDER_MINIMUM_VALUE,
                                          Entrys.ORDER_MAXIMUM_VALUE,
                                        );
                                      }
                                      return null;
                                    },
                                    onChanged: (value) {
                                      _orderFormKey.currentState != null &&
                                          _orderFormKey.currentState!
                                              .validate();
                                      context.read<CreateEntryBloc>().add(
                                        CreateEntryOrderChanged(value.trim()),
                                      );
                                      shouldUpdateIsValid = true;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(key: Key('rankorder_button'), height: 20),
                          Row(
                            key: Key('button'),
                            children: [
                              Expanded(
                                child: FilledButton.icon(
                                  key: Key('create'),
                                  icon: Icon(Icons.save),
                                  label: Text(
                                    AppLocalizations.of(context)!.create,
                                  ),
                                  onPressed: isValid
                                      ? () {
                                          context.read<CreateEntryBloc>().add(
                                            CreateEntrySubmitted(),
                                          );
                                          shouldUpdateIsValid = true;
                                        }
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
