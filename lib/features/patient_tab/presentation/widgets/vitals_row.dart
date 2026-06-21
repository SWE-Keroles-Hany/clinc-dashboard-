import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class VitalsRow extends StatelessWidget {
  const VitalsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildVitalCard(
            Icons.favorite_border,
            'Heart Rate',
            '72',
            'bpm',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildVitalCard(
            Icons.swap_vert_rounded,
            'Blood Pressure',
            '120/80',
            '',
          ),
        ),
      ],
    );
  }

  Widget _buildVitalCard(
    IconData icon,
    String title,
    String value,
    String unit,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorManager.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorManager.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: ColorManager.primaryBlue),
          const SizedBox(height: 8),
          Text(
            title,
            style: AppTextStyles.subtitleText,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: AppTextStyles.heading1),
              if (unit.isNotEmpty) ...[
                const SizedBox(width: 4),
                Text(unit, style: AppTextStyles.subtitleText),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
