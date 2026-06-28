import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/core/theme/app_text_styles.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/add_medical_record_dialog.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/medical_hisotry_card.dart';
import 'package:flutter/material.dart';

class MedicalHistorySection extends StatelessWidget {
  final int patientId;

  const MedicalHistorySection({super.key, required this.patientId});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Medical History', style: AppTextStyles.heading1),
              TextButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        AddMedicalRecordDialog(patientId: patientId),
                  );
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: ColorManager.primaryBlue,
                ),
                label: const Text(
                  'Add Medical Record',
                  style: TextStyle(
                    color: ColorManager.primaryBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const MedicalHistoryCard(
            date: 'Oct 12, 2023',
            title: 'Type 2 Diabetes Mellitus',
            summary:
                'Patient presents with elevated HbA1c (7.2%). Reports occasional fatigue and increased thirst over the past 3 months. No signs of neuropathy observed at this time.',
            treatmentPlan: [
              'Metformin 500mg (2x daily)',
              'Low glycemic index diet',
              '30 min cardio (daily)',
            ],
            hasAttachments: true,
          ),
        ],
      ),
    );
  }
}
