import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    super.key,
    required this.title,
    required this.titleColor,
    required this.bgColor,
    this.radiusNumber = 8.0,
    required this.width,
  });
  final void Function()? onPressed;
  final String title;
  final Color bgColor;
  final Color titleColor;
  final double radiusNumber;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width, 55),
        // padding: EdgeInsets.all(8.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(radiusNumber),
        ),
        backgroundColor: bgColor,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: AppTextStyles.s20bold.copyWith(color: ColorManager.white),
      ),
    );
  }
}
