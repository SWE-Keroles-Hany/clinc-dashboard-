import 'dart:typed_data';

import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';

abstract class SettingsRemoteDataSource {
  Future<DoctorModel> getProfile();

  Future<void> updateProfile({required DoctorModel doctor});

  Future<void> updateProfileImage({
    Uint8List? prescriptionBytes,
    String? fileName,
  });

  Future<void> setSchedule({required List<ScheduleModel> schedules});

  // Future<List<ScheduleModel>> getWorkingDays({required int doctorId});
}
