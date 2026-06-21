import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/patient_profile_screen.dart';
import 'package:clinc_dashboard/features/patient_tab/presentation/widgets/patient_row_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class PatientList extends StatelessWidget {
  const PatientList({super.key, required this.filteredPatients});

  final List<PatientEntity> filteredPatients;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredPatients.length,
      separatorBuilder: (context, _) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final patient = filteredPatients[index];
        return PatientRowInfo(
          patient: patient,
          onViewPressed: () {
            Navigator.pushNamed(context, PatientProfileScreen.routeName);
            //! go to user profile (data - medical history) ;
          },
        );
      },
    );
  }
}
