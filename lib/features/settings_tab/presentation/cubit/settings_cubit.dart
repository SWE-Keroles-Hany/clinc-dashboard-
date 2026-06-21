import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_profile_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/save_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/update_profile_image_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/update_profile_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  SettingsCubit({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.updateProfileImageUseCase,
  }) : super(const SettingsInitial(languageCode: 'en'));

  Future<void> loadLanguage() async {
    emit(SettingsLoading(languageCode: state.languageCode, doctor: state.doctor));
    final result = await getLanguageUseCase();
    result.fold(
      (failure) => emit(
        SettingsError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
        ),
      ),
      (langCode) => emit(SettingsLoaded(languageCode: langCode, doctor: state.doctor)),
    );
  }

  Future<void> changeLanguage(String langCode) async {
    emit(SettingsLoading(languageCode: state.languageCode, doctor: state.doctor));
    final result = await saveLanguageUseCase(langCode);
    result.fold(
      (failure) => emit(
        SettingsError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
        ),
      ),
      (_) => emit(SettingsLoaded(languageCode: langCode, doctor: state.doctor)),
    );
  }

  Future<void> getProfile() async {
    emit(
      SettingsProfileLoading(
        languageCode: state.languageCode,
        doctor: state.doctor,
      ),
    );

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(
        SettingsProfileError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
        ),
      ),
      (doctor) => emit(
        SettingsProfileLoaded(
          languageCode: state.languageCode,
          doctor: doctor,
        ),
      ),
    );
  }

  Future<void> updateProfile({
    required DoctorModel doctor,
    String? profileImagePath,
    Uint8List? profileImageBytes,
    String? profileImageName,
  }) async {
    emit(
      SettingsProfileUpdating(
        languageCode: state.languageCode,
        doctor: state.doctor,
      ),
    );

    final result = await updateProfileUseCase(
      doctor: doctor,
    );

    await result.fold(
      (failure) async => emit(
        SettingsProfileError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
        ),
      ),
      (_) async {
        final hasImage =
            (profileImageBytes != null && profileImageBytes.isNotEmpty) ||
            (profileImagePath != null && profileImagePath.isNotEmpty);
        if (hasImage) {
          final imageResult = await updateProfileImageUseCase(
            profileImagePath: profileImagePath,
            profileImageBytes: profileImageBytes,
            profileImageName: profileImageName,
          );

          var imageUploadFailed = false;
          imageResult.fold(
            (failure) {
              imageUploadFailed = true;
              emit(
                SettingsProfileError(
                  failure.message,
                  languageCode: state.languageCode,
                  doctor: state.doctor,
                ),
              );
            },
            (_) {},
          );
          if (imageUploadFailed) {
            return;
          }
        }

        emit(
          SettingsProfileUpdated(
            languageCode: state.languageCode,
            doctor: doctor,
          ),
        );
        await getProfile();
      },
    );
  }
}
