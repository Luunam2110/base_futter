import 'package:dafactory/core/constants/asset_constants.dart';
import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/generated/l10n.dart';
import 'package:dafactory/presentation/widgets/button/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              AnimationAssets.notFound,
              width: SizeConstants.fullScreenImage,
              fit: BoxFit.cover,
            ),
            Gap(SizeConstants.spacingMedium),
            SecondaryButton(
              title: S.current.go_to_home,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
