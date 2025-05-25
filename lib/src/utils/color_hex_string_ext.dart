import 'package:flutter/animation.dart';

extension ColorToHexStringExt on Color {
  String? get hexString {
    return '#${toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}

extension HexStringToColorExt on String {
  Color? get color {
    var hexString = this;

    if (hexString.isEmpty) return null;

    hexString = hexString.toUpperCase().replaceAll("#", "");

    if (hexString.length == 6) {
      // Add full opacity if no alpha value
      hexString = "FF$hexString";
    }

    final int? colorValue = int.tryParse(hexString, radix: 16);
    return colorValue != null ? Color(colorValue) : null;
  }
}
