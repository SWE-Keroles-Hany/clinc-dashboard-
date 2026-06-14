import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/data/repo/patient_repo.dart';
import 'package:clinc_dashboard/features/patient_tab/domain/entities/patient_entity.dart';
import 'package:dartz/dartz.dart';

class GetPatientsUseCase {
  final PatientRepository repository;

  GetPatientsUseCase(this.repository);

  Future<Either<Failure, List<PatientEntity>>> call() async {
    try {
      return await repository.getPatients();
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
