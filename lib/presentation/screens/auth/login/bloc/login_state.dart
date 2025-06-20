import 'package:dafactory/core/base_bloc/base_state.dart';

mixin DefaultLoginDataMixin {
  bool get isSaveAccount => false;

  String get email => '';

  String get password => '';
}

abstract class LoginState extends BaseState with DefaultLoginDataMixin {
  const LoginState();
}

class LoginInitialState extends BaseInitialState with DefaultLoginDataMixin implements LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends BaseLoadingState with DefaultLoginDataMixin implements LoginState {
  const LoginLoadingState();
}

class LoginErrorState extends BaseErrorState with DefaultLoginDataMixin implements LoginState {
  const LoginErrorState(super.error);
}

class LoginEmptyState extends BaseEmptyState with DefaultLoginDataMixin implements LoginState {
  const LoginEmptyState({String? message}) : super(message);
}

class LoginLoadedState extends BaseContentState with DefaultLoginDataMixin implements LoginState {
  LoginLoadedState({this.isSaveAccount = false, this.email = '', this.password = ''});

  @override
  final bool isSaveAccount;
  @override
  final String email;
  @override
  final String password;

  LoginLoadedState copyWith({
    bool? isSaveAccount,
    String? email,
    String? password,
  }) {
    return LoginLoadedState(
      isSaveAccount: isSaveAccount ?? this.isSaveAccount,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [isSaveAccount, email, password];
}
