import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/material.dart';

import 'cupertino_color_picker_platform_interface.dart';

/// Shows the native iOS UIColorPickerViewController and returns the selected color.
///
/// This method provides a color picker functionality using the native iOS UIColorPickerViewController.
/// It allows real-time color change events as the user selects or modifies colors.
///
/// Parameters:
/// - [initialColor] - Specifies the initial color to show in the picker. If not provided,
///   the system's default color (usually black) is used.
/// - [supportsAlpha] - Whether the color picker should allow selecting colors with alpha
///   (transparency) component. Defaults to true.
/// - [onChanged] - Optional callback that is invoked each time the user changes the color
///   during the color picking process. This callback is continuously called before the user
///   finalizes their color selection, allowing real-time UI updates based on the current color.
///
/// Returns:
/// - A Future that completes with the final selected [Color] object, or null if the user
///   cancels the color selection.
///
/// Notes:
/// - This method only works on iOS 14.0+ where UIColorPickerViewController is available.
/// - On non-iOS platforms, calling this method will throw a PlatformException.
///
/// Example:
/// ```dart
/// final color = await showCupertinoColorPicker(
///   initialColor: Colors.blue,
///   supportsAlpha: true,
///   onChanged: (color) {
///     // This is called continuously as the user changes the color
///     setState(() {
///       _currentColor = color;
///     });
///   },
/// );
///
/// if (color != null) {
///   // Use the final selected color
///   setState(() {
///     _selectedColor = color;
///   });
/// }
/// ```
Future<Color?> showCupertinoColorPicker({
  Color? initialColor,
  bool supportsAlpha = true,
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
