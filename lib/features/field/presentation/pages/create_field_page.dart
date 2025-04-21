import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class CreateFieldPage extends HookWidget {
  CreateFieldPage({super.key});
  final GlobalKey<FormState> _nameFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final color = useState<Color>(Colors.white);
    final showColorPicker = useState<bool>(false);
    final isNameValid = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(
            title: Text(
          AppLocalizations.of(context)!.createField,
        )),
        body: Center(
            key: Key("center"),
            child: Card(
              margin: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Padding(
                  key: const Key("paddingAroundColumn"),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    key: Key("column"),
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                        key: _nameFormKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                              label: Text(
                                  AppLocalizations.of(context)!.fieldName)),
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null) {
                              return AppLocalizations.of(context)!
                                  .fieldNameValidationError(
                                      Fields.MINIMUM_LENGTH_OF_NAME,
                                      Fields.MAXIMUM_LENGTH_OF_NAME);
                            }
                            int trimmedValue = value.trim().length;
                            if (trimmedValue < Fields.MINIMUM_LENGTH_OF_NAME ||
                                trimmedValue > Fields.MAXIMUM_LENGTH_OF_NAME) {
                              return AppLocalizations.of(context)!
                                  .fieldNameValidationError(
                                      Fields.MINIMUM_LENGTH_OF_NAME,
                                      Fields.MAXIMUM_LENGTH_OF_NAME);
                            }
                            return null;
                          },
                        ),
                        onChanged: () => isNameValid.value =
                            _nameFormKey.currentState != null &&
                                _nameFormKey.currentState!.validate(),
                      ),
                      SizedBox(
                        key: Key("sizedBoxBetweenFormAndStack"),
                        height: 25,
                      ),
                      GestureDetector(
                        key: Key("gestureDetector"),
                        child: Stack(
                          key: Key("stackForColorIndicator"),
                          alignment: Alignment.center,
                          children: [
                            ColorIndicator(
                              key: Key("colorIndicator"),
                              width: double.infinity,
                              color: color.value,
                            ),
                            Text(
                              AppLocalizations.of(context)!.selectColor,
                              style: TextStyle(
                                  color: color.value.computeLuminance() > 0.5
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          ],
                        ),
                        onTap: () {
                          showColorPicker.value = !showColorPicker.value;
                        },
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: showColorPicker.value
                            ? ColorPicker(
                                color: color.value,
                                pickersEnabled: <ColorPickerType, bool>{
                                  ColorPickerType.accent: false,
                                  ColorPickerType.primary: false,
                                  ColorPickerType.wheel: true,
                                },
                                heading: Text(
                                    AppLocalizations.of(context)!.selectColor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall),
                                onColorChanged: (value) {
                                  color.value = value;
                                },
                              )
                            : SizedBox.shrink(),
                      ),
                      SizedBox(
                        key: Key("sizedBoxBetweenStackAndButtons"),
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              key: Key("cancelButton"),
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child:
                                  Text(AppLocalizations.of(context)!.cancel)),
                          ElevatedButton(
                              key: Key("okButton"),
                              onPressed: isNameValid.value ? () {} : null,
                              child: Text(AppLocalizations.of(context)!.ok)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
