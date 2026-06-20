import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/save_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;

  SettingsCubit({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
  }) : super(const SettingsInitial(languageCode: 'en'));

  Future<void> loadLanguage() async {
    emit(SettingsLoading(languageCode: state.languageCode));
    final result = await getLanguageUseCase();
    result.fold(
      (failure) => emit(
        SettingsError(failure.message, languageCode: state.languageCode),
      ),
      (langCode) => emit(SettingsLoaded(languageCode: langCode)),
    );
  }

  Future<void> changeLanguage(String langCode) async {
    emit(SettingsLoading(languageCode: state.languageCode));
    final result = await saveLanguageUseCase(langCode);
    result.fold(
      (failure) => emit(
        SettingsError(failure.message, languageCode: state.languageCode),
      ),
      (_) => emit(SettingsLoaded(languageCode: langCode)),
    );
  }
}
