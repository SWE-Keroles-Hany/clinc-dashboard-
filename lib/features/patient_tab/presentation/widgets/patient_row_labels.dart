import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class PatientMainRowLabels extends StatelessWidget {
  const PatientMainRowLabels({super.key});

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
              'patient_id'.tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              'full_name'.tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'age'.tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'gender'.tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'phone_number'.tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'last_visit_date'.tr(),
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
                'actions'.tr(),
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
