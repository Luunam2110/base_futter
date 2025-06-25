import 'package:dafactory/app/app_state.dart';
import 'package:flutter/material.dart';

class ScreenSize {
  static late Size size;

  static double get width => size.width;

  static double get height => size.height;

  static DeviceType init(BuildContext context) {
    size = MediaQuery.of(context).size;
    return ScreenSize.isMobile
        ? DeviceType.mobile
        : ScreenSize.isTablet
            ? DeviceType.tablet
            : DeviceType.desktop;
  }

  static bool get isMobile => width < 600;

  static bool get isTablet => width >= 600 && width < 1024;

  static bool get isDesktop => width >= 1024;
}
