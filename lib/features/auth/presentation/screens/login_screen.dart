import 'package:clinc_dashboard/core/injection/service_locator.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/login_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "LoginScreen";
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (_) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: LoginBody(width: width),
      ),
    );
  }
}
