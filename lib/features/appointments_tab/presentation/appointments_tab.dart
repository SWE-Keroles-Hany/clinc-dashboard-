import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/widgets/filter_list.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  // Sample data for preview; replace with real data source when wiring
  List<AppointmentEntity> get _sampleAppointments => const [
    AppointmentEntity(
      appointmentId: 1,
      patientName: 'John Doe',
      appointmentDate: '2026-06-14T09:30:00',
      status: 'Pending',
    ),
    AppointmentEntity(
      appointmentId: 2,
      patientName: 'Mary Smith',
      appointmentDate: '2026-06-14T10:15:00',
      status: 'Completed',
    ),
    AppointmentEntity(
      appointmentId: 3,
      patientName: 'Ahmed Ali',
      appointmentDate: '2026-06-14T11:00:00',
      status: 'Cancelled',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final appointments = _sampleAppointments;

    return Container(
      color: ColorManager.backgroud,
      padding: EdgeInsets.fromLTRB(32.r, 32.r, 32.r, 24.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! Header area ( -> not an app bar ->)
          Text(
            'appointments'.tr(),
            style: AppTextStyles.s30bold.copyWith(color: ColorManager.black),
          ),
          SizedBox(height: 8.h),
          Text(
            'manage_appointments'.tr(),
            style: AppTextStyles.s14bold.copyWith(color: ColorManager.kGray500),
          ),
          SizedBox(height: 32.h),
          //! Filters row (flow dashboard style )
          SizedBox(height: 40.h, child: FilterList()),
          SizedBox(height: 16.h),
          //! Appointment list
          Expanded(
            child: ListView.separated(
              itemCount: appointments.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final appt = appointments[index];
                return AppointmentCard(appointment: appt);
              },
            ),
          ),
        ],
      ),
    );
  }
}
