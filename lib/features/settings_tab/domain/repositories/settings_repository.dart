import 'dart:typed_data';

import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepository {
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, void>> saveLanguage(String languageCode);
  Future<Either<Failure, DoctorModel>> getProfile();
  Future<Either<Failure, void>> updateProfile({required DoctorModel doctor});
  Future<Either<Failure, void>> updateProfileImage({
    Uint8List? prescriptionBytes,
    String? fileName,
  });
  Future<Either<Failure, void>> setSchedule({
    required List<ScheduleModel> schedules,
  });
}
