import 'dart:async';

import 'package:cupertino_color_picker/cupertino_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Color? _selectedColor;
  String? _selectedColorHex;

  Future<void> _showColorPicker() async {
    try {
      final color = await showCupertinoColorPicker(
        initialColor: _selectedColor,
        supportsAlpha: true,
      );

      if (color != null) {
        setState(() {
          // Color 객체를 직접 사용
          _selectedColor = color;
          // 표시를 위해 hex 문자열도 생성
          _selectedColorHex =
              '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
        });
      }
    } on PlatformException catch (e) {
      setState(() {
        _selectedColorHex = "Error: ${e.code}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Cupertino Color Picker Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: _selectedColor ?? Colors.grey,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              if (_selectedColorHex != null)
                Text('Selected color: $_selectedColorHex'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _showColorPicker,
                child: const Text('Show Color Picker'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
