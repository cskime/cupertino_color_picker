## 0.1.0 - May 25, 2025

### Initial Release

- Implemented iOS native `UIColorPickerViewController` integration with Flutter.
- Added support for real-time color change events with the `onChanged` callback.
- Provided color format conversion between iOS UIColor and Flutter Color objects.
- Added support for Display P3 color space with automatic conversion to sRGB for Flutter compatibility.
- Implemented alpha (transparency) channel support with the `supportsAlpha` parameter.
- Created comprehensive documentation and example app.

### Features

- Show the native iOS color picker from Flutter apps.
- Set an initial color value.
- Get real-time updates as the user changes colors.
- Support for both RGB and RGBA color formats.
- Proper color space handling for accurate color representation.
- Fully type-safe API with null safety support.

### Requirements

- iOS 14.0 or higher (UIColorPickerViewController availability).
- Flutter 3.3.0 or higher.
- Dart SDK 3.8.0 or higher.