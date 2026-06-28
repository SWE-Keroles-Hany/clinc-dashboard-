import 'dart:io';
import 'dart:typed_data';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/data/repo/patient_repo.dart';
import 'package:dartz/dartz.dart';

class AddMedicalRecordUseCase {
  final PatientRepository repository;

  AddMedicalRecordUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int patientId,
    required String diagnosis,
    required String treatmentPlan,
    Uint8List? prescriptionBytes,
    String? fileName,
  }) async {
    try {
      return await repository.addMedicalRecord(
        patientId: patientId,
        diagnosis: diagnosis,
        treatmentPlan: treatmentPlan,
        fileName: fileName,
        prescriptionBytes: prescriptionBytes,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
