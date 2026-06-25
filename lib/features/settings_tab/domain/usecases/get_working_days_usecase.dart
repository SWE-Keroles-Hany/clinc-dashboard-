import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class GetWorkingDaysUseCase {
  final SettingsRepository repository;

  GetWorkingDaysUseCase(this.repository);

  // Future<Either<Failure, List<ScheduleModel>>> call({
  //   required int doctorId,
  // }) async {
  //   return await repository.getWorkingDays(doctorId: doctorId);
  // }
}
