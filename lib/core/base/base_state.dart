import 'package:dafactory/core/result/app_exception.dart';
import 'package:equatable/equatable.dart' show Equatable;

abstract class BaseState extends Equatable {
  const BaseState();
}

class BaseInitialState extends BaseState {
  const BaseInitialState();

  @override
  List<Object> get props => [];
}

class BaseLoadingState extends BaseState {
  const BaseLoadingState();

  @override
  List<Object> get props => [];
}

class BaseErrorState extends BaseState {
  final AppException error;

  const BaseErrorState(this.error);

  @override
  List<Object> get props => [error];
}

class BaseEmptyState extends BaseState {
  const BaseEmptyState(this.message);

  final String? message;

  @override
  List<Object> get props => [message ?? ''];
}

class BaseContentState extends BaseState {
  const BaseContentState();

  @override
  List<Object> get props => [];
}
