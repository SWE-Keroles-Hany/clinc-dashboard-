import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/appointments_tab/data/repo/appointment_repo.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';

class GetAppointmentsUseCase {
  final AppointmentRepository repository;

  GetAppointmentsUseCase(this.repository);

  Future<Either<Failure, List<AppointmentEntity>>> call({
    int? status,
    String? selectedDate,
  }) async {
    try {
      return await repository.getAppointments(
        selectedDate: selectedDate,
        status: status,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
