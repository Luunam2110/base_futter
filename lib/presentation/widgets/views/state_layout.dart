import 'package:dafactory/core/base/base_state.dart';
import 'package:dafactory/core/result/app_exception.dart';
import 'package:dafactory/presentation/widgets/views/empty_view.dart';
import 'package:dafactory/presentation/widgets/views/error_view.dart';
import 'package:dafactory/presentation/widgets/views/loading_view.dart' show LoadingView;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StateLayout<B extends BlocBase> extends StatelessWidget {
  const StateLayout({
    super.key,
    required this.child,
    this.error,
    this.loading,
    this.empty,
    this.retry,
    this.bloc,
  });

  final Widget child;
  final Widget Function(AppException error, Function()? retry)? error;
  final Widget? loading;
  final Widget? empty;
  final Function()? retry;
  final B? bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bloc,
        builder: (_, state) {
          if (state is BaseLoadingState) {
            return loading ?? const LoadingView();
          }
          if (state is BaseErrorState) {
            return error?.call(state.error, retry) ??
                ErrorView(
                  exception: state.error,
                  retry: retry,
                );
          }
          if (state is BaseEmptyState) {
            return empty ?? const EmptyView();
          }
          return child;
        });
  }
}
