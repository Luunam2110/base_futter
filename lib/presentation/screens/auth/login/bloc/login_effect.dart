import 'package:dafactory/core/result/app_exception.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEffect extends Equatable {
  const LoginEffect();
}

class ShowError extends LoginEffect {
  final AppException exception;

  const ShowError(this.exception);

  @override
  List<Object> get props => [exception];
}

class NavigateToHome extends LoginEffect {

  const NavigateToHome();

  @override
  List<Object?> get props => [];
}
