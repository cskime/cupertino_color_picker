import 'package:cupertino_color_picker/src/models/initial_data.dart';
import 'package:cupertino_color_picker/src/utils/color_hex_string_ext.dart';
import 'package:flutter/material.dart';
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
    final initialData = InitialData(
      initialColor: initialColor,
      supportsAlpha: supportsAlpha,
    );

    _addListener(onChanged);

    final String? hexColor = await _methodChannel.invokeMethod<String>(
      'showCupertinoColorPicker',
      initialData.toMap(),
    );

    return hexColor;
  }

  @override
  Widget createCupertinoColorPickerButton({
    String? initialColor,
    double size = 32,
    bool supportsAlpha = false,
    ValueChanged<Color>? onChanged,
  }) {
    final initialData = InitialData(
      initialColor: initialColor,
      supportsAlpha: supportsAlpha,
    );

    _addListener(onChanged);

    return SizedBox(
        width: size,
        height: size,
        child: UiKitView(
          viewType: 'UIColorWell',
          creationParams: initialData.toMap(),
          creationParamsCodec: const StandardMessageCodec(),
        ));
  }

  void _addListener(ValueChanged<Color>? onChanged) {
    _onChanged = onChanged;
    _methodChannel.setMethodCallHandler(_methodCallHandler);
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
