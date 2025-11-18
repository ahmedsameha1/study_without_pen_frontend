import 'package:flutter/material.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class CreateFieldListPage extends StatelessWidget {
  const CreateFieldListPage({required String fieldId, super.key});

  @override
  Widget build(BuildContext context) {
    return const CreateFieldListPageView();
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
