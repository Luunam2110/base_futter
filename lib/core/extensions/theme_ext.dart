import 'package:dafactory/core/themes/app_color.dart' show AppColors;
import 'package:dafactory/core/themes/app_text_style.dart' show AppTextStyles;
import 'package:flutter/material.dart';

extension ThemeModeExt on String {
  ThemeMode toThemeMode() {
    switch (this) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}

extension GetThemeExt on BuildContext {
  AppColors get appColors {
    return Theme.of(this).extension<AppColors>()!;
  }

  AppTextStyles get appTextStyles {
    return Theme.of(this).extension<AppTextStyles>()!;
  }

  bool get isDarkMode {
    return appColors == AppColors.dark;
  }
}
