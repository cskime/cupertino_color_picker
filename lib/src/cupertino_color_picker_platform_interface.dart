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

  /// Shows the native iOS UIColorPickerViewController and returns the selected color as a hex string.
  ///
  /// This method presents a native iOS color picker that allows users to select colors
  /// using the system's built-in UI components. The color picker is presented modally
  /// on top of the current view controller.
  ///
  /// Parameters:
  /// - [initialColor] - Optional initial color to show in the picker as a hex string (format: '#RRGGBB' or '#AARRGGBB').
  ///   If not provided, the picker will default to black or the system's default color.
  /// - [supportsAlpha] - Whether the color picker should allow selecting colors with alpha (transparency) component.
  ///   When true, the returned color will include alpha information. Defaults to false.
  /// - [onChanged] - Optional callback that is invoked continuously as the user interacts with the color picker
  ///   and changes the color selection. This allows for real-time color updates in your UI before the
  ///   user confirms their final selection.
  ///
  /// Returns a Future that completes with a hex string of the selected color (format: '#RRGGBB' or '#AARRGGBB'
  /// depending on [supportsAlpha]) or null if the user cancels the picker by dismissing it without selecting a color.
  ///
  /// Note: This method only works on iOS 14.0+ where UIColorPickerViewController is available.
  /// On other platforms, it will throw a PlatformException.
  Future<String?> showCupertinoColorPicker({
    String? initialColor,
    bool supportsAlpha = false,
    ValueChanged<Color>? onChanged,
  }) {
    throw UnimplementedError(
      'showCupertinoColorPicker() has not been implemented.',
    );
  }

  Widget createCupertinoColorPickerButton({
    String? initialColor,
    double size = 32,
    bool supportsAlpha = false,
    ValueChanged<Color>? onChanged,
  });
}
