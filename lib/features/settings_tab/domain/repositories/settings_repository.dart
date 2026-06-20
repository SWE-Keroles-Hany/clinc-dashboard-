import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class SettingsRepository {
  Future<Either<Failure, String>> getLanguage();
  Future<Either<Failure, void>> saveLanguage(String languageCode);
}
