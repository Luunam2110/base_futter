import 'package:flutter/material.dart';

//todo create main screen for app
class MainScreen extends StatefulWidget {
  const MainScreen(this.child, {super.key});

  final Widget child;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
