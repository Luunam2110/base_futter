import 'package:dafactory/core/base_bloc/base_state.dart';

abstract class SettingState extends BaseState {
  const SettingState();
}

class SettingInitialState extends BaseInitialState implements SettingState {
  const SettingInitialState();
}

class SettingLoadingState extends BaseLoadingState implements SettingState {
  const SettingLoadingState();
}

class SettingErrorState extends BaseErrorState implements SettingState {
  const SettingErrorState(super.error);
}

class SettingEmptyState extends BaseEmptyState implements SettingState {
  const SettingEmptyState({String? message}) : super(message);
}

class SettingContentState extends BaseContentState implements SettingState {
  const SettingContentState();
}
