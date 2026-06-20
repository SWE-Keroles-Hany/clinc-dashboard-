import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/utils/ui_utils.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/cubit/dashboard_cubit.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/cubit/dashboard_states.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/appoinment_row_labels.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/dashboard_stats_info.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/today_appointment_header.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/today_appointments.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'widgets/dashboard_header.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardState>(
      listener: (context, state) {
        if (state is DashboardStatsError || state is AppointmentsError) {
          final message = state is DashboardStatsError
              ? state.message
              : (state as AppointmentsError).message;

          UiUtils.showSnackBar(context, message);
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
              const DashboardHeader(),
              SizedBox(height: 28.h),
              //! info
              SizedBox(
                height: 200.h,
                child: isLoadingStats && stats == null
                    ? const Center(child: CircularProgressIndicator())
                    : DashboardStatsInfo(stats: stats),
              ),

              //! today's appoinment
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
                      //! header
                      TodayAppointmentsHeader(appointments: appointments),
                      SizedBox(height: 20.h),
                      const AppoinmentMainRowLabels(),
                      SizedBox(height: 12.h),
                      Expanded(
                        child:
                            isLoadingAppointments && state.appointments == null
                            ? const Center(child: CircularProgressIndicator())
                            : appointments.isEmpty
                            ? Center(
                                child: Text(
                                  'no_appointments_today'.tr(),
                                  style: AppTextStyles.s16bold.copyWith(
                                    color: ColorManager.kGray500,
                                  ),
                                ),
                              )
                            : TodayAppointments(appointments: appointments),
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
