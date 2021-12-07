import 'package:flutter/material.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/locale/localization_provider.dart';
import 'package:tarek_agro/utils/enums.dart';

class SettingsProvider extends ChangeNotifier {
  LanguageTypes selectedLanguage = LanguageTypes.english;


  void setSelectedLanguage(LanguageTypes language) {
    selectedLanguage = language;
  }

  Future<void> changeLanguage(AppLocalization local, LocalProvider locProvider) async {
    if (isEnglishSelected()) {
      locProvider.changeLanguage(const Locale('en'));
    } else {
      locProvider.changeLanguage(const Locale('ar'));
    }
    notifyListeners();
  }

  bool isEnglishSelected() => selectedLanguage.value == LanguageTypes.english.value;
}
