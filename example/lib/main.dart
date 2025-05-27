import 'dart:async';

import 'package:cupertino_color_picker/cupertino_color_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CupertinoColorPickerExampleApp());
}

class CupertinoColorPickerExampleApp extends StatefulWidget {
  const CupertinoColorPickerExampleApp({super.key});

  @override
  State<CupertinoColorPickerExampleApp> createState() =>
      _CupertinoColorPickerExampleAppState();
}

class _CupertinoColorPickerExampleAppState
    extends State<CupertinoColorPickerExampleApp> {
  Color? _selectedColor;
  String? _selectedColorHex;
  bool _supportsAlpha = true;

  void _onSupportsAlphaChanged(bool value) {
    setState(() {
      _supportsAlpha = value;
    });
  }

  Future<void> _showColorPicker() async {
    final color = await showCupertinoColorPicker(
      initialColor: _selectedColor,
      supportsAlpha: _supportsAlpha,
      onChanged: _onColorChanged,
    );

    if (color != null) {
      _updateColor(color);
    }
  }

  void _onColorChanged(Color color) {
    _updateColor(color);
  }

  void _updateColor(Color color) {
    setState(() {
      _selectedColor = color;
      _selectedColorHex =
          '#${color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _selectedColor,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade700, width: 2),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Cupertino Color Picker Example',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 24),
                if (_hexColorText != null) _hexColorText!,
                _supportsAlphaSwitch,
                _cupertinoColorPickerButton,
                _showColorPickerButton,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget? get _hexColorText {
    return _selectedColorHex != null
        ? Text('Selected color: $_selectedColorHex')
        : null;
  }

  Widget get _supportsAlphaSwitch {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Supports Alpha'),
        Switch.adaptive(
          value: _supportsAlpha,
          onChanged: _onSupportsAlphaChanged,
        ),
      ],
    );
  }

  Widget get _cupertinoColorPickerButton {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Text('Built-in Button:'),
        const CupertinoColorPickerButton(),
      ],
    );
  }

  Widget get _showColorPickerButton {
    return ElevatedButton(
      onPressed: _showColorPicker,
      child: const Text('Show Color Picker Manually'),
    );
  }
}
