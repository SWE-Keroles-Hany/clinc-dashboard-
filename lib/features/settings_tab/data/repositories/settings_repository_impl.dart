import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_local_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl({required this.localDataSource});

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
}
