import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    SignupScreen.routeName: (context) => const SignupScreen(),
  };
}
