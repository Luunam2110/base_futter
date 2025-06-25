import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/core/router/app_router.dart';
import 'package:dafactory/presentation/widgets/button/primary_button.dart';
import 'package:dafactory/presentation/widgets/views/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingScreen extends ResponsiveStatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget desktop(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: const Center(
        child: Text('Setting'),
      ),
    );
  }

  @override
  Widget mobile(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Setting'),
            PrimaryButton(
              title: 'Navigate to other page',
             onPressed: (){
               context.push(AppRouter.example);
             },
            ),
          ],
        ),
      ),
    );
  }
}
