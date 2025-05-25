import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/material.dart';

import 'cupertino_color_picker_platform_interface.dart';

/// Shows the native iOS color picker and returns the selected color.
///
/// This method only works on iOS. On other platforms, it will throw a [PlatformException].
///
/// Parameters:
/// - [initialColor] - Optional initial color to show in the picker.
/// - [supportsAlpha] - Whether the color picker should allow selecting colors with alpha component.
/// - [onChanged] - Optional callback that is invoked when the color changes continuously
///   during the color picking process.
///
/// Returns a Future that completes with the selected Color object
/// or null if the user cancels the picker.
///
/// Example:
/// ```dart
/// final color = await showCupertinoColorPicker(
///   initialColor: Colors.blue,
///   supportsAlpha: true,
///   onColorChanged: (color) {
///     // This is called continuously as the user changes the color
///     print('Color changing: $color');
///   },
/// );
///
/// if (color != null) {
///   // Use the final selected color in your UI
///   Container(color: color);
/// }
/// ```
Future<Color?> showCupertinoColorPicker({
  Color? initialColor,
  bool supportsAlpha = false,
  ValueChanged<Color>? onChanged,
}) async {
  String? initialColorString;

  if (initialColor != null) {
    initialColorString = initialColor.hexString;
  }

  final hexColorString = await CupertinoColorPickerPlatform.instance
      .showCupertinoColorPicker(
        initialColor: initialColorString,
        supportsAlpha: supportsAlpha,
        onChanged: onChanged,
      );

  return hexColorString?.color;
}
