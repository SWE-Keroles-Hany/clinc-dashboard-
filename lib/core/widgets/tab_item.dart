import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class TabItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;
  const TabItem({
    super.key,
    this.isSelected = false,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      tileColor: isSelected
          ? const Color.fromARGB(255, 227, 238, 255)
          : Colors.transparent,
      trailing: isSelected
          ? Container(
              decoration: BoxDecoration(
                color: ColorManager.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              height: 30.h,
              width: 3.w,
            )
          : null,
      leading: Icon(icon, size: 28, color: ColorManager.kGray500),
      title: Text(title, style: AppTextStyles.s16bold),

      onTap: onTap,
    );
  }
}
