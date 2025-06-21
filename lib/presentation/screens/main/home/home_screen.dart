import 'package:dafactory/app/app_state.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/presentation/screens/main/home/cubit/home_cubit.dart';
import 'package:dafactory/presentation/screens/main/home/cubit/home_state.dart';
import 'package:dafactory/presentation/widgets/button/primary_button.dart';
import 'package:dafactory/presentation/widgets/button/secondary_button.dart';
import 'package:dafactory/presentation/widgets/dialog/app_dialog.dart';
import 'package:dafactory/presentation/widgets/toast/app_toast.dart';
import 'package:dafactory/presentation/widgets/views/base_screen.dart';
import 'package:dafactory/presentation/widgets/views/state_layout.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseViewState<HomeScreen, HomeCubit, HomeState, dynamic> {
  @override
  HomeCubit createCubit() {
    return HomeCubit();
  }

  @override
  Widget desktop(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget mobile(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        bottom: false,
        right: false,
        left: false,
        child: StateLayout<HomeCubit>(
          bloc: cubit,
          child: Container(
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PrimaryButton(
                  title: 'show toast',
                  onPressed: () {
                    AppToast.showInfo(title: 'Success', message: 'This is a success message', context: context);
                  },
                ),
                PrimaryButton(
                  title: 'show dialog',
                  onPressed: () {
                    AppDialog.showAppDialog(
                      title: 'Success',
                      builder: (BuildContext context) => const Text('asfasf'),
                      primaryButtonText: 'OK',
                      secondaryButtonText: 'Cancel',
                    );
                  },
                ),
                PrimaryButton(
                  title: 'to light theme',
                  onPressed: () {
                    final state = AppState.current();
                    state.changeTheme(ThemeMode.light);
                  },
                ),
                PrimaryButton(
                  title: 'to dark theme',
                  onPressed: () {
                    final state = AppState.current();
                    state.changeTheme(ThemeMode.dark);
                  },
                ),
                PrimaryButton(
                  title: 'to system theme',
                  onPressed: () {
                    final state = AppState.current();
                    state.changeTheme(ThemeMode.system);
                  },
                ),
                SecondaryButton(
                  title: 'logout ',
                  onPressed: () {
                    final state = AppState.current();
                    state.logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
