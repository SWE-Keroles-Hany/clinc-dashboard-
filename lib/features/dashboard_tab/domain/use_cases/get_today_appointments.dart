import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/dashboard_tab/data/repo/dashboard_repo.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';

class GetTodayAppointmentsUseCase {
  final DashboardRepository repository;

  GetTodayAppointmentsUseCase(this.repository);

  Future<Either<Failure, List<AppointmentEntity>>> call({
    required bool todayOnly,
  }) async {
    try {
      return await repository.getTodayAppointments(todayOnly: todayOnly);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
