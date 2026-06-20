import 'package:clinc_dashboard/core/helper/validations/app_validations.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit_provider.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_verify_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const String routeName = 'ForgotPasswordScreen';

  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => createAuthCubit(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ForgotPasswordForm(),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSendCodeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('code_sent'.tr())),
          );
          Navigator.pushReplacementNamed(
            context,
            ForgotPasswordVerifyScreen.routeName,
          );
        }

        if (state is ForgotPasswordSendCodeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordSendCodeLoading;

        return Form(
          key: _formKey,
          child: SizedBox(
            width: width,
            child: Center(
              child: SizedBox(
                width: width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'forgot_password_title'.tr(),
                      style: TextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.black,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      textAlign: TextAlign.center,
                      'enter_registered_email'.tr(),
                      style: TextStyle(
                        fontSize: 20.sp,
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
                    SizedBox(height: 40.h),
                    CustomButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context
                                    .read<AuthCubit>()
                                    .forgotPasswordSendCode(
                                      email: emailController.text.trim(),
                                    );
                              }
                            },
                      title: isLoading ? 'sending'.tr() : 'send_code'.tr(),
                      titleColor: ColorManager.white,
                      bgColor: ColorManager.primary,
                      width: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
