import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/services.dart';

import 'cupertino_color_picker_platform_interface.dart';

/// An implementation of [CupertinoColorPickerPlatform] that uses method channels.
class MethodChannelCupertinoColorPicker extends CupertinoColorPickerPlatform {
  final _methodChannel = const MethodChannel('cupertino_color_picker');

  ValueChanged<Color>? _onChanged;

  @override
  Future<String?> showCupertinoColorPicker({
    String? initialColor,
    bool supportsAlpha = false,
    ValueChanged<Color>? onChanged,
  }) async {
    final arguments = {
      'initialColor': initialColor,
      'supportsAlpha': supportsAlpha,
    };

    _onChanged = onChanged;
    _methodChannel.setMethodCallHandler(_methodCallHandler);

    final String? hexColor = await _methodChannel.invokeMethod<String>(
      'showCupertinoColorPicker',
      arguments,
    );

    return hexColor;
  }

  Future<dynamic> _methodCallHandler(MethodCall call) async {
    if (call.method == 'didSelectColor' && _onChanged != null) {
      final hexColorString = call.arguments as String;
      final color = hexColorString.color;

      if (color != null) {
        _onChanged?.call(color);
      }
    }
  }
}
