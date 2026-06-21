import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/patient_tab/data/repo/patient_repo.dart';
import 'package:dartz/dartz.dart';

class GetTotalPatientsNumberUseCase {
  final PatientRepository repository;

  GetTotalPatientsNumberUseCase(this.repository);

  Future<Either<Failure, int>> call({required String? name}) async {
    try {
      return await repository.getTotalPatientsNumber(name: name);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
