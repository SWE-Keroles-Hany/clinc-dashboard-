import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AppointmentRepository {
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments({
    int? status,
    String? selectedDate,

  });

  Future<Either<Failure, void>> updateAppointmentType({
    required int appointmentId,
    required int newStatus,
  });
}
