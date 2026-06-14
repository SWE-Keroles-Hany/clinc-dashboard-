import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:dartz/dartz.dart';

abstract class PatientRepository {
  Future<Either<Failure, List<PatientEntity>>> getPatients();
}
