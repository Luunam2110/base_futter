import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    //todo custom style or create a new switch follow Figma
    return Switch(
      value: value,
      onChanged: onChanged,
    );
  }
}
