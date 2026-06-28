import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';
import 'package:clinc_dashboard/features/settings_tab/data/models/schedule_model.dart';

abstract class SettingsState {
  final String languageCode;
  final DoctorModel? doctor;
  final List<ScheduleModel>? schedules;
  final bool isEditingSchedule;

  const SettingsState({
    required this.languageCode,
    this.doctor,
    this.schedules,
    this.isEditingSchedule = false,
  });
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsLoading extends SettingsState {
  const SettingsLoading({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError(
    this.message, {
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsProfileLoading extends SettingsState {
  const SettingsProfileLoading({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsProfileLoaded extends SettingsState {
  const SettingsProfileLoaded({
    required super.languageCode,
    required DoctorModel doctor,
    super.schedules,
    super.isEditingSchedule,
  }) : super(doctor: doctor);
}

class SettingsProfileUpdating extends SettingsState {
  const SettingsProfileUpdating({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsProfileUpdated extends SettingsState {
  const SettingsProfileUpdated({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsProfileError extends SettingsState {
  final String message;

  const SettingsProfileError(
    this.message, {
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsScheduleLoading extends SettingsState {
  const SettingsScheduleLoading({
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}

class SettingsScheduleLoaded extends SettingsState {
  const SettingsScheduleLoaded({
    required super.languageCode,
    super.doctor,
    required List<ScheduleModel> schedules,
    super.isEditingSchedule,
  }) : super(schedules: schedules);
}

class UpdateProfileImageLoading extends SettingsState {
  const UpdateProfileImageLoading({
    required super.languageCode,
    super.doctor,
    required List<ScheduleModel> schedules,
    super.isEditingSchedule,
  }) : super(schedules: schedules);
}

class UpdateProfileImageSuccessfully extends SettingsState {
  const UpdateProfileImageSuccessfully({
    required super.languageCode,
    super.doctor,
    required List<ScheduleModel> schedules,
    super.isEditingSchedule,
  }) : super(schedules: schedules);
}

class UpdateProfileImageError extends SettingsState {
  final String message;
  const UpdateProfileImageError({
    required super.languageCode,
    super.doctor,
    required List<ScheduleModel> schedules,
    super.isEditingSchedule,
    required this.message,
  }) : super(schedules: schedules);
}

// class SettingsScheduleUpdated extends SettingsState {
//   const SettingsScheduleUpdated({
//     required super.languageCode,
//     super.doctor,
//     required List<ScheduleModel> schedules,
//     super.isEditingSchedule,
//   }) : super(schedules: schedules);
// }

class SettingsScheduleError extends SettingsState {
  final String message;
  const SettingsScheduleError(
    this.message, {
    required super.languageCode,
    super.doctor,
    super.schedules,
    super.isEditingSchedule,
  });
}
