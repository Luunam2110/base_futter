import 'package:dafactory/core/themes/app_color.dart';
import 'package:dafactory/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static final _theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );

  static final ThemeData lightTheme = _theme.copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppColors.light,
      AppTextStyles.light,
    ],
  );

  static final ThemeData darkTheme = _theme.copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppColors.dark,
      AppTextStyles.dark,
    ],
  );
}
