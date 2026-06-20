import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "dashboard_overview".tr(),
                style: AppTextStyles.s30bold.copyWith(
                  color: ColorManager.black,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "dashboard_welcome".tr(),
                style: AppTextStyles.s16bold,
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: ColorManager.primary.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 18.sp,
                color: ColorManager.primary,
              ),
              SizedBox(width: 8.w),
              Text(
                DateFormat('MMM d, yyyy').format(DateTime.now()),
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
