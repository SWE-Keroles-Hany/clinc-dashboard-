import 'package:clinc_dashboard/features/auth/presentation/widgets/login_form.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:clinc_dashboard/features/auth/presentation/widgets/welcome_section.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 4, child: WelcomeSection(width: width)),
        Expanded(flex: 3, child: SignUpForm()),
      ],
    );
  }
}
