import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class PatientRowInfo extends StatefulWidget {
  final PatientEntity patient;
  final VoidCallback onViewPressed;

  const PatientRowInfo({
    super.key,
    required this.patient,
    required this.onViewPressed,
  });

  @override
  State<PatientRowInfo> createState() => _PatientRowInfoState();
}

class _PatientRowInfoState extends State<PatientRowInfo> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: _isHovered
              ? ColorManager.primary.withValues(alpha: 0.04)
              : ColorManager.lightGray.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _isHovered
                ? ColorManager.primary.withValues(alpha: 0.15)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Patient ID
            Expanded(
              flex: 2,
              child: Text(
                widget.patient.patientId,
                style: AppTextStyles.s14bold.copyWith(
                  fontFamily: 'monospace',
                  color: ColorManager.kGray500,
                ),
              ),
            ),
            // Full Name (Avatar + Name)
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorManager.primary.withValues(alpha: 0.15),
                        width: 1.5,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 18.r,
                      backgroundColor: ColorManager.lightGray,
                      backgroundImage: widget.patient.profilePicUrl.isNotEmpty
                          ? NetworkImage(widget.patient.profilePicUrl)
                          : null,
                      child: widget.patient.profilePicUrl.isEmpty
                          ? Icon(
                              Icons.person,
                              size: 18.sp,
                              color: ColorManager.kGray500,
                            )
                          : null,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      widget.patient.fullName,
                      style: AppTextStyles.s16bold.copyWith(
                        color: ColorManager.black,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Age
            Expanded(
              flex: 1,
              child: Text(
                "${widget.patient.age}",
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.kGray500,
                ),
              ),
            ),
            // Gender
            Expanded(
              flex: 2,
              child: Text(
                getGender(context, widget.patient.gender),
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.kGray500,
                ),
              ),
            ),
            // Phone Number
            Expanded(
              flex: 3,
              child: Text(
                widget.patient.phoneNumber,
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.kGray500,
                ),
              ),
            ),
            // Last Visit Date
            Expanded(
              flex: 3,
              child: Text(
                widget.patient.lastVisitDate,
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.kGray500,
                ),
              ),
            ),
            // Actions
            Expanded(
              flex: 2,
              child: AnimatedOpacity(
                opacity: _isHovered ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 150),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add_circle_outline_rounded,
                        color: ColorManager.black,
                      ),
                      iconSize: 20.sp,
                      color: ColorManager.kGray500,
                      hoverColor: ColorManager.primary.withValues(alpha: 0.1),
                      tooltip: 'add medical record'.tr(),
                      onPressed: widget.onViewPressed,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getGender(BuildContext context, String gender) {
    final currentLocale = EasyLocalization.of(context)?.locale.languageCode;
    if (currentLocale == 'ar') {
      if (gender == "Male") {
        return "ذكر";
      } else {
        return "إنثى";
      }
    } else {
      return gender;
    }
  }
}
