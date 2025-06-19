import 'package:dafactory/core/base/base_cubit.dart';
import 'package:dafactory/core/base/base_state.dart';
import 'package:dafactory/core/utils/screen_size.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _cubit = createCubit();
    _cubit.effects.listen(mapEffect);
    super.initState();
  }

  /// Override to provide the Cubit instance.
  C createCubit();

  @override
  void dispose() {
    cubit.close();
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
    if (ScreenSize.isMobile) return mobile(context);
    if (ScreenSize.isTablet) return tablet(context) ?? mobile(context);
    return desktop(context);
  }

  Widget container(BuildContext context, Widget child) {
    return child;
  }

  Widget mobile(BuildContext context);

  Widget desktop(BuildContext context);

  Widget? tablet(BuildContext context) => null;
}