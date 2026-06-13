import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/auth/dashboard/presentation/widgets/appoinment_row_info.dart';
import 'package:clinc_dashboard/features/auth/dashboard/presentation/widgets/appoinment_row_labels.dart';
import 'package:clinc_dashboard/features/auth/dashboard/presentation/widgets/custom_appoinment_lable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class DashboardTab extends StatelessWidget {
  DashboardTab({super.key});

  final clincInfo = [
    InfoItem(
      icon: Icons.people_rounded,
      title: "Total Patients",
      value: 1234,
      accentColor: ColorManager.primary,
    ),
    InfoItem(
      icon: Icons.calendar_month_rounded,
      title: "Today's Appointments",
      value: 15,
      accentColor: const Color(0xff7C3AED),
    ),
    InfoItem(
      icon: Icons.check_circle_rounded,
      title: "Completed Appointments",
      value: 1200,
      accentColor: ColorManager.completed,
    ),
    InfoItem(
      icon: Icons.hourglass_top_rounded,
      title: "Pending Appointments",
      value: 5,
      accentColor: ColorManager.pending,
    ),
    InfoItem(
      icon: Icons.cancel_rounded,
      title: "Cancelled Appointments",
      value: 5,
      accentColor: ColorManager.error,
    ),
  ];

  static const _appointments = [
    ("Keroles Hany", "09:00 AM", "Pending"),
    ("Sarah Ahmed", "10:30 AM", "Completed"),
    ("Mohamed Ali", "11:00 AM", "Pending"),
    ("Nour Hassan", "12:00 PM", "Cancelled"),
    ("Laila Omar", "01:30 PM", "Completed"),
    ("Ahmed Youssef", "02:00 PM", "Pending"),
    ("Mariam Said", "03:15 PM", "Completed"),
    ("Omar Farouk", "04:00 PM", "Pending"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(32.r, 32.r, 32.r, 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DashboardHeader(appointmentCount: _appointments.length),
          SizedBox(height: 28.h),
          SizedBox(
            height: 160.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: clincInfo.length,
              separatorBuilder: (_, __) => SizedBox(width: 20.w),
              itemBuilder: (_, index) => clincInfo[index],
            ),
          ),
          SizedBox(height: 28.h),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                              "Today's Appointments",
                              style: AppTextStyles.s20bold.copyWith(
                                color: ColorManager.black,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              "${_appointments.length} scheduled for today",
                              style: AppTextStyles.s16bold.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.arrow_forward_rounded, size: 18.sp),
                        label: Text(
                          "View All",
                          style: AppTextStyles.s16bold.copyWith(
                            color: ColorManager.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: ColorManager.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const AppinmentMainRowLabels(),
                  SizedBox(height: 12.h),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _appointments.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, index) {
                        final (name, time, status) = _appointments[index];
                        return AppoinmentRowInfo(
                          imgURL: "assets/images/kero.jpg",
                          name: name,
                          status: status,
                          time: time,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader({required this.appointmentCount});

  final int appointmentCount;

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
                "Dashboard Overview",
                style: AppTextStyles.s30bold.copyWith(
                  color: ColorManager.black,
                  fontSize: 28.sp,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Welcome back! Here's what's happening at your clinic today.",
                style: AppTextStyles.s16bold.copyWith(
                  fontWeight: FontWeight.w400,
                ),
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
                "Jun 13, 2026",
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
