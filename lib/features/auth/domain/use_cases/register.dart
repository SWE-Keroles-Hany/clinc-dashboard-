// domain/usecases/register_usecase.dart
import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/repo/auth_repo.dart';
import 'package:clinc_dashboard/features/auth/domain/entities/doctor_entity.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call({required DoctorEntity doctor}) async {
    try {
      return await repository.register(doctor: doctor);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
