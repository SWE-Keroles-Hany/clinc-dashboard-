import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ClinicInformationCard extends StatelessWidget {
  const ClinicInformationCard({
    super.key,
    required this.specialtyController,
    required this.phoneController,
    required this.emailController,
    required this.yearsOfExperienceController,
    required this.addressController,
    required this.bioController,
    required this.isEditing,
    required this.onToggleEdit,
    required this.inputDecoration,
    required this.labelStyle,
  });

  final TextEditingController specialtyController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController yearsOfExperienceController;
  final TextEditingController addressController;
  final TextEditingController bioController;
  final bool isEditing;
  final VoidCallback onToggleEdit;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.apartment,
                      color: ColorManager.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'clinic_information'.tr(),
                      style: AppTextStyles.s20bold,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onToggleEdit,
                  child: Text(isEditing ? 'cancel'.tr() : 'edit'.tr()),
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
                      Text('specialty'.tr(), style: labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: specialtyController,
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
                      Text('phone_number'.tr(), style: labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: phoneController,
                        readOnly: !isEditing,
                        decoration: inputDecoration,
                      ),
                    ],
                  ),
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
                      Text('email_address'.tr(), style: labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: emailController,
                        readOnly: true,
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
                      Text('years_of_experience'.tr(), style: labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: yearsOfExperienceController,
                        readOnly: !isEditing,
                        keyboardType: TextInputType.number,
                        decoration: inputDecoration,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text('address'.tr(), style: labelStyle),
            const SizedBox(height: 6),
            TextFormField(
              controller: addressController,
              readOnly: !isEditing,
              maxLines: 3,
              decoration: inputDecoration,
            ),
            const SizedBox(height: 12),
            Text('bio'.tr(), style: labelStyle),
            const SizedBox(height: 6),
            TextFormField(
              controller: bioController,
              readOnly: !isEditing,
              maxLines: 3,
              decoration: inputDecoration,
            ),
          ],
        ),
      ),
    );
  }
}
