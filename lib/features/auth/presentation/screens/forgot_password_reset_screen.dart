import 'package:clinc_dashboard/core/helper/validations/app_validations.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_states.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit_provider.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ForgotPasswordResetScreen extends StatelessWidget {
  static const String routeName = 'ForgotPasswordResetScreen';

  const ForgotPasswordResetScreen({super.key});

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
            child: ForgotPasswordResetForm(width: width),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordResetForm extends StatefulWidget {
  const ForgotPasswordResetForm({super.key, required this.width});

  final double width;

  @override
  State<ForgotPasswordResetForm> createState() =>
      _ForgotPasswordResetFormState();
}

class _ForgotPasswordResetFormState extends State<ForgotPasswordResetForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final codeController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordResetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successfully')),
          );
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }

        if (state is ForgotPasswordResetError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordResetLoading;

        return Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Enter your email, code, and a new password.',
                style: TextStyle(fontSize: 18.sp, color: ColorManager.black),
              ),
              SizedBox(height: 30.h),
              CustomInputField(
                icon: Icons.email,
                hintText: 'keroles@gmail.com',
                keyboardType: TextInputType.emailAddress,
                title: 'Email Address',
                controller: emailController,
                validator: AppValidations.emailValidator,
              ),
              SizedBox(height: 20.h),
              CustomInputField(
                icon: Icons.confirmation_num,
                hintText: '123456',
                keyboardType: TextInputType.number,
                title: 'Verification Code',
                controller: codeController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Enter the verification code';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              CustomInputField(
                isPasswordField: true,
                icon: Icons.lock,
                hintText: '*************',
                title: 'New Password',
                controller: newPasswordController,
                validator: (value) =>
                    AppValidations.passwordValidator(value: value),
              ),
              SizedBox(height: 20.h),
              CustomInputField(
                isPasswordField: true,
                icon: Icons.lock_outline,
                hintText: '*************',
                title: 'Confirm Password',
                controller: confirmPasswordController,
                validator: (value) => AppValidations.confirmPasswordValidator(
                  value: value,
                  password: newPasswordController.text.trim(),
                ),
              ),
              SizedBox(height: 20.h),
              CustomButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().forgotPasswordReset(
                            email: emailController.text.trim(),
                            code: codeController.text.trim(),
                            newPassword: newPasswordController.text.trim(),
                            confirmPassword: confirmPasswordController.text
                                .trim(),
                          );
                        }
                      },
                title: isLoading ? 'Resetting...' : 'Reset Password',
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
