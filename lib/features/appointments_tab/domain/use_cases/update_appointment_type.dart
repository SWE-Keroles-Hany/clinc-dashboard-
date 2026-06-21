import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/appointments_tab/data/repo/appointment_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateAppointmentTypeUseCase {
  final AppointmentRepository repository;

  UpdateAppointmentTypeUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int appointmentId,
    required int newStatus,
  }) async {
    try {
      return await repository.updateAppointmentType(
        appointmentId: appointmentId,
        newStatus: newStatus,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
