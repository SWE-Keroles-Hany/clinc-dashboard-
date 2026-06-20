import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppoinmentMainRowLabels extends StatelessWidget {
  const AppoinmentMainRowLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorManager.lightGray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "patient_name".tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "time".tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "status".tr(),
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.kGray500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
