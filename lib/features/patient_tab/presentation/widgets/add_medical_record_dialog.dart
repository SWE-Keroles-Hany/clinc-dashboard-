import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/custom_text_field.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/dialog_footer.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/dialog_header.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/upload_area.dart';
import 'package:flutter/material.dart';

class AddMedicalRecordDialog extends StatelessWidget {
  const AddMedicalRecordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: 600, // Fixed width for desktop/tablet layout
        decoration: BoxDecoration(
          color: ColorManager.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DialogHeader(
              title: 'Add New Medical Record',
              onClose: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: CustomTextField(
                          label: 'DIAGNOSIS TITLE',
                          hint: 'e.g. Hypertension',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          label: 'RECORD DATE',
                          hint: 'mm/dd/yyyy',
                          suffixIcon: Icons.calendar_today_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'DIAGNOSIS DETAILS',
                    hint: 'Provide detailed clinical observations...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(
                    label: 'TREATMENT PLAN',
                    hint: 'Medications, procedures, follow-ups...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  const UploadArea(),
                  const SizedBox(height: 32),
                  DialogFooter(
                    onCancel: () => Navigator.of(context).pop(),
                    onSave: () {
                      // Add save logic here
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
