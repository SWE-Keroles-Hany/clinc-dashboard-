import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<int>>> getDashboardStatus();

  Future<Either<Failure, List<AppointmentEntity>>> getTodayAppointments({
    required bool todayOnly,
  });
}
