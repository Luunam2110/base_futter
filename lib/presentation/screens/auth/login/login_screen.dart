import 'package:dafactory/app/app_state.dart';
import 'package:dafactory/core/constants/asset_constants.dart';
import 'package:dafactory/core/constants/size_constants.dart';
import 'package:dafactory/core/env/app_config.dart';
import 'package:dafactory/core/extensions/string_ext.dart';
import 'package:dafactory/core/extensions/theme_ext.dart';
import 'package:dafactory/generated/l10n.dart';
import 'package:dafactory/presentation/screens/auth/login/bloc/login_cubit.dart';
import 'package:dafactory/presentation/screens/auth/login/bloc/login_effect.dart';
import 'package:dafactory/presentation/screens/auth/login/bloc/login_state.dart';
import 'package:dafactory/presentation/widgets/button/primary_button.dart';
import 'package:dafactory/presentation/widgets/button/switch_button.dart';
import 'package:dafactory/presentation/widgets/form/app_form.dart';
import 'package:dafactory/presentation/widgets/form/app_text_form_field.dart';
import 'package:dafactory/presentation/widgets/views/base_screen.dart';
import 'package:dafactory/presentation/widgets/views/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseViewState<LoginScreen, LoginCubit, LoginState, LoginEffect> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  LoginCubit createCubit() => LoginCubit();

  @override
  void mapEffect(LoginEffect effect) {
    switch (effect) {
      case ShowError():
        //todo
        break;
      case NavigateToHome():
        AppState.current().login();
        break;
    }
  }

  void listenBloc(BuildContext context, LoginState state) {
    if (state is LoginLoadedState) {
      emailController.text = state.email;
      passwordController.text = state.password;
    }
  }

  @override
  Widget container(context, child) => BlocListener<LoginCubit, LoginState>(
        bloc: cubit,
        listener: listenBloc,
        child: AppForm(key: formKey, child: child),
      );

  @override
  Widget desktop(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget mobile(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.background,
      body: SafeArea(
        top: true,
        child: StateLayout<LoginCubit>(
            bloc: cubit,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeConstants.paddingLarge),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(SizeConstants.space48),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageAssets.logoCircleImage,
                          width: SizeConstants.circleImage,
                        ),
                        const Gap(SizeConstants.space24),
                        Text(
                          AppConfig.instance.appName,
                          style: context.appTextStyles.title,
                        ),
                      ],
                    ),
                    const Gap(SizeConstants.space48),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.current.nice_to_see_you_again,
                        style: context.appTextStyles.title,
                      ),
                    ),
                    const Gap(SizeConstants.space36),
                    AppTextFormField(
                      controller: emailController,
                      title: S.current.email_or_phone_number,
                      hintText: S.current.email_or_phone_number,
                      validator: (v) {
                        if (v.isStrEmpty) return S.current.this_field_is_required;
                        return null;
                      },
                    ),
                    const Gap(SizeConstants.space24),
                    AppTextFormField(
                      controller: passwordController,
                      title: S.current.password,
                      obscureText: true,
                      hintText: S.current.enter_password,
                      validator: (v) {
                        if (v.isStrEmpty) return S.current.this_field_is_required;
                        return null;
                      },
                    ),
                    const Gap(SizeConstants.space16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            BlocBuilder<LoginCubit, LoginState>(
                              bloc: cubit,
                              buildWhen: (prev, cur) => prev.isSaveAccount != cur.isSaveAccount,
                              builder: (context, state) {
                                return AppSwitch(
                                  value: state.isSaveAccount,
                                  onChanged: cubit.toggleSaveAccount,
                                );
                              },
                            ),
                            const Gap(SizeConstants.space8),
                            Text(
                              S.current.remember_me,
                              style: context.appTextStyles.body,
                            ),
                          ],
                        ),
                        const Gap(SizeConstants.space16),
                        Text(
                          S.current.forgot_password,
                          style: context.appTextStyles.body.copyWith(
                            color: context.appColors.hyperlinkColor,
                          ),
                        ),
                      ],
                    ),
                    const Gap(SizeConstants.space24),
                    PrimaryButton(
                      title: 'login',
                      width: double.infinity,
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          cubit.login(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cubit.close();
    super.dispose();
  }
}
