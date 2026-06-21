import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/appointments_tab/data/data_source/appointment_remote_data_source.dart';
import 'package:clinc_dashboard/features/appointments_tab/data/repo/appointment_repo.dart';
import 'package:clinc_dashboard/features/dashboard_tab/data/mapper/appointment_model_mapper.dart';
import 'package:clinc_dashboard/features/dashboard_tab/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final AppointmentRemoteDataSource remoteDataSource;

  AppointmentRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments({
    int? status,
  }) async {
    try {
      final appointments = await remoteDataSource.getAppointments(
        status: status,
      );
      return Right(appointments.map((model) => model.toEntity).toList());
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAppointmentType({
    required int appointmentId,
    required int newStatus,
  }) async {
    try {
      await remoteDataSource.updateAppointmentType(
        appointmentId: appointmentId,
        newStatus: newStatus,
      );
      return const Right(null);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
