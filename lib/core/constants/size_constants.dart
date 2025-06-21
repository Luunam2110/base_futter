import 'dart:ui' show Size;

import 'package:dafactory/core/utils/screen_size.dart';

class SizeConstants {
  static double get paddingLarge => ScreenSize.isDesktop
      ? 24.0
      : ScreenSize.isTablet
          ? 20.0
          : 16.0;

  static double get paddingMedium => ScreenSize.isDesktop
      ? 20.0
      : ScreenSize.isTablet
          ? 16.0
          : 12.0;

  static double get paddingSmall => ScreenSize.isDesktop
      ? 12.0
      : ScreenSize.isTablet
      ? 10.0
      : 8.0;


  static double get paddingTiny => ScreenSize.isDesktop
      ? 8.0
      : ScreenSize.isTablet
          ? 6.0
          : 4.0;

  static double get paddingExtraTiny => ScreenSize.isDesktop
      ? 4.0
      : ScreenSize.isTablet
          ? 2.0
          : 1.0;

  static double get marginLarge => ScreenSize.isDesktop
      ? 24.0
      : ScreenSize.isTablet
          ? 20.0
          : 16.0;

  static double get marginMedium => ScreenSize.isDesktop
      ? 20.0
      : ScreenSize.isTablet
          ? 16.0
          : 12.0;

  static double get marginSmall => ScreenSize.isDesktop
      ? 16.0
      : ScreenSize.isTablet
          ? 12.0
          : 8.0;

  static double get defaultBorderRadius => 12.0;

  static double get spacingLarge => ScreenSize.isDesktop
      ? 24.0
      : ScreenSize.isTablet
          ? 20.0
          : 16.0;

  static double get spacingMedium => ScreenSize.isDesktop
      ? 20.0
      : ScreenSize.isTablet
          ? 16.0
          : 12.0;

  static double get spacingSmall => ScreenSize.isDesktop
      ? 16.0
      : ScreenSize.isTablet
          ? 12.0
          : 8.0;

  static double get fullScreenImage => ScreenSize.isDesktop
      ? 400.0
      : ScreenSize.isTablet
          ? 300.0
          : 200.0;


  static double get circleImage => ScreenSize.isDesktop
      ? 64
      : ScreenSize.isTablet
          ? 56
          : 48;

  static double get iconDefault => ScreenSize.isDesktop ? 24.0 : 20.0;

  static double get iconLarge => ScreenSize.isDesktop ? 36.0 : 28.0;

  static Size get dialogLarge => ScreenSize.isDesktop
      ? Size(780, ScreenSize.height * 0.7)
      : ScreenSize.isTablet
          ? Size(ScreenSize.width * 0.7, ScreenSize.height * 0.7)
          : Size(ScreenSize.width * 0.9, ScreenSize.height * 0.7);

  static Size get dialogMedium => ScreenSize.isDesktop
      ? Size(550, ScreenSize.height * 0.7)
      : ScreenSize.isTablet
          ? Size(ScreenSize.width * 0.6, ScreenSize.height * 0.7)
          : Size(ScreenSize.width * 0.8, ScreenSize.height * 0.7);


  static const fieldHeight = 48.0;


  static const space4 = 4.0;
  static const space8 = 8.0;
  static const space16 = 16.0;
  static const space24 = 24.0;
  static const space36 = 36.0;
  static const space48 = 48.0;
  static const space56 = 56.0;
  static const space60 = 60.0;
  static const space64 = 64.0;
  static const space96 = 96.0;
  static const space128 = 128.0;
}
