import 'package:tarek_agro/utils/Constants.dart';
import 'package:tarek_agro/utils/preference_manger.dart';

class DataSettingsSession {
  static final DataSettingsSession _instance = DataSettingsSession._internal();
  String _languageCode = 'en';

  String get languageCode => _languageCode;

  Future<void> loadLanguage() async {
    await PreferenceManager.getInstance()
        ?.getString(Constants.languageCode)
        .then((value) {
      if (value == null || value.isEmpty) {
        PreferenceManager.getInstance()
            ?.saveString(Constants.languageCode, 'en');
        _languageCode = 'en';
      } else {
        _languageCode = value;
      }
    });
  }

  void changeLanguageCode(String lang) {
    _languageCode = lang;
  }

  static DataSettingsSession instance() {
    return _instance;
  }

  DataSettingsSession._internal();

  void resetCacheData() {}
}
