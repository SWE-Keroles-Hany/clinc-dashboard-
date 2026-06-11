import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/icons/telemedicine.png"),
        SizedBox(height: 10),
        Text(
          "Empowering clinicians with precision AI tools.",
          style: AppTextStyles.s40bold,
        ),
        SizedBox(height: 10),
        SizedBox(
          width: width * 0.5,
          child: Text(
            style: AppTextStyles.s20bold,
            textAlign: TextAlign.center,
            "Join the next generation of healthcare delivery. Our unified clinical operating system integrates patient data, diagnostic AI, and seamless workflow management into one sterile, focused environment.",
          ),
        ),
      ],
    );
  }
}
