import 'package:flutter/material.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cupertino_color_picker_method_channel.dart';

abstract class CupertinoColorPickerPlatform extends PlatformInterface {
  CupertinoColorPickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static CupertinoColorPickerPlatform _instance =
      MethodChannelCupertinoColorPicker();

  /// The default instance of [CupertinoColorPickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelCupertinoColorPicker].
  static CupertinoColorPickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CupertinoColorPickerPlatform] when
  /// they register themselves.
  static set instance(CupertinoColorPickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Shows the native iOS color picker and returns the selected color as a hex string.
  ///
  /// [initialColor] - Optional initial color to show in the picker (hex string like '#RRGGBB' or '#AARRGGBB')
  /// [supportsAlpha] - Whether the color picker should allow selecting colors with alpha component
  ///
  /// Returns a hex string of the selected color or null if user cancels
  Future<String?> showCupertinoColorPicker({
    String? initialColor,
    bool supportsAlpha = false,
    ValueChanged<Color>? onChanged,
  }) {
    throw UnimplementedError(
      'showCupertinoColorPicker() has not been implemented.',
    );
  }
}
