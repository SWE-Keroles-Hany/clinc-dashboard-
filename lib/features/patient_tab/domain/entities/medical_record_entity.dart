class MedicalRecordEntity {
  final String patientId;
  final String diagnosis;
  final String treatmentPlan;

  const MedicalRecordEntity({
    required this.patientId,
    required this.diagnosis,
    required this.treatmentPlan,
  });
}
