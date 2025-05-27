import 'package:cupertino_color_picker/src/cupertino_color_picker_platform_interface.dart';
import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/material.dart';

/// A button widget that displays the native iOS UIColorWell component as a platform view.
///
/// This widget provides a color picker button using the native iOS UIColorWell control,
/// which allows users to select colors in a familiar iOS way.
///
/// Parameters:
/// - [size] - The size of the color button. Defaults to 32.
/// - [initialColor] - Specifies the initial color to show in the button. If not provided,
///   the system's default color is used.
/// - [supportsAlpha] - Whether the color picker should allow selecting colors with alpha
///   (transparency) component. Defaults to true.
/// - [onChanged] - Optional callback that is invoked each time the user changes the color
///   during the color picking process. This callback is continuously called before the user
///   finalizes their color selection, allowing real-time UI updates based on the current color.
///
/// Notes:
/// - This widget only works on iOS 14.0+ where UIColorWell is available.
/// - On non-iOS platforms, using this widget will result in a PlatformException.
///
/// Example:
/// ```dart
/// CupertinoColorPickerButton(
///   size: 40,
///   initialColor: Colors.blue,
///   supportsAlpha: true,
///   onChanged: (color) {
///     setState(() {
///       _selectedColor = color;
///     });
///   },
/// )
/// ```
class CupertinoColorPickerButton extends StatelessWidget {
  final double size;
  final Color? initialColor;
  final bool supportsAlpha;
  final ValueChanged<Color>? onChanged;

  const CupertinoColorPickerButton(
      {super.key,
      this.size = 32,
      this.initialColor,
      this.supportsAlpha = true,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    final platform = CupertinoColorPickerPlatform.instance;
    return platform.createCupertinoColorPickerButton(
        size: size,
        initialColor: initialColor?.hexString,
        supportsAlpha: supportsAlpha,
        onChanged: onChanged);
  }
}
