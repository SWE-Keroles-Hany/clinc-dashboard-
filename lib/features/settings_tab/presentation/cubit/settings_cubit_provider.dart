import 'package:clinc_dashboard/features/settings_tab/data/datasources/settings_local_datasource.dart';
import 'package:clinc_dashboard/features/settings_tab/data/repositories/settings_repository_impl.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/save_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_cubit.dart';

SettingsCubit createSettingsCubit() {
  final localDataSource = SettingsLocalDataSourceImpl();
  final repository = SettingsRepositoryImpl(localDataSource: localDataSource);

  return SettingsCubit(
    getLanguageUseCase: GetLanguageUseCase(repository),
    saveLanguageUseCase: SaveLanguageUseCase(repository),
  );
}
