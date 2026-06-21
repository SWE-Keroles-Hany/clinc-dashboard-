import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class UpdateProfileImageUseCase {
  final SettingsRepository repository;

  UpdateProfileImageUseCase(this.repository);

  Future<Either<Failure, void>> call({
    String? profileImagePath,
    Uint8List? profileImageBytes,
    String? profileImageName,
  }) async {
    try {
      return await repository.updateProfileImage(
        profileImagePath: profileImagePath,
      );
    } on Failure catch (error) {
      return Left(Failure(message: error.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
