import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/auth/presentation/cubit/auth_cubit_provider.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/sign_up_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "SignupScreen";

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (_) => createAuthCubit(),
      child: Scaffold(
        backgroundColor: ColorManager.white,
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: SignUpBody(width: width),
        ),
      ),
    );
  }
}
