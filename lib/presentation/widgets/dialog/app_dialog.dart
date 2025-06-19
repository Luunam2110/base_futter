import 'package:dafactory/core/router/app_router.dart';
import 'package:dafactory/presentation/widgets/dialog/base_dialog.dart';
import 'package:dafactory/presentation/widgets/dialog/notification_dialog.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future<T?> showAppDialog<T>({
    DialogSize size = DialogSize.large,
    required String title,
    String? primaryButtonText,
    String? secondaryButtonText,
    Function? primaryButtonAction,
    Function? secondaryButtonAction,
    barrierDismissible = true,
    required Widget Function(BuildContext context) builder,
  }) {
    return showDialog<T>(
      context: AppRouter.context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return BaseDialog(
          title: title,
          size: size,
          builder: builder,
          secondaryButtonAction: secondaryButtonAction,
          secondaryButtonText: secondaryButtonText,
          primaryButtonAction: primaryButtonAction,
          primaryButtonText: primaryButtonText,
        );
      },
    );
  }

  static Future<void> showErrorDialog({
    required String title,
    required String message,
  }) async {
    return showDialog(
      context: AppRouter.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return NotificationDialog(
          title: title,
          message: message,
        );
      },
    );
  }

  static bool showConfirmDialog({
    required String title,
    required String message,
    Function? onConfirm,
    Function? onCancel,
  }) {
    //todo
    return true;
  }
}
