# Cupertino Color Picker

A Flutter plugin that provides access to the native iOS UIColorPickerViewController in Flutter apps.

## Introduction

This plugin allows Flutter apps to use the native `UIColorPickerViewController` available in iOS 14.0 and above.

**Note**: This plugin only works on iOS. Using it on Android or other platforms will result in a PlatformException.

## Usage

### Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  cupertino_color_picker: ^0.0.1
```

### Basic Usage

```dart
import 'package:cupertino_color_picker/cupertino_color_picker.dart';
import 'package:flutter/material.dart';

Future<void> showColorPickerExample() async {
  try {
    // Show the color picker (similar to other Flutter show* functions)
    final color = await showCupertinoColorPicker(
      initialColor: Colors.blue, // Pass a Color object
      supportsAlpha: true, // Whether to support transparency
      onChanged: (color) {
        // This is called continuously as the user changes the color
        print('Color changing: $color');
      },
    );
    
    // Returns null if user cancels
    if (color != null) {
      // Use the Color object directly
      print('Selected color: ${color.toString()}');
      
      // Apply to UI
      Container(color: color);
    }
  } catch (e) {
    print('Color picker error: $e');
  }
}
```

## License

This plugin is licensed under the MIT License - see the LICENSE file for details.

