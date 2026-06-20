import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
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
        const SizedBox(height: 10),
        Text(
          "welcome_empowering".tr(),
          style: AppTextStyles.s40bold,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: width * 0.5,
          child: Text(
            style: AppTextStyles.s20bold,
            textAlign: TextAlign.center,
            "welcome_join".tr(),
          ),
        ),
      ],
    );
  }
}
