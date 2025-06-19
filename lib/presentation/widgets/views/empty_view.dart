import 'package:dafactory/core/constants/asset_constants.dart' show AnimationAssets;
import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, String? message}) : _message = message;
  final String? _message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            AnimationAssets.noData,
            width: SizeConstants.fullScreenImage,
            fit: BoxFit.cover,
          ),
          Gap(SizeConstants.spacingMedium),
          Text(
            _message ?? S.current.no_data,
            style: context.appTextStyles.title,
          ),
        ],
      ),
    );
  }
}
