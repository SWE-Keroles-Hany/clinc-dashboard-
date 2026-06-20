import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/appoinment_row_info.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TodayAppointments extends StatelessWidget {
  const TodayAppointments({super.key, required this.appointments});

  final List<AppointmentEntity> appointments;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: appointments.length,
      separatorBuilder: (context, _) => SizedBox(height: 10.h),
      itemBuilder: (_, index) {
        final appointment = appointments[index];
        return AppoinmentRowInfo(
          imgURL: "assets/images/kero.jpg",
          name: appointment.patientName,
          status: appointment.status,
          time: formatAppointmentTime(appointment.appointmentDate),
        );
      },
    );
  }
}
