import 'package:dafactory/core/constants/color_constants.dart' show ColorsConstants;
import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  final Color background;
  final Color shadowColor;
  final Color textColor;
  final Color errorColor;
  final Color errorBackgroundColor;
  final Color successColor;
  final Color successBackgroundColor;
  final Color warningColor;
  final Color warningBackgroundColor;
  final Color infoColor;
  final Color infoBackgroundColor;
  final Color dividerColor;
  final Color secondaryBackground;
  final Color primaryColor;
  final Color splashColor;
  final Color borderColor;
  final Color hintColor;
  final Color hyperlinkColor;

  const AppColors({
    required this.background,
    required this.textColor,
    required this.errorColor,
    required this.successColor,
    required this.errorBackgroundColor,
    required this.successBackgroundColor,
    required this.warningColor,
    required this.warningBackgroundColor,
    required this.infoColor,
    required this.infoBackgroundColor,
    required this.shadowColor,
    required this.dividerColor,
    required this.secondaryBackground,
    required this.primaryColor,
    required this.splashColor,
    required this.borderColor,
    required this.hintColor,
    required this.hyperlinkColor,
  });

  @override
  AppColors copyWith({
    Color? background,
    Color? textColor,
    Color? errorColor,
    Color? successColor,
    Color? errorBackgroundColor,
    Color? successBackgroundColor,
    Color? warningColor,
    Color? warningBackgroundColor,
    Color? infoColor,
    Color? infoBackgroundColor,
    Color? shadowColor,
    Color? dividerColor,
    Color? secondaryBackground,
    Color? primaryColor,
    Color? splashColor,
    Color? borderColor,
    Color? hintColor,
    Color? hyperlinkColor,
  }) {
    return AppColors(
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      background: background ?? this.background,
      textColor: textColor ?? this.textColor,
      errorBackgroundColor: errorBackgroundColor ?? this.errorBackgroundColor,
      successBackgroundColor: successBackgroundColor ?? this.successBackgroundColor,
      warningColor: warningColor ?? this.warningColor,
      warningBackgroundColor: warningBackgroundColor ?? this.warningBackgroundColor,
      infoColor: infoColor ?? this.infoColor,
      infoBackgroundColor: infoBackgroundColor ?? this.infoBackgroundColor,
      shadowColor: shadowColor ?? this.shadowColor,
      dividerColor: dividerColor ?? this.dividerColor,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      primaryColor: primaryColor ?? this.primaryColor,
      splashColor: splashColor ?? this.splashColor,
      borderColor: borderColor ?? this.borderColor,
      hintColor: hintColor ?? this.hintColor,
      hyperlinkColor: hyperlinkColor ?? this.hyperlinkColor,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      errorColor: Color.lerp(errorColor, other.errorColor, t)!,
      successColor: Color.lerp(successColor, other.successColor, t)!,
      background: Color.lerp(background, other.background, t)!,
      textColor: Color.lerp(textColor, other.textColor, t)!,
      errorBackgroundColor: Color.lerp(errorBackgroundColor, other.errorBackgroundColor, t)!,
      successBackgroundColor: Color.lerp(successBackgroundColor, other.successBackgroundColor, t)!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      warningBackgroundColor: Color.lerp(warningBackgroundColor, other.warningBackgroundColor, t)!,
      infoColor: Color.lerp(infoColor, other.infoColor, t)!,
      infoBackgroundColor: Color.lerp(infoBackgroundColor, other.infoBackgroundColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      secondaryBackground: Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      splashColor: Color.lerp(splashColor, other.splashColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      hintColor: Color.lerp(hintColor, other.hintColor, t)!,
      hyperlinkColor: Color.lerp(hyperlinkColor, other.hyperlinkColor, t)!,
    );
  }

  static AppColors light = AppColors(
    background: ColorsConstants.colorFFFFFF,
    textColor: ColorsConstants.color000000,
    errorColor: ColorsConstants.colorF21E1E,
    successColor: ColorsConstants.color27AE60,
    errorBackgroundColor: ColorsConstants.colorFDDDDD,
    successBackgroundColor: ColorsConstants.colorB6EECE,
    warningColor: ColorsConstants.colorFBE74D,
    warningBackgroundColor: ColorsConstants.colorFDF7C9,
    infoColor: ColorsConstants.color5A91F7,
    infoBackgroundColor: ColorsConstants.colorE6EEFD,
    shadowColor: ColorsConstants.color2C2C2C.withValues(alpha: 102),
    dividerColor: ColorsConstants.colorE6E6E6,
    secondaryBackground: ColorsConstants.colorF5F5F5,
    primaryColor: ColorsConstants.color4CAF50,
    splashColor: ColorsConstants.color46C64A,
    borderColor: ColorsConstants.colorD4D7E3,
    hintColor: ColorsConstants.color8897AD,
    hyperlinkColor: ColorsConstants.color007AFF,
  );
  static AppColors dark = AppColors(
    background: ColorsConstants.color2C2C2C,
    textColor: ColorsConstants.colorFFFFFF,
    errorColor: ColorsConstants.colorF21E1E,
    successColor: ColorsConstants.color27AE60,
    errorBackgroundColor: ColorsConstants.colorFDDDDD,
    successBackgroundColor: ColorsConstants.colorB6EECE,
    warningColor: ColorsConstants.colorFBE74D,
    warningBackgroundColor: ColorsConstants.colorFDF7C9,
    infoColor: ColorsConstants.color5A91F7,
    infoBackgroundColor: ColorsConstants.colorE6EEFD,
    shadowColor: ColorsConstants.colorFFFFFF.withValues(alpha: 102),
    dividerColor: ColorsConstants.color444444,
    secondaryBackground: ColorsConstants.color383838,
    primaryColor: ColorsConstants.color4CAF50,
    splashColor: ColorsConstants.color46C64A,
    borderColor: ColorsConstants.colorD4D7E3,
    hintColor: ColorsConstants.color8897AD,
    hyperlinkColor: ColorsConstants.color007AFF,
  );
}
