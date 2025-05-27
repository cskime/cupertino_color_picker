import 'package:cupertino_color_picker/src/cupertino_color_picker_platform_interface.dart';
import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/material.dart';

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
