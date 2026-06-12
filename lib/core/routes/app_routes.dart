import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_reset_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_verify_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    SignupScreen.routeName: (context) => const SignupScreen(),
    ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
    ForgotPasswordVerifyScreen.routeName: (context) =>
        const ForgotPasswordVerifyScreen(),
    ForgotPasswordResetScreen.routeName: (context) =>
        const ForgotPasswordResetScreen(),
  };
}
