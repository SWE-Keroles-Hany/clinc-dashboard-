import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/dashboard_tab/presentation/widgets/custom_appoinment_lable.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List<InfoItem> buildInfoItems(List<int> stats) {
  return [
    InfoItem(
      icon: Icons.people_rounded,
      title: 'total_patients'.tr(),
      value: stats[0],
      accentColor: ColorManager.primary,
    ),

    InfoItem(
      icon: Icons.calendar_month_rounded,
      title: 'today_appointments'.tr(),
      value: stats[1],
      accentColor: const Color(0xff7C3AED),
    ),

    InfoItem(
      icon: Icons.check_circle_rounded,
      title: 'completed_appointments'.tr(),
      value: stats[2],
      accentColor: ColorManager.completed,
    ),

    InfoItem(
      icon: Icons.hourglass_top_rounded,
      title: 'pending_appointments'.tr(),
      value: stats[3],
      accentColor: ColorManager.pending,
    ),

    InfoItem(
      icon: Icons.cancel_rounded,
      title: 'cancelled_appointments'.tr(),
      value: stats[4],
      accentColor: ColorManager.error,
    ),
  ];
}

String formatAppointmentTime(String appointmentDate) {
  try {
    return DateFormat('hh:mm a').format(DateTime.parse(appointmentDate));
  } catch (_) {
    return appointmentDate;
  }
}
