import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_profile_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/save_language_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/update_profile_image_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/update_profile_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/set_schedule_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/domain/usecases/get_working_days_usecase.dart';
import 'package:clinc_dashboard/features/settings_tab/presentation/cubit/settings_states.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetLanguageUseCase getLanguageUseCase;
  final SaveLanguageUseCase saveLanguageUseCase;
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateProfileImageUseCase updateProfileImageUseCase;
  final SetScheduleUseCase setScheduleUseCase;
  // final GetWorkingDaysUseCase getWorkingDaysUseCase;

  SettingsCubit({
    required this.getLanguageUseCase,
    required this.saveLanguageUseCase,
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.updateProfileImageUseCase,
    required this.setScheduleUseCase,
    // required this.getWorkingDaysUseCase,
  }) : super(const SettingsInitial(languageCode: 'en'));

  Future<void> loadLanguage() async {
    emit(
      SettingsLoading(
        languageCode: state.languageCode,
        doctor: state.doctor,
        schedules: state.schedules,
        isEditingSchedule: state.isEditingSchedule,
      ),
    );
    final result = await getLanguageUseCase();
    result.fold(
      (failure) => emit(
        SettingsError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
        ),
      ),
      (langCode) => emit(
        SettingsLoaded(
          languageCode: langCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
        ),
      ),
    );
  }

  Future<void> changeLanguage(String langCode) async {
    emit(
      SettingsLoading(
        languageCode: state.languageCode,
        doctor: state.doctor,
        schedules: state.schedules,
        isEditingSchedule: state.isEditingSchedule,
      ),
    );
    final result = await saveLanguageUseCase(langCode);
    result.fold(
      (failure) => emit(
        SettingsError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
        ),
      ),
      (_) => emit(
        SettingsLoaded(
          languageCode: langCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
        ),
      ),
    );
  }

  Future<void> getProfile() async {
    emit(
      SettingsProfileLoading(
        languageCode: state.languageCode,
        doctor: state.doctor,
        schedules: state.schedules,
        isEditingSchedule: state.isEditingSchedule,
      ),
    );

    final result = await getProfileUseCase();

    result.fold(
      (failure) => emit(
        SettingsProfileError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
        ),
      ),
      (doctor) {
        emit(
          SettingsProfileLoaded(
            languageCode: state.languageCode,
            doctor: doctor,
            schedules: state.schedules,
            isEditingSchedule: state.isEditingSchedule,
          ),
        );
        // Fetch working days after profile is loaded
        // getWorkingDays();
      },
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
        schedules: state.schedules,
        isEditingSchedule: state.isEditingSchedule,
      ),
    );

    final result = await updateProfileUseCase(doctor: doctor);

    await result.fold(
      (failure) async => emit(
        SettingsProfileError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
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
          imageResult.fold((failure) {
            imageUploadFailed = true;
            emit(
              SettingsProfileError(
                failure.message,
                languageCode: state.languageCode,
                doctor: state.doctor,
                schedules: state.schedules,
                isEditingSchedule: state.isEditingSchedule,
              ),
            );
          }, (_) {});
          if (imageUploadFailed) {
            return;
          }
        }

        emit(
          SettingsProfileUpdated(
            languageCode: state.languageCode,
            doctor: doctor,
            schedules: state.schedules,
            isEditingSchedule: state.isEditingSchedule,
          ),
        );
        await getProfile();
      },
    );
  }

  // Future<void> getWorkingDays() async {
  //   final doctorId = state.doctor?.id;
  //   if (doctorId == null) return;

  //   emit(
  //     SettingsScheduleLoading(
  //       languageCode: state.languageCode,
  //       doctor: state.doctor,
  //       schedules: state.schedules,
  //       isEditingSchedule: state.isEditingSchedule,
  //     ),
  //   );

  //   // final result = await getWorkingDaysUseCase(doctorId: 11);

  //   result.fold(
  //     (failure) => emit(
  //       SettingsScheduleError(
  //         failure.message,
  //         languageCode: state.languageCode,
  //         doctor: state.doctor,
  //         schedules: state.schedules,
  //         isEditingSchedule: state.isEditingSchedule,
  //       ),
  //     ),
  //     (schedules) => emit(
  //       SettingsScheduleLoaded(
  //         languageCode: state.languageCode,
  //         doctor: state.doctor,
  //         schedules: schedules,
  //         isEditingSchedule: state.isEditingSchedule,
  //       ),
  //     ),
  //   );
  // }

  Future<void> setSchedule({required List<ScheduleModel> schedules}) async {
    emit(
      SettingsScheduleLoading(
        languageCode: state.languageCode,
        doctor: state.doctor,
        schedules: state.schedules,
        isEditingSchedule: state.isEditingSchedule,
      ),
    );

    final result = await setScheduleUseCase(schedules: schedules);

    result.fold(
      (failure) => emit(
        SettingsScheduleError(
          failure.message,
          languageCode: state.languageCode,
          doctor: state.doctor,
          schedules: state.schedules,
          isEditingSchedule: state.isEditingSchedule,
        ),
      ),
      (_) => emit(
        SettingsScheduleLoaded(
          languageCode: state.languageCode,
          doctor: state.doctor,
          schedules: schedules,
          isEditingSchedule: false,
        ),
      ),
    );
  }

  // void toggleEditSchedule() {
  //   emit(
  //     SettingsLoaded(
  //       languageCode: state.languageCode,
  //       doctor: state.doctor,
  //       schedules: state.schedules,
  //       isEditingSchedule: !state.isEditingSchedule,
  //     ),
  //   );
  // }
}
