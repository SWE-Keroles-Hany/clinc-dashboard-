import 'dart:io';
import 'dart:typed_data';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PatientRepository {
  Future<Either<Failure, List<PatientEntity>>> getPatients({
    String? name,
    int? pageIndex,
  });
  Future<Either<Failure, int>> getTotalPatientsNumber({required String? name});
  Future<Either<Failure, void>> addMedicalRecord({
    required int patientId,
    required String diagnosis,
    required String treatmentPlan,
    Uint8List? prescriptionBytes,
    String? fileName,
  });
}
