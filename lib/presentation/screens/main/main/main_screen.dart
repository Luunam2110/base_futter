import 'package:dafactory/core/router/app_router.dart';
import 'package:dafactory/presentation/screens/main/home/cubit/home_cubit.dart';
import 'package:dafactory/presentation/screens/main/setting/bloc/setting_cubit.dart';
import 'package:dafactory/presentation/widgets/views/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'mobile_navigator_bar.dart';

//todo create main screen for app
class MainScreen extends StatefulWidget {
  const MainScreen(this.child, {super.key, this.path});

  final Widget child;
  final String? path;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ResponsiveState<MainScreen> {
  @override
  Widget container(BuildContext context, Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (c) => SettingCubit(),
        ),
        BlocProvider(
          create: (c) => HomeCubit(),
        ),
      ],
      child: child,
    );
  }

  @override
  Widget desktop(BuildContext context) {
    return widget.child;
  }

  @override
  Widget mobile(BuildContext context) {
    return MobileNavigatorBar(
      initIndex: widget.path == AppRouter.setting ? 1 : 0,
      showNavigator: widget.path == AppRouter.setting || widget.path == AppRouter.home,
      child: widget.child,
    );
  }
}
