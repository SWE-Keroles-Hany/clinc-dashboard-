import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  static const String routeName = "SignupScreen";

  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: SignUpBody(width: width),
    );
  }
}
