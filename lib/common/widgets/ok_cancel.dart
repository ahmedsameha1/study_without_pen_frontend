import 'package:flutter/material.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class OkCancel extends StatelessWidget {
  const OkCancel(
      {required this.valid,
      required this.usecaseValidationTest,
      required this.okCallback,
      required this.cancelCallback,
      super.key});
  final bool valid;
  final bool usecaseValidationTest;
  final VoidCallback okCallback;
  final VoidCallback cancelCallback;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            key: Key("cancelButton"),
            onPressed: cancelCallback,
            child: Text(AppLocalizations.of(context)!.cancel)),
        ElevatedButton(
            key: Key("okButton"),
            onPressed: valid || usecaseValidationTest ? okCallback : null,
            child: Text(AppLocalizations.of(context)!.ok)),
      ],
    );
  }
}
