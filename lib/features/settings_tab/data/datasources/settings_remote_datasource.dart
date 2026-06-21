import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:flutter/foundation.dart';

abstract class SettingsRemoteDataSource {
  Future<DoctorModel> getProfile();

  Future<void> updateProfile({required DoctorModel doctor});

  Future<void> updateProfileImage({String? profileImagePath});
}
