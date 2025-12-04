import 'package:flutter/material.dart';
import 'package:study_without_pen_by_flutter/common/widgets/pick_color.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class CreateFieldListPage extends StatelessWidget {
  const CreateFieldListPage({required String fieldId, super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateFieldListPageView();
    /*
    return BlocProvider<CreateFieldListBloc>(
        create: (context) =>
            CreateFieldListBloc(context.read<CreateFieldListUsecase>()),
        child: const CreateFieldListPageView());
        */
  }
}

class CreateFieldListPageView extends StatelessWidget {
  const CreateFieldListPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createFieldList),
      ),
      body: SafeArea(
          child: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              key: Key('paddingAroundColumn'),
              padding: EdgeInsets.all(16),
              child: Form(
                child: Column(
                  key: Key('column'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      key: Key('fieldListNameTextField'),
                      decoration: InputDecoration(
                          label: Text(
                              AppLocalizations.of(context)!.fieldListName)),
                      textInputAction: TextInputAction.next,
                      autofocus: true,
                    ),
                    SizedBox(
                      key: Key(
                          'sizedBoxBetweenTextFormFieldAndDropdownMenuFormField'),
                      height: 25,
                    ),
                    DropdownMenuFormField<CheckType>(
                        maxLines: 2,
                        initialSelection: CheckType.NON_STRICT_IGNORE_CASE,
                        label:
                            Text(AppLocalizations.of(context)!.selectCheckType),
                        helperText:
                            AppLocalizations.of(context)!.howAppCheckAnswers,
                        dropdownMenuEntries: [
                          DropdownMenuEntry<CheckType>(
                              value: CheckType.NON_STRICT_IGNORE_CASE,
                              label: AppLocalizations.of(context)!
                                  .nonStrictIgnoreCase),
                          DropdownMenuEntry<CheckType>(
                              value: CheckType.IGNORE_CASE,
                              label: AppLocalizations.of(context)!.ignoreCase),
                          DropdownMenuEntry<CheckType>(
                              value: CheckType.NON_STRICT_DO_NOT_IGNORE_CASE,
                              label: AppLocalizations.of(context)!
                                  .nonStrictDoNotIgnoreCase),
                          DropdownMenuEntry<CheckType>(
                              value: CheckType.DO_NOT_IGNORE_CASE,
                              label: AppLocalizations.of(context)!
                                  .doNotIgnoreCase),
                        ]),
                    SizedBox(
                      key: Key(
                          'sizedBoxBetweenDropdownMenuFormFieldAndCheckboxListTile'),
                      height: 25,
                    ),
                    CheckboxListTile(
                        value: false,
                        onChanged: (v) {},
                        title: Text(AppLocalizations.of(context)!.readAnswer),
                        subtitle: Text(AppLocalizations.of(context)!
                            .whenAnsweredCorrectly)),
                    SizedBox(
                      key: Key('sizedBoxBetweenCheckboxListTileAndPickColor'),
                      height: 25,
                    ),
                    PickColor(
                      callback: (_) {},
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }
}
