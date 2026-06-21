import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class UploadArea extends StatelessWidget {
  const UploadArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.border,
          style: BorderStyle.solid,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.cloud_upload_outlined,
            color: ColorManager.primaryBlue,
            size: 32,
          ),
          SizedBox(height: 12),
          Text(
            'Click to upload medical images or scans',
            style: TextStyle(
              color: ColorManager.textDark,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text('PNG, JPG, PDF up to 10MB', style: AppTextStyles.labelText),
        ],
      ),
    );
  }
}
