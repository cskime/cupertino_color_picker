import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/material.dart';

class InitialData {
  final String? initialColor;
  final bool supportsAlpha;

  InitialData({
    this.initialColor,
    this.supportsAlpha = true,
  });

  InitialData.withColor({
    Color? initialColor,
    this.supportsAlpha = true,
  }) : initialColor = initialColor?.hexString;

  Map<String, dynamic> toMap() {
    return {
      'initialColor': initialColor,
      'supportsAlpha': supportsAlpha,
    };
  }
}
