import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class GetLanguageUseCase {
  final SettingsRepository repository;

  GetLanguageUseCase(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.getLanguage();
  }
}
