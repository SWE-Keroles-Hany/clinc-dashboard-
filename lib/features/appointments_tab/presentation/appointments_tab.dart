import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:clinc_dashboard/core/utils/ui_utils.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/cubit/appointment_cubit.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/cubit/appointment_states.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/widgets/filter_list.dart';
import 'package:clinc_dashboard/features/appointments_tab/presentation/widgets/appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppointmentsTab extends StatefulWidget {
  const AppointmentsTab({super.key});

  @override
  State<AppointmentsTab> createState() => _AppointmentsTabState();
}

class _AppointmentsTabState extends State<AppointmentsTab> {
  String? selectedDate;
  @override
  void initState() {
    super.initState();
    context.read<AppointmentCubit>().getAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentCubit, AppointmentState>(
      listenWhen: (previous, current) =>
          current is AppointmentStatusUpdateError ||
          current is AppointmentStatusUpdated,
      listener: (context, state) {
        if (state is AppointmentStatusUpdateError) {
          UiUtils.showSnackBar(context, state.message);
        } else if (state is AppointmentStatusUpdated) {
          UiUtils.showSnackBar(context, 'appointment_status_updated'.tr());
        }
      },
      child: Container(
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
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
            SizedBox(height: 32.h),
            //! Filters row (flow dashboard style )
            SizedBox(
              height: 40.h,
              child: Row(
                children: [
                  Expanded(
                    child: FilterList(
                      onStatusSelected: (status) {
                        context.read<AppointmentCubit>().getAppointment(
                          status: status,
                          selectedDate: selectedDate,
                        );
                      },
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Container(
                  //     padding: EdgeInsets.symmetric(
                  //       vertical: 4.h,
                  //       horizontal: 8.w,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8.r),
                  //       color: ColorManager.kGray500,
                  //     ),
                  //     child: Text("Filter .."),
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      selectedDate = null;
                      setState(() {});
                    },
                    icon: Icon(Icons.delete, color: ColorManager.red),
                  ),
                  Text(selectedDate ?? "", style: AppTextStyles.s20bold),
                  IconButton(
                    onPressed: () async {
                      final DateTime now = DateTime.now();

                      final date = await showDatePicker(
                        context: context,
                        initialDate: now,
                        firstDate: DateTime(
                          now.year - 1,
                          now.month,
                          now.day,
                        ), // سنة فاتت
                        lastDate: DateTime(
                          now.year + 1,
                          now.month,
                          now.day,
                        ), // سنة جاية
                      );
                      if (date != null) {
                        String formattedDate = DateFormat(
                          'yyyy-MM-dd',
                        ).format(date);
                        setState(() {
                          selectedDate = formattedDate;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.date_range,
                      color: ColorManager.primary,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            //! Appointment list
            Expanded(
              child: BlocBuilder<AppointmentCubit, AppointmentState>(
                builder: (context, state) {
                  if (state is AppointmentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AppointmentError) {
                    return Text(
                      state.message,
                      style: AppTextStyles.s20bold.copyWith(
                        color: ColorManager.black,
                      ),
                    );
                  } else if (state is AppointmentSuccess) {
                    return ListView.separated(
                      itemCount: state.appointments!.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final appointment = state.appointments![index];
                        final isUpdating = state is AppointmentStatusUpdating;

                        return AppointmentCard(
                          appointment: appointment,
                          isUpdating: isUpdating,
                          onStatusChanged: (newStatus) {
                            context
                                .read<AppointmentCubit>()
                                .updateAppointmentType(
                                  appointmentId: appointment.appointmentId,
                                  newStatus: newStatus,
                                );
                          },
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
