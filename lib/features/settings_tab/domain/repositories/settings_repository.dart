import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

abstract class SettingsRepository {
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, void>> saveLanguage(String languageCode);
  Future<Either<Failure, DoctorModel>> getProfile();
  Future<Either<Failure, void>> updateProfile({required DoctorModel doctor});
  Future<Either<Failure, void>> updateProfileImage({String? profileImagePath});
}
