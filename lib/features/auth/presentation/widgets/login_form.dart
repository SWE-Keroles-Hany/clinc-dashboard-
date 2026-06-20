import 'package:clinc_dashboard/core/helper/validations/app_validations.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/signup_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:clinc_dashboard/home.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
// LoginForm Widget implementation

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, Home.routeName);
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return SizedBox(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            decoration: BoxDecoration(color: ColorManager.white),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'welcome_back'.tr(),
                    style: AppTextStyles.s40bold.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  Text(
                    'sign_in_prompt'.tr(),
                    style: AppTextStyles.s18bold.copyWith(
                      color: ColorManager.black,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomInputField(
                    icon: Icons.email,
                    hintText: 'email_hint'.tr(),
                    keyboardType: TextInputType.emailAddress,
                    title: 'email_address'.tr(),
                    controller: emailController,
                    validator: AppValidations.emailValidator,
                  ),
                  SizedBox(height: 30.h),
                  CustomInputField(
                    isPasswordField: true,
                    icon: Icons.lock,
                    hintText: 'password_hint'.tr(),
                    title: 'password'.tr(),
                    controller: passwordController,
                    validator: (value) =>
                        AppValidations.passwordValidator(value: value),
                  ),
                  SizedBox(height: 3.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ForgotPasswordScreen.routeName,
                        );
                      },
                      child: Text(
                        'forgot_password'.tr(),
                        style: AppTextStyles.s18bold.copyWith(
                          color: ColorManager.primary,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: BorderSide(color: ColorManager.black),
                        checkColor: ColorManager.white,
                        activeColor: ColorManager.primary,
                        value: rememberMe,
                        onChanged: (isChecked) {
                          setState(() {
                            rememberMe = isChecked ?? false;
                          });
                        },
                      ),
                      Text(
                        'remember_me'.tr(),
                        style: AppTextStyles.s18bold.copyWith(
                          color: ColorManager.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            if (_formKey.currentState?.validate() ?? false) {
                              context.read<AuthCubit>().login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                            }
                          },
                    title: isLoading ? 'signing_in'.tr() : 'log_in'.tr(),
                    titleColor: ColorManager.white,
                    bgColor: ColorManager.primary,
                    width: width,
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'new_to_telemedicine'.tr(),
                        style: AppTextStyles.s20bold,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            SignupScreen.routeName,
                          );
                        },
                        child: Text(
                          'create_an_account'.tr(),
                          style: AppTextStyles.s20bold.copyWith(
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
