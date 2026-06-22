import 'dart:io';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/data/repo/patient_repo.dart';
import 'package:dartz/dartz.dart';

class AddMedicalRecordUseCase {
  final PatientRepository repository;

  AddMedicalRecordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required String patientId,
    required String diagnosis,
    required String treatmentPlan,
    File? prescriptions,
  }) async {
    try {
      return await repository.addMedicalRecord(
        patientId: patientId,
        diagnosis: diagnosis,
        treatmentPlan: treatmentPlan,
        prescriptions: prescriptions,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
