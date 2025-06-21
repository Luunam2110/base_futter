import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/core/router/app_router.dart';
import 'package:dafactory/core/utils/logger.dart';
import 'package:dafactory/core/utils/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class AppToast {
  static const _autoCloseDuration = Duration(seconds: 5);
  static const _animationDuration = Duration(milliseconds: 300);

  static void showSuccess({String? message, String? title, BuildContext? context}) {
    _showNotification(
      message: message,
      title: title,
      type: ToastificationType.success,
      context: context,
    );
  }

  static void showError({String? message, String? title, BuildContext? context}) {
    _showNotification(
      message: message,
      title: title,
      type: ToastificationType.error,
      context: context,
    );
  }

  static void showInfo({String? message, String? title, BuildContext? context}) {
    _showNotification(
      message: message,
      title: title,
      type: ToastificationType.info,
      context: context,
    );
  }

  static void showWarning({String? message, String? title, BuildContext? context}) {
    _showNotification(
      message: message,
      title: title,
      type: ToastificationType.warning,
      context: context,
    );
  }

  static String showProcessing({
    String? message,
    String? title,
    BuildContext? context,
  }) {
    return _showNotification(
      message: message,
      title: title,
      isProcessing: true,
      context: context,
    );
  }

  static String _showNotification({
    String? message,
    String? title,
    ToastificationType? type,
    bool isProcessing = false,
    BuildContext? context,
  }) {
    assert(isProcessing || type != null, 'Type must be provided unless isProcessing is true');
    final realContext = context ?? AppRouter.context;
    final closeDuration = isProcessing ? null : _autoCloseDuration;
    final style = isProcessing ? ToastificationStyle.flat : ToastificationStyle.flatColored;
    final icon = isProcessing
        ? SizedBox(
            width: SizeConstants.iconDefault,
            height: SizeConstants.iconDefault,
            child: const CircularProgressIndicator(strokeWidth: 2),
          )
        : Icon(
            type!.icon,
            size: SizeConstants.iconDefault,
            color: type.primaryColor,
          );
    final color = isProcessing ? null : type!.primaryColor;
    return toastification
        .show(
          context: context,
          style: style,
          autoCloseDuration: closeDuration,
          title: title != null ? Text(title, style: realContext.appTextStyles.darkSubtitle) : null,
          description: message != null ? Text(message, style: realContext.appTextStyles.darkBody) : null,
          alignment: ScreenSize.isMobile ? Alignment.bottomCenter : Alignment.topRight,
          direction: TextDirection.ltr,
          animationDuration: _animationDuration,
          animationBuilder: (context, animation, alignment, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          icon: icon,
          showIcon: true,
          primaryColor: color,
          padding: EdgeInsets.symmetric(horizontal: SizeConstants.paddingMedium, vertical: SizeConstants.paddingMedium),
          margin: EdgeInsets.symmetric(horizontal: SizeConstants.marginMedium, vertical: SizeConstants.marginSmall),
          borderRadius: BorderRadius.circular(SizeConstants.defaultBorderRadius),
          closeButton: ToastCloseButton(
            showType: ScreenSize.isDesktop ? CloseButtonShowType.onHover : CloseButtonShowType.always,
            buttonBuilder: (context, onClose) {
              return IconButton(
                onPressed: onClose,
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.close,
                  size: SizeConstants.iconDefault,
                  color: context.appColors.textColor,
                ),
              );
            },
          ),
          closeOnClick: false,
          pauseOnHover: true,
          dragToClose: true,
          applyBlurEffect: !realContext.isDarkMode,
          callbacks: ToastificationCallbacks(
            onTap: (toastItem) => logger.d('Toast ${toastItem.id} tapped'),
            onCloseButtonTap: (toastItem) {
              logger.d('Toast ${toastItem.id} close button tapped');
              toastification.dismissById(toastItem.id);
            },
            onAutoCompleteCompleted: (toastItem) => logger.d('Toast ${toastItem.id} auto complete completed'),
            onDismissed: (toastItem) => logger.d('Toast ${toastItem.id} dismissed'),
          ),
        )
        .id;
  }
}

extension ToastificationTypeExtension on ToastificationType {
  Color get primaryColor {
    final context = AppRouter.context;
    switch (this) {
      case ToastificationType.success:
        return context.appColors.successColor;
      case ToastificationType.error:
        return context.appColors.errorColor;
      case ToastificationType.info:
        return context.appColors.infoColor;
      case ToastificationType.warning:
        return context.appColors.warningColor;
      default:
        return context.appColors.infoColor;
    }
  }
}
