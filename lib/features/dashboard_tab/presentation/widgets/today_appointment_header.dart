import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TodayAppointmentsHeader extends StatelessWidget {
  const TodayAppointmentsHeader({super.key, required this.appointments});

  final List<AppointmentEntity> appointments;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: ColorManager.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.event_note_rounded,
            color: ColorManager.primary,
            size: 22.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "today_appointments".tr(),
                style: AppTextStyles.s20bold.copyWith(
                  color: ColorManager.black,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'scheduled_today'.tr(args: [appointments.length.toString()]),
                style: AppTextStyles.s16bold.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
