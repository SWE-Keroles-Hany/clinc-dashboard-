import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AccountSettingsCard extends StatelessWidget {
  const AccountSettingsCard({
    super.key,
    required this.profileNameController,
    required this.personalEmailController,
    required this.isEditing,
    required this.inputDecoration,
    required this.labelStyle,
  });

  final TextEditingController profileNameController;
  final TextEditingController personalEmailController;
  final bool isEditing;
  final InputDecoration inputDecoration;
  final TextStyle labelStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'account_settings'.tr(),
                  style: AppTextStyles.s20bold,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('profile_name'.tr(), style: labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: profileNameController,
                        readOnly: !isEditing,
                        decoration: inputDecoration,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('personal_email'.tr(), style: labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: personalEmailController,
                        readOnly: true,
                        decoration: inputDecoration,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
