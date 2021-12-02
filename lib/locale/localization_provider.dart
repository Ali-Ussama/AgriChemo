import 'package:tarek_agro/singleton/settings_session.dart';
import 'package:tarek_agro/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  Locale? _appLocale = const Locale('en');

  Locale? get appLocal => _appLocale ?? const Locale("en");

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(Constants.languageCode) == null) {
      _appLocale = const Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString(Constants.languageCode) ?? "en");
    notifyListeners();
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == const Locale("ar")) {
      _appLocale = const Locale("ar");
      await prefs.setString(Constants.languageCode, 'ar');
      await prefs.setString(Constants.countryCode, '');
    } else {
      _appLocale = const Locale("en");
      await prefs.setString(Constants.languageCode, 'en');
      await prefs.setString(Constants.countryCode, 'US');
    }
    await DataSettingsSession.instance().loadLanguage();
    notifyListeners();
  }
}
