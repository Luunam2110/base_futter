import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/core/router/app_router.dart';
import 'package:dafactory/presentation/screens/main/home/home_screen.dart';
import 'package:dafactory/presentation/screens/main/setting/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class MobileNavigatorBar extends StatefulWidget {
  const MobileNavigatorBar({
    super.key,
    this.initIndex,
    required this.child,
    required this.showNavigator,
  });

  final int? initIndex;
  final Widget child;
  final bool showNavigator;

  @override
  State<MobileNavigatorBar> createState() => _MobileNavigatorBarState();
}

class _MobileNavigatorBarState extends State<MobileNavigatorBar> {
  int currentIndex = 0;
  bool showNavigator = true;

  @override
  void initState() {
    showNavigator = widget.showNavigator;
    currentIndex = widget.initIndex ?? 0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MobileNavigatorBar oldWidget) {
    if (widget.showNavigator != oldWidget.showNavigator) {
      setState(() => showNavigator = widget.showNavigator);
    }
    super.didUpdateWidget(oldWidget);
  }

  Widget getChildFormIndex(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SettingScreen();
      default:
        return const SizedBox();
    }
  }

  void selectedIndex(int index) {
    setState(() => currentIndex = index);
    context.go(
      index == 0 ? AppRouter.home : AppRouter.setting,
    );
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizeConstants.space4;
    final width = MediaQuery.of(context).size.width - gap * 2;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: widget.child,
          ),
          if (showNavigator)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: context.appColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.2 * 255).round()),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  ),
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: SizeConstants.space56,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        bottom: 0,
                        left: width / 2 * currentIndex + (gap * currentIndex),
                        width: width / 2,
                        top: 0,
                        duration: const Duration(milliseconds: 100),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: context.appColors.primaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: NavigatorItem(
                              onPressed: () => selectedIndex(0),
                              isActive: currentIndex == 0,
                              icon: const Icon(Icons.home),
                            ),
                          ),
                          const Gap(gap),
                          Expanded(
                            child: NavigatorItem(
                              onPressed: () => selectedIndex(1),
                              isActive: currentIndex == 1,
                              icon: const Icon(Icons.settings),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NavigatorItem extends StatefulWidget {
  const NavigatorItem({
    super.key,
    required this.isActive,
    required this.icon,
    required this.onPressed,
  });

  final bool isActive;
  final Icon icon;
  final VoidCallback onPressed;

  @override
  State<NavigatorItem> createState() => _NavigatorItemState();
}

class _NavigatorItemState extends State<NavigatorItem> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Color?> _colorAnimation;
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.isActive ? 1 : 0,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  void didChangeDependencies() {
    if (!isLoaded) {
      _colorAnimation = ColorTween(begin: Colors.grey, end: context.appColors.background).animate(_animationController);
      isLoaded = true;
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant NavigatorItem oldWidget) {
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          onTap: widget.onPressed,
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Icon(
              widget.icon.icon,
              color: _colorAnimation.value,
              size: 24,
            ),
          ),
        );
      },
    );
  }
}
