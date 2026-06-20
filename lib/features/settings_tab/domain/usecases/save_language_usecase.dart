import 'package:clinc_dashboard/core/error/failure.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/repositories/settings_repository.dart';
import 'package:dartz/dartz.dart';

class SaveLanguageUseCase {
  final SettingsRepository repository;

  SaveLanguageUseCase(this.repository);

  Future<Either<Failure, void>> call(String languageCode) async {
    return await repository.saveLanguage(languageCode);
  }
}
