import 'package:flutter/material.dart';

import 'cupertino_color_picker_platform_interface.dart';

/// Type definition for color change callback.
/// Called when the color changes during the color picking process.
typedef OnColorChanged = void Function(Color color);

/// Shows the native iOS color picker and returns the selected color.
///
/// This method only works on iOS. On other platforms, it will throw a [PlatformException].
///
/// Parameters:
/// - [initialColor] - Optional initial color to show in the picker.
/// - [supportsAlpha] - Whether the color picker should allow selecting colors with alpha component.
/// - [onColorChanged] - Optional callback that is invoked when the color changes continuously
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
  ValueChanged<Color>? onColorChanged,
}) async {
  String? initialColorString;

  if (initialColor != null) {
    // Convert Color to hex string using toARGB32 instead of deprecated .value
    initialColorString =
        '#${initialColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  final hexColor = await CupertinoColorPickerPlatform.instance
      .showCupertinoColorPicker(
        initialColor: initialColorString,
        supportsAlpha: supportsAlpha,
      );

  // Convert the hex string to a Color object using the internal helper function
  return hexColor != null ? _hexToColor(hexColor) : null;
}

// Internal helper function to convert a hex string to a Color object
// This function is not exposed outside this file
Color? _hexToColor(String? hexString) {
  if (hexString == null || hexString.isEmpty) return null;

  hexString = hexString.toUpperCase().replaceAll("#", "");

  if (hexString.length == 6) {
    // Add full opacity if no alpha value
    hexString = "FF$hexString";
  }

  final int? colorValue = int.tryParse(hexString, radix: 16);
  return colorValue != null ? Color(colorValue) : null;
}
