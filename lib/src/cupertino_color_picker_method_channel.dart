import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'cupertino_color_picker_platform_interface.dart';

/// An implementation of [CupertinoColorPickerPlatform] that uses method channels.
class MethodChannelCupertinoColorPicker extends CupertinoColorPickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('cupertino_color_picker');

  @override
  Future<String?> showCupertinoColorPicker({
    String? initialColor,
    bool supportsAlpha = false,
  }) async {
    final arguments = {
      'initialColor': initialColor,
      'supportsAlpha': supportsAlpha,
    };

    final String? hexColor = await methodChannel.invokeMethod<String>(
      'showCupertinoColorPicker',
      arguments,
    );

    return hexColor;
  }
}
