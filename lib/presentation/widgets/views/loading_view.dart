import 'package:dafactory/core/constants/asset_constants.dart' show AnimationAssets;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        AnimationAssets.loading,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
