import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class SetScheduleUseCase {
  final SettingsRepository repository;

  SetScheduleUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required List<ScheduleModel> schedules,
  }) async {
    return await repository.setSchedule(schedules: schedules);
  }
}
