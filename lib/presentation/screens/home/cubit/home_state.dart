import 'package:dafactory/core/base/base_state.dart';

abstract class HomeState extends BaseState {
  const HomeState();
}

class HomeInitialState extends BaseInitialState implements HomeState {
  const HomeInitialState();
}

class HomeLoadingState extends BaseLoadingState implements HomeState {
  const HomeLoadingState();
}

class HomeErrorState extends BaseErrorState implements HomeState {
  const HomeErrorState(super.error);
}

class HomeEmptyState extends BaseEmptyState implements HomeState {
  const HomeEmptyState({String? message}) : super(message);
}

class HomeLoadedState extends BaseContentState implements HomeState {
  const HomeLoadedState();
}
