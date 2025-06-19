import 'package:dafactory/core/base/base_cubit.dart' show BaseCubit;
import 'package:dafactory/core/result/result.dart';
import 'package:dafactory/presentation/screens/auth/login/bloc/login_effect.dart';
import 'package:dafactory/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:dafactory/presentation/screens/auth/login/login_usecase.dart';

class LoginCubit extends BaseCubit<LoginState, LoginEffect> {
  LoginCubit() : super(const LoginInitialState()) {
    initState();
  }

  final _useCase = LoginScreenUseCase();

  LoginLoadedState? get contentState => state is LoginLoadedState ? state as LoginLoadedState : null;

  Future<void> initState() async {
    final savedAccount = await _useCase.getSavedAccount();
    emit(LoginLoadedState(
      isSaveAccount: savedAccount != null && savedAccount.email.isNotEmpty && savedAccount.password.isNotEmpty,
      email: savedAccount?.email ?? '',
      password: savedAccount?.password ?? '',
    ));
  }

  void toggleSaveAccount(bool value) {
    final newState = contentState!.copyWith(isSaveAccount: value);
    if (contentState != null) emit(newState);
  }

  Future<void> login(String useName, String password) async {
    final result = await _useCase.login(useName, password, state.isSaveAccount);
    if (result is Success) {
      emitEffect(const NavigateToHome());
    } else {
      emitEffect(ShowError((result as Error).error));
    }
  }
}
