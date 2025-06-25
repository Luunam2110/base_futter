import 'dart:async';

import 'package:dafactory/app/app_state.dart';
import 'package:dafactory/core/base_bloc/base_cubit.dart';
import 'package:dafactory/core/base_bloc/base_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provides a base for stateful widgets that need to support responsive layouts.
/// Inherit from this class to implement mobile, tablet, and desktop UIs.
abstract class ResponsiveState<T extends StatefulWidget> extends State<T> with ResponsiveScreenMixin {}

/// Provides a base for stateless widgets that need to support responsive layouts.
/// Inherit from this class to implement mobile, tablet, and desktop UIs.
abstract class ResponsiveStatelessWidget extends StatelessWidget with ResponsiveScreenMixin {
  const ResponsiveStatelessWidget({super.key});
}

/// Base class for stateful widgets using a Cubit for state management and effects.
/// Handles Cubit creation, effect listening, and responsive layouts.
/// - [T]: The widget type.
/// - [C]: The Cubit type.
/// - [S]: The state type.
/// - [E]: The effect type.
abstract class BaseViewState<T extends StatefulWidget, C extends BaseCubit<S, E>, S extends BaseState, E>
    extends State<T> with BaseScreenWithCubitMixin<C, S, E>, ResponsiveScreenMixin {
  late final C _cubit;

  @override
  C get cubit => _cubit;

  late final StreamSubscription _subscription;

  @override
  void initState() {
    _cubit = createCubit();
    _subscription = _cubit.effects.listen(mapEffect);
    super.initState();
  }

  /// Override to provide the Cubit instance.
  C createCubit();

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

/// Base class for stateless widgets using a Cubit for state management and effects.
/// Handles Cubit assignment and responsive layouts.
/// - [T]: The widget type.
/// - [C]: The Cubit type.
/// - [S]: The state type.
/// - [E]: The effect type.
abstract class BaseStatelessViewState<T extends StatelessWidget, C extends BaseCubit<S, E>, S extends BaseState, E>
    extends StatelessWidget with BaseScreenWithCubitMixin<C, S, E>, ResponsiveScreenMixin {
  BaseStatelessViewState({super.key});
}

/// Mixin for screens that use a Cubit for state and effect management.
/// Provides a [cubit] property and a [mapEffect] method to handle effects.
mixin BaseScreenWithCubitMixin<C extends BaseCubit<S, E>, S extends BaseState, E> {
  C get cubit;

  /// Override to handle effects emitted by the Cubit.
  void mapEffect(E effect) {}
}

/// Mixin for responsive screen layouts.
/// Provides methods to build mobile, tablet, and desktop UIs.
/// Override [mobile], [desktop], and optionally [tablet] in your widget.
mixin ResponsiveScreenMixin {
  Widget build(BuildContext context) => container(context, _build(context));

  Widget _build(BuildContext context) {
    return Consumer<AppState>(
      builder: (c, appState, __) {
        switch (appState.deviceType) {
          case DeviceType.mobile:
            return mobile(c);
          case DeviceType.tablet:
            return tablet(c) ?? mobile(c);
          case DeviceType.desktop:
            return desktop(c);
        }
      },
    );
  }

  Widget container(BuildContext context, Widget child) {
    return child;
  }

  Widget mobile(BuildContext context);

  Widget desktop(BuildContext context);

  Widget? tablet(BuildContext context) => null;
}

class ResponsiveView extends ResponsiveStatelessWidget {
  ResponsiveView({required Widget desktop, required Widget mobile, Widget? tablet, super.key}) {
    _desktop = desktop;
    _mobile = mobile;
    _tablet = tablet;
  }

  late final Widget _desktop;
  late final Widget _mobile;
  late final Widget? _tablet;

  @override
  Widget desktop(BuildContext context) => _desktop;

  @override
  Widget mobile(BuildContext context) => _mobile;

  @override
  Widget? tablet(BuildContext context) => _tablet;
}
