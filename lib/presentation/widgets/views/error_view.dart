import 'package:dafactory/core/constants/asset_constants.dart';
import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/core/result/app_exception.dart';
import 'package:dafactory/generated/l10n.dart' show S;
import 'package:dafactory/presentation/widgets/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart' show Lottie;

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, required this.exception, this.retry});

  final AppException exception;
  final Function()? retry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            exception is NoNetworkException ? AnimationAssets.noNetwork : AnimationAssets.error,
            width: SizeConstants.fullScreenImage,
            fit: BoxFit.cover,
          ),
          Gap(SizeConstants.spacingMedium),
          Text(
            exception.title,
            style: context.appTextStyles.title,
          ),
          Gap(SizeConstants.spacingSmall),
          Text(
            exception.message,
            style: context.appTextStyles.body,
            textAlign: TextAlign.center,
          ),
          if (retry != null) ...[
            Gap(SizeConstants.spacingMedium),
            PrimaryButton(
              title: S.current.retry,
              onPressed: retry,
              color: context.appColors.errorColor,
            ),
          ]
        ],
      ),
    );
  }
}
