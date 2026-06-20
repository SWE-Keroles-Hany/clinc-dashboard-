import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NeedHelpCard extends StatelessWidget {
  const NeedHelpCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('need_help'.tr(), style: AppTextStyles.s18bold),
            const SizedBox(height: 8),
            Text(
              'support_message'.tr(),
              style: AppTextStyles.s14bold.copyWith(
                color: ColorManager.kGray500,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.white,
                side: const BorderSide(
                  color: ColorManager.kGray500,
                ),
              ),
              child: Text(
                'contact_support'.tr(),
                style: AppTextStyles.s14bold.copyWith(
                  color: ColorManager.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
