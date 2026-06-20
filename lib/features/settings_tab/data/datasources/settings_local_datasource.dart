import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<String> getLanguage();
  Future<void> saveLanguage(String languageCode);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _languageKey = 'language_code';

  @override
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    //! Default to 'en' if not stored
    return prefs.getString(_languageKey) ?? 'en';
  }

  @override
  Future<void> saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }
}
