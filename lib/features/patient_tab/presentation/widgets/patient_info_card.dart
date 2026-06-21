import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class PatientInfoCard extends StatelessWidget {
  const PatientInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: ColorManager.primaryBlue),
              SizedBox(width: 8),
              Text('Patient Info', style: AppTextStyles.heading2),
            ],
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildSection('BLOOD TYPE', 'O -', null)),
              Expanded(
                child: _buildSection('HEIGHT / WEIGHT', '168 cm / 64 kg', null),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text('EMERGENCY CONTACT', style: AppTextStyles.labelText),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorManager.tagChronicBg,
                child: const Text(
                  'JF',
                  style: TextStyle(
                    color: ColorManager.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Julian Fitzwilliam (Spouse)', style: AppTextStyles.heading3),
                  Text('+1 (555) 012-9876', style: AppTextStyles.subtitleText),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String value, String? subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.labelText),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyles.heading3),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(subtitle, style: AppTextStyles.subtitleText),
        ],
      ],
    );
  }
}
