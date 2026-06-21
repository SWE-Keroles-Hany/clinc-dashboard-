import 'package:clinc_dashboard/features/auth/data/models/doctor_model.dart';

abstract class SettingsState {
  final String languageCode;
  final DoctorModel? doctor;

  const SettingsState({required this.languageCode, this.doctor});
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({required super.languageCode, super.doctor});
}

class SettingsLoading extends SettingsState {
  const SettingsLoading({required super.languageCode, super.doctor});
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required super.languageCode, super.doctor});
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError(this.message, {required super.languageCode, super.doctor});
}

class SettingsProfileLoading extends SettingsState {
  const SettingsProfileLoading({required super.languageCode, super.doctor});
}

class SettingsProfileLoaded extends SettingsState {
  const SettingsProfileLoaded({
    required super.languageCode,
    required DoctorModel doctor,
  }) : super(doctor: doctor);
}

class SettingsProfileUpdating extends SettingsState {
  const SettingsProfileUpdating({required super.languageCode, super.doctor});
}

class SettingsProfileUpdated extends SettingsState {
  const SettingsProfileUpdated({required super.languageCode, super.doctor});
}

class SettingsProfileError extends SettingsState {
  final String message;

  const SettingsProfileError(
    this.message, {
    required super.languageCode,
    super.doctor,
  });
}
