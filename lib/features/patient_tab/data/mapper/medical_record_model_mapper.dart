import 'package:clinc_dashboard/features/patient_tab/data/models/medical_record_model.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/medical_record_entity.dart';

extension MedicalRecordModelMapper on MedicalRecordModel {
  MedicalRecordEntity get toEntity => MedicalRecordEntity(
    patientId: patientId,
    diagnosis: diagnosis,
    treatmentPlan: treatmentPlan,
  );
}
