import 'package:clinc_dashboard/core/helper/validations/app_validations.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit_provider.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_reset_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ForgotPasswordVerifyScreen extends StatelessWidget {
  static const String routeName = 'ForgotPasswordVerifyScreen';

  const ForgotPasswordVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocProvider(
      create: (_) => createAuthCubit(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: ForgotPasswordVerifyForm(width: width),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordVerifyForm extends StatefulWidget {
  const ForgotPasswordVerifyForm({super.key, required this.width});

  final double width;

  @override
  State<ForgotPasswordVerifyForm> createState() =>
      _ForgotPasswordVerifyFormState();
}

class _ForgotPasswordVerifyFormState extends State<ForgotPasswordVerifyForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordVerifyCodeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('code_verified'.tr())),
          );
          Navigator.pushReplacementNamed(
            context,
            ForgotPasswordResetScreen.routeName,
          );
        }

        if (state is ForgotPasswordVerifyCodeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordVerifyCodeLoading;

        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'verify_code'.tr(),
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'enter_email_code'.tr(),
                style: TextStyle(fontSize: 18.sp, color: ColorManager.black),
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
              SizedBox(height: 20.h),
              CustomInputField(
                icon: Icons.confirmation_num,
                hintText: '123456',
                keyboardType: TextInputType.number,
                title: 'verification_code'.tr(),
                controller: codeController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'enter_verification_code'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().forgotPasswordVerifyCode(
                            email: emailController.text.trim(),
                            code: codeController.text.trim(),
                          );
                        }
                      },
                title: isLoading ? 'verifying'.tr() : 'verify_code'.tr(),
                titleColor: ColorManager.white,
                bgColor: ColorManager.primary,
                width: widget.width,
              ),
            ],
          ),
        );
      },
    );
  }
}
