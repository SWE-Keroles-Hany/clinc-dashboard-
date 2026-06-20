import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ClincTitleAndSubtitle extends StatelessWidget {
  const ClincTitleAndSubtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        textAlign: TextAlign.center,
        "app_title".tr(),
        style: AppTextStyles.s30bold,
      ),
      subtitle: Text(
        textAlign: TextAlign.center,
        "clinical_management".tr(),
        style: AppTextStyles.s14bold.copyWith(
          fontWeight: FontWeight.w600,
          color: ColorManager.kGray500,
        ),
      ),
    );
  }
}
