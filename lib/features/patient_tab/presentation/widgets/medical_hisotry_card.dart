import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class MedicalHistoryCard extends StatelessWidget {
  final String date;
  final String title;
  final String summary;
  final List<String> treatmentPlan;
  final bool hasAttachments;

  const MedicalHistoryCard({
    super.key,
    required this.date,
    required this.title,
    required this.summary,
    required this.treatmentPlan,
    required this.hasAttachments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [Text(date, style: AppTextStyles.subtitleText)]),
              const Icon(Icons.more_vert, color: ColorManager.textLight),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DIAGNOSIS SUMMARY', style: AppTextStyles.labelText),
                    const SizedBox(height: 8),
                    Text(summary, style: AppTextStyles.bodyText),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TREATMENT PLAN', style: AppTextStyles.labelText),
                    const SizedBox(height: 8),
                    ...treatmentPlan.map(
                      (plan) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('• ', style: AppTextStyles.bodyText),
                            Expanded(
                              child: Text(plan, style: AppTextStyles.bodyText),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (hasAttachments) ...[
            const SizedBox(height: 24),
            Text('ATTACHMENTS (2)', style: AppTextStyles.labelText),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildAttachmentPlaceholder(),
                const SizedBox(width: 12),
                _buildAttachmentPlaceholder(),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAttachmentPlaceholder() {
    return Container(
      width: 120,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorManager.border),
      ),
      child: const Center(
        child: Icon(
          Icons.insert_drive_file_outlined,
          color: ColorManager.primaryBlue,
        ),
      ),
    );
  }
}
