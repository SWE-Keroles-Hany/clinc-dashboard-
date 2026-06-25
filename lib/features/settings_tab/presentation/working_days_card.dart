import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/utils/ui_utils.dart';
import 'package:clinc_dashboard/core/widgets/custom_button.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_cubit.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';

class WorkingDaysCard extends StatefulWidget {
  const WorkingDaysCard({super.key});

  @override
  State<WorkingDaysCard> createState() => _WorkingDaysCardState();
}

class DaySchedule {
  final String day;
  bool selected;
  TimeOfDay startTime;
  TimeOfDay endTime;

  DaySchedule({
    required this.day,
    this.selected = false,
    this.startTime = const TimeOfDay(hour: 9, minute: 0),
    this.endTime = const TimeOfDay(hour: 17, minute: 0),
  });
}

class _WorkingDaysCardState extends State<WorkingDaysCard> {
  final List<DaySchedule> _days = [
    DaySchedule(day: 'Monday'),
    DaySchedule(day: 'Tuesday'),
    DaySchedule(day: 'Wednesday'),
    DaySchedule(day: 'Thursday'),
    DaySchedule(day: 'Friday'),
    DaySchedule(day: 'Saturday'),
    DaySchedule(day: 'Sunday'),
  ];

  Future<void> _selectTime({
    required BuildContext context,
    required TimeOfDay initialTime,
    required Function(TimeOfDay) onTimeSelected,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      onTimeSelected(picked);
    }
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  void _saveSchedule() {
    final schedules = _days
        .where((d) => d.selected)
        .map(
          (d) => ScheduleModel(
            dayOfWeek: d.day,
            startTime: _formatTime(d.startTime),
            endTime: _formatTime(d.endTime),
          ),
        )
        .toList();

    context.read<SettingsCubit>().setSchedule(schedules: schedules);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsScheduleLoaded) {
          UiUtils.showSnackBar(context, "Schedule saved successfully!");
        }
        if (state is SettingsScheduleError) {
          UiUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is SettingsScheduleLoading;

        return Container(
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add or Edit Working Days & Hours',
                style: AppTextStyles.s18bold,
              ),
              SizedBox(height: 16.h),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                ..._buildEditForm(),
              // else
              //   ..._buildScheduleDisplay(state.schedules!),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildEditForm() {
    return [
      ..._days.map((day) {
        final index = _days.indexOf(day);
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            children: [
              Checkbox(
                value: day.selected,
                onChanged: (value) {
                  setState(() {
                    _days[index].selected = value ?? false;
                  });
                },
                activeColor: ColorManager.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(child: Text(day.day, style: AppTextStyles.s14bold)),
              if (day.selected) ...[
                InkWell(
                  onTap: () => _selectTime(
                    context: context,
                    initialTime: day.startTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _days[index].startTime = time;
                      });
                    },
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _formatTime(day.startTime),
                      style: AppTextStyles.s14bold,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'to',
                  style: AppTextStyles.s14bold.copyWith(
                    color: ColorManager.kGray500,
                  ),
                ),
                SizedBox(width: 8.w),
                InkWell(
                  onTap: () => _selectTime(
                    context: context,
                    initialTime: day.endTime,
                    onTimeSelected: (time) {
                      setState(() {
                        _days[index].endTime = time;
                      });
                    },
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.lightGray,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      _formatTime(day.endTime),
                      style: AppTextStyles.s14bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      }),
      SizedBox(height: 16.h),
      CustomButton(
        width: double.infinity,
        onPressed: _saveSchedule,
        bgColor: ColorManager.primary,
        title: "Save Schedule",
        titleColor: ColorManager.white,
        // height: 48.h,
      ),
    ];
  }

  //   return [
  //     ...schedules.map((schedule) {
  //       return Padding(
  //         padding: EdgeInsets.only(bottom: 12.h),
  //         child: Row(
  //           children: [
  //             Icon(
  //               Icons.check_circle,
  //               color: ColorManager.primary,
  //               size: 24.sp,
  //             ),
  //             SizedBox(width: 12.w),
  //             Expanded(
  //               child: Text(schedule.dayOfWeek, style: AppTextStyles.s14bold),
  //             ),
  //             Text(
  //               '${schedule.startTime} - ${schedule.endTime}',
  //               style: AppTextStyles.s14bold.copyWith(
  //                 color: ColorManager.kGray500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     }),
  //     SizedBox(height: 16.h),
  //     // ElevatedButton(
  //     //   onPressed: () {
  //     //     context.read<SettingsCubit>().toggleEditSchedule();
  //     //   },
  //     //   style: ElevatedButton.styleFrom(
  //     //     backgroundColor: ColorManager.lightGray,
  //     //     foregroundColor: ColorManager.primary,
  //     //     minimumSize: Size(double.infinity, 48.h),
  //     //   ),
  //     //   child: const Text('Edit Schedule'),
  //     // ),
  //   ];
  // }
}
