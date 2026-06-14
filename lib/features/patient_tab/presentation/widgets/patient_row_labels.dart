import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class PatientRowLabels extends StatelessWidget {
  const PatientRowLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Patient ID",
              style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              "Full Name",
              style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              "Age",
              style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Gender",
              style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Phone Number",
              style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Last Visit Date",
              style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Actions",
                style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
