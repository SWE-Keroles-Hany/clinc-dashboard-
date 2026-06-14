import 'package:clinc_dashboard/core/theme/app_text_styles.dart';

import 'package:clinc_dashboard/core/theme/color_manger.dart';

import 'package:clinc_dashboard/features/dashboard/domain/entities/appointment_entity.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/cubit/dashboard_cubit.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/cubit/dashboard_states.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/widgets/appoinment_row_info.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/widgets/appoinment_row_labels.dart';

import 'package:clinc_dashboard/features/dashboard/presentation/widgets/custom_appoinment_lable.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:intl/intl.dart';

class DashboardTab extends StatefulWidget {
  const DashboardTab({super.key});

  @override
  State<DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<DashboardTab> {
  @override
  void initState() {
    super.initState();

    final cubit = context.read<DashboardCubit>();

    cubit.getDashboardStatus();

    cubit.getTodayAppointments(todayOnly: true);
  }

  List<InfoItem> _buildInfoItems(List<int> stats) {
    return [
      InfoItem(
        icon: Icons.people_rounded,
        title: "Total Patients",
        value: stats[0],
        accentColor: ColorManager.primary,
      ),

      InfoItem(
        icon: Icons.calendar_month_rounded,

        title: "Today's Appointments",

        value: stats[1],

        accentColor: const Color(0xff7C3AED),
      ),

      InfoItem(
        icon: Icons.check_circle_rounded,

        title: "Completed Appointments",

        value: stats[2],

        accentColor: ColorManager.completed,
      ),

      InfoItem(
        icon: Icons.hourglass_top_rounded,

        title: "Pending Appointments",

        value: stats[3],

        accentColor: ColorManager.pending,
      ),

      InfoItem(
        icon: Icons.cancel_rounded,

        title: "Cancelled Appointments",

        value: stats[4],

        accentColor: ColorManager.error,
      ),
    ];
  }

  String _formatAppointmentTime(String appointmentDate) {
    try {
      return DateFormat('hh:mm a').format(DateTime.parse(appointmentDate));
    } catch (_) {
      return appointmentDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state is DashboardStatsError || state is AppointmentsError) {
          final message = state is DashboardStatsError
              ? state.message
              : (state as AppointmentsError).message;

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      },

      builder: (context, state) {
        final stats = state.stats;

        final appointments = state.appointments ?? const <AppointmentEntity>[];

        final isLoadingStats = state is DashboardStatsLoading;

        final isLoadingAppointments = state is AppointmentsLoading;

        return Container(
          padding: EdgeInsets.fromLTRB(32.r, 32.r, 32.r, 24.r),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const _DashboardHeader(),

              SizedBox(height: 28.h),

              SizedBox(
                height: 200.h,

                child: isLoadingStats && stats == null
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,

                        itemCount: stats != null ? stats.length : 5,

                        separatorBuilder: (context, _) => SizedBox(width: 20.w),

                        itemBuilder: (_, index) {
                          if (stats == null) {
                            return InfoItem(
                              icon: Icons.people_rounded,

                              title: "Loading...",

                              value: 0,

                              accentColor: ColorManager.primary,
                            );
                          }

                          return _buildInfoItems(stats)[index];
                        },
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
                              color: ColorManager.primary.withValues(
                                alpha: 0.1,
                              ),

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
                                  "${appointments.length} scheduled for today",

                                  style: AppTextStyles.s16bold.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      const AppinmentMainRowLabels(),

                      SizedBox(height: 12.h),

                      Expanded(
                        child:
                            isLoadingAppointments && state.appointments == null
                            ? const Center(child: CircularProgressIndicator())
                            : appointments.isEmpty
                            ? Center(
                                child: Text(
                                  "No appointments for today",

                                  style: AppTextStyles.s16bold.copyWith(
                                    color: ColorManager.kGray500,
                                  ),
                                ),
                              )
                            : ListView.separated(
                                itemCount: appointments.length,

                                separatorBuilder: (context, _) =>
                                    SizedBox(height: 10.h),

                                itemBuilder: (_, index) {
                                  final appointment = appointments[index];

                                  return AppoinmentRowInfo(
                                    imgURL: "assets/images/kero.jpg",

                                    name: appointment.patientName,

                                    status: appointment.status,

                                    time: _formatAppointmentTime(
                                      appointment.appointmentDate,
                                    ),
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
      },
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

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
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "Welcome back! Here's what's happening at your clinic today.",

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
