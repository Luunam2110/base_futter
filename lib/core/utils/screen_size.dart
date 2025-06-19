import 'package:flutter/material.dart';

class ScreenSize {
  static late Size size;

  static double get width => size.width;

  static double get height => size.height;

  static void init(BuildContext context) {
    size = MediaQuery.of(context).size;
  }

  static bool get isMobile => width < 600;

  static bool get isTablet => width >= 600 && width < 1024;

  static bool get isDesktop => width >= 1024;
}
