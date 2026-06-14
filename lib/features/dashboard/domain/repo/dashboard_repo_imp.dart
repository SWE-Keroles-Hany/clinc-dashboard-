import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/dashboard/data/data_source/dashboard_remote_data_source.dart';
import 'package:clinc_dashboard/features/dashboard/data/mapper/appointment_model_mapper.dart';
import 'package:clinc_dashboard/features/dashboard/data/repo/dashboard_repo.dart';
import 'package:clinc_dashboard/features/dashboard/domain/entities/appointment_entity.dart';
import 'package:dartz/dartz.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<int>>> getDashboardStatus() async {
    try {
      final stats = await remoteDataSource.getDashboardStatus();
      return Right(stats);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getTodayAppointments({
    required bool todayOnly,
  }) async {
    try {
      final appointments = await remoteDataSource.getTodayAppointments(
        todayOnly: todayOnly,
      );
      return Right(appointments.map((model) => model.toEntity).toList());
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
