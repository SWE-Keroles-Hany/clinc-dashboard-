abstract class SettingsState {
  final String languageCode;
  const SettingsState({required this.languageCode});
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({required super.languageCode});
}

class SettingsLoading extends SettingsState {
  const SettingsLoading({required super.languageCode});
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required super.languageCode});
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError(this.message, {required super.languageCode});
}
