import 'package:clinc_dashboard/core/theme/color_manger.dart';
import 'package:flutter/material.dart';

import 'widgets/patient_screen_header.dart';
import 'widgets/medical_history_section.dart';

class PatientProfileScreen extends StatelessWidget {
  static const String routeName = 'PatientProfileScreen';

  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PatientScreenHeader(
              name: "Sarah Johnson",
              age: 48,
              gender: "Female",
              phoneNumber: "+1 (555) 012-3456",
            ),
            const SizedBox(height: 32),
            MedicalHistorySection(),
          ],
        ),
      ),
    );
  }
}
