import 'package:clinc_dashboard/features/patient_tab/data/models/patient_model.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';

extension PatientModelMapper on PatientModel {
  PatientEntity get toEntity => PatientEntity(
    patientId: patientId,
    fullName: fullName,
    age: age,
    gender: gender,
    phoneNumber: phoneNumber,
    lastVisitDate: lastVisitDate,
    profilePicUrl: profilePicUrl,
  );
}
