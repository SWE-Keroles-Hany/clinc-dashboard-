import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class PatientWelcomeHeader extends StatelessWidget {
  const PatientWelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Patient Management",
          style: AppTextStyles.s30bold.copyWith(color: ColorManager.black),
        ),
        SizedBox(height: 6.h),
        Text(
          "Manage, monitor and review patient records across the facility.",
          style: AppTextStyles.s16bold,
        ),
      ],
    );
  }
}
