import 'package:clinc_dashboard/core/injection/service_locator.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_reset_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/forgot_password_verify_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/login_screen.dart';
import 'package:clinc_dashboard/features/auth/presentation/screens/signup_screen.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/patient_profile_screen.dart';
import 'package:clinc_dashboard/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> routes = {
    LoginScreen.routeName: (context) => const LoginScreen(),
    Home.routeName: (context) =>
        BlocProvider(create: (_) => getIt<AuthCubit>(), child: Home()),
    PatientProfileScreen.routeName: (context) => const PatientProfileScreen(),
    SignupScreen.routeName: (context) => const SignupScreen(),
    ForgotPasswordScreen.routeName: (context) => const ForgotPasswordScreen(),
    ForgotPasswordVerifyScreen.routeName: (context) =>
        const ForgotPasswordVerifyScreen(),
    ForgotPasswordResetScreen.routeName: (context) =>
        const ForgotPasswordResetScreen(),
  };
}
