import 'package:dafactory/presentation/screens/main/navigator/mobile_navigator_bar.dart';
import 'package:dafactory/presentation/widgets/views/base_screen.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  factory NavigatorScreen.desktop({required Widget child, Key? key}) => NavigatorScreen._(
        key: key,
        child: child,
      );

  factory NavigatorScreen.mobile({Key? key, int initIndex = 0}) => NavigatorScreen._(
        key: key,
        initIndex: initIndex,
      );

  const NavigatorScreen._({
    super.key,
    this.child,
    this.initIndex = 0,
  });

  final Widget? child;

  final int initIndex;

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends ResponsiveState<NavigatorScreen> {
  @override
  Widget desktop(BuildContext context) {
    return widget.child!;
  }

  @override
  Widget mobile(BuildContext context) {
    return MobileNavigatorBar(initIndex: widget.initIndex);
  }
}
