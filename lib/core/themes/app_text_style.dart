import 'package:dafactory/core/themes/app_color.dart';
import 'package:flutter/material.dart';

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle title;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle lightTitle;
  final TextStyle lightBody;
  final TextStyle darkTitle;
  final TextStyle darkBody;
  final TextStyle lightSubtitle;
  final TextStyle darkSubtitle;
  final TextStyle caption;

  const AppTextStyles._({
    required this.title,
    required this.subtitle,
    required this.body,
    required this.lightBody,
    required this.lightTitle,
    required this.darkTitle,
    required this.darkBody,
    required this.lightSubtitle,
    required this.darkSubtitle,
    required this.caption,
  });

  /// Base styles (không có màu)
  static const _baseTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static const _baseSubtitle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const _baseBody = TextStyle(fontSize: 15);
  static const _baseCaption = TextStyle(fontSize: 12);

  /// Gộp base style + màu
  static AppTextStyles fromColor(AppColors colors) => AppTextStyles._(
        title: _baseTitle.copyWith(color: colors.textColor),
        subtitle: _baseSubtitle.copyWith(color: colors.textColor),
        body: _baseBody.copyWith(color: colors.textColor),
        lightTitle: _baseTitle.copyWith(color: AppColors.dark.textColor),
        lightBody: _baseBody.copyWith(color: AppColors.dark.textColor),
        darkTitle: _baseTitle.copyWith(color: AppColors.light.textColor),
        darkBody: _baseBody.copyWith(color: AppColors.light.textColor),
        lightSubtitle: _baseSubtitle.copyWith(color: AppColors.dark.textColor),
        darkSubtitle: _baseSubtitle.copyWith(color: AppColors.light.textColor),
        caption: _baseCaption.copyWith(color: colors.textColor),
      );

  @override
  AppTextStyles copyWith({
    TextStyle? title,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? caption,
    TextStyle? lightTitle,
    TextStyle? lightBody,
    TextStyle? darkTitle,
    TextStyle? darkBody,
    TextStyle? lightSubtitle,
    TextStyle? darkSubtitle,
  }) {
    return AppTextStyles._(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      caption: caption ?? this.caption,
      lightTitle: lightTitle ?? this.lightTitle,
      lightBody: lightBody ?? this.lightBody,
      darkTitle: darkTitle ?? this.darkTitle,
      darkBody: darkBody ?? this.darkBody,
      lightSubtitle: lightSubtitle ?? this.lightSubtitle,
      darkSubtitle: darkSubtitle ?? this.darkSubtitle,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles._(
      title: TextStyle.lerp(title, other.title, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      lightBody: TextStyle.lerp(lightBody, other.lightBody, t)!,
      lightTitle: TextStyle.lerp(lightTitle, other.lightTitle, t)!,
      darkTitle: TextStyle.lerp(darkTitle, other.darkTitle, t)!,
      darkBody: TextStyle.lerp(darkBody, other.darkBody, t)!,
      lightSubtitle: TextStyle.lerp(lightSubtitle, other.lightSubtitle, t)!,
      darkSubtitle: TextStyle.lerp(darkSubtitle, other.darkSubtitle, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
    );
  }

  static final light = AppTextStyles.fromColor(AppColors.light);
  static final dark = AppTextStyles.fromColor(AppColors.dark);
}
