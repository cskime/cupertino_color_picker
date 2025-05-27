import 'package:flutter/material.dart';

class CupertinoColorPickerButton extends StatelessWidget {
  final double size;

  const CupertinoColorPickerButton({super.key, this.size = 32});

  @override
  Widget build(BuildContext context) {
    const String viewType = 'UIColorWell';
    return SizedBox(
        width: size, height: size, child: UiKitView(viewType: viewType));
  }
}
