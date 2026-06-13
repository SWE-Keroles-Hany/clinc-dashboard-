import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/auth/dashboard/presentation/widgets/custom_appoinment_lable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AppoinmentRowInfo extends StatefulWidget {
  const AppoinmentRowInfo({
    super.key,
    required this.imgURL,
    required this.name,
    required this.time,
    required this.status,
  });
  final String imgURL;
  final String name;
  final String time;
  final String status;

  @override
  State<AppoinmentRowInfo> createState() => _AppoinmentRowInfoState();
}

class _AppoinmentRowInfoState extends State<AppoinmentRowInfo> {
  late Color textColor;
  late Color bgColor;

  @override
  void initState() {
    super.initState();
    final status = widget.status.toLowerCase();
    if (status == "completed") {
      textColor = ColorManager.completed;
      bgColor = ColorManager.completedBg;
    } else if (status == "pending") {
      textColor = ColorManager.pending;
      bgColor = ColorManager.pendingBg;
    } else {
      textColor = ColorManager.error;
      bgColor = ColorManager.errordBg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ColorManager.lightGray.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ColorManager.primary.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 22.r,
                    backgroundImage: AssetImage(widget.imgURL),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: CustomAppointmentLabel(
                    color: ColorManager.black,
                    label: widget.name,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 16.sp,
                  color: ColorManager.kGray500,
                ),
                SizedBox(width: 6.w),
                CustomAppointmentLabel(
                  label: widget.time,
                  color: ColorManager.kGray500,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: textColor.withValues(alpha: 0.2)),
                ),
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 14.w),
                child: Text(
                  widget.status,
                  style: AppTextStyles.s14bold.copyWith(color: textColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
