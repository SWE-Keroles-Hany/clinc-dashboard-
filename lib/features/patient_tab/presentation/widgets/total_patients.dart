import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TotalPatients extends StatelessWidget {
  const TotalPatients({super.key, required this.patients});

  final int patients;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        'total_patients_count'.tr(args: [patients.toString()]),
        style: AppTextStyles.s14bold.copyWith(
          fontSize: 11.sp,
          color: ColorManager.kGray500,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
