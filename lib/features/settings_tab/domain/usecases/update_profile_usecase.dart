import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateProfileUseCase {
  final SettingsRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required DoctorModel doctor,
  }) async {
    try {
      return await repository.updateProfile(
        doctor: doctor,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
