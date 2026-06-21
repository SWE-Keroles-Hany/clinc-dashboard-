import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_local_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_remote_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final languageCode = await localDataSource.getLanguage();
      return Right(languageCode);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveLanguage(String languageCode) async {
    try {
      await localDataSource.saveLanguage(languageCode);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorModel>> getProfile() async {
    try {
      final doctor = await remoteDataSource.getProfile();
      return Right(doctor);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile({
    required DoctorModel doctor,
  }) async {
    try {
      await remoteDataSource.updateProfile(doctor: doctor);
      return const Right(null);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfileImage({
    String? profileImagePath,
    Uint8List? profileImageBytes,
    String? profileImageName,
  }) async {
    try {
      await remoteDataSource.updateProfileImage(
        profileImagePath: profileImagePath,
      );
      return const Right(null);
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
