import 'dart:io';

class MedicalRecordModel {
  final String patientId;
  final String diagnosis;
  final String treatmentPlan;
  final File? prescriptions;

  MedicalRecordModel({
    required this.patientId,
    required this.diagnosis,
    required this.treatmentPlan,
    this.prescriptions,
  });

  Map<String, dynamic> toJson() {
    return {
      'PatientId': patientId,
      'Diagnosis': diagnosis,
      'TreatmentPlan': treatmentPlan,
    };
  }
}
