import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

class PickColor extends StatefulWidget {
  const PickColor({required this.callback, super.key});
  final void Function(Color color) callback;

  @override
  State<PickColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  late Color color;
  late bool showColorPicker;
  @override
  void initState() {
    super.initState();
    color = Colors.white;
    showColorPicker = false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        key: Key("gestureDetector"),
        child: Stack(
          key: Key("stackForColorIndicator"),
          alignment: Alignment.center,
          children: [
            ColorIndicator(
              key: Key("colorIndicator"),
              width: double.infinity,
              color: color,
            ),
            Text(
              AppLocalizations.of(context)!.selectColor,
              style: TextStyle(
                  color: color.computeLuminance() > 0.5
                      ? Colors.black
                      : Colors.white),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            showColorPicker = !showColorPicker;
          });
        },
      ),
      AnimatedSize(
        duration: const Duration(milliseconds: 500),
        child: showColorPicker
            ? ColorPicker(
                color: color,
                pickersEnabled: <ColorPickerType, bool>{
                  ColorPickerType.accent: false,
                  ColorPickerType.primary: false,
                  ColorPickerType.wheel: true,
                },
                heading: Text(AppLocalizations.of(context)!.selectColor,
                    style: Theme.of(context).textTheme.headlineSmall),
                onColorChanged: (value) {
                  setState(() {
                    color = value;
                  });
                  widget.callback(value);
                },
              )
            : SizedBox.shrink(
                key: const Key('shrinkedSizedBox'),
              ),
      ),
    ]);
  }
}
