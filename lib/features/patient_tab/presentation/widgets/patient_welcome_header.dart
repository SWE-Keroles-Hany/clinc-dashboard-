import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
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
          'patient_management'.tr(),
          style: AppTextStyles.s30bold.copyWith(color: ColorManager.black),
        ),
        SizedBox(height: 6.h),
        Text('patient_management_subtitle'.tr(), style: AppTextStyles.s16bold),
      ],
    );
  }
}
