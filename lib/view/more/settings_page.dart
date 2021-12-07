import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/locale/localization_provider.dart';
import 'package:tarek_agro/providers/settings/settings_provider.dart';
import 'package:tarek_agro/utils/enums.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.translate('settings') ?? "Settings",
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 24.0, bottom: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [LanguageWidget()],
        ),
      ),
    );
  }
}

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({Key? key}) : super(key: key);

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  var isLanguageExpanded = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var localeProvider = Provider.of<LocalProvider>(context);

    return InkWell(
      onTap: () {
        handleLanguageExpanding();
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 8, right: 24.0, left: 24.0),
              child: SvgPicture.asset("images/ic_language.svg"),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(locale.translate("language") ?? "Language",
                                style: TextStyle(color: Colors.grey.shade600)),
                            Text(
                              locale.translate("choose_your_language") ??
                                  "Choose your language",
                              style: TextStyle(color: Colors.grey.shade600),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            handleLanguageExpanding();
                          },
                          icon: Icon(isLanguageExpanded
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down))
                    ],
                  ),
                  Visibility(
                    visible: isLanguageExpanded,
                    child: InkWell(
                      onTap: () {
                        settingsProvider.setSelectedLanguage(LanguageTypes.english);
                        settingsProvider.changeLanguage(locale,localeProvider);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        margin: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    locale.translate("english") ?? "English")),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Visibility(
                                visible: settingsProvider.isEnglishSelected(),
                                child: const Icon(Icons.done),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                      visible: isLanguageExpanded,
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            color: Colors.grey,
                            margin: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 16.0),
                            height: 1,
                          ))
                        ],
                      )),
                  Visibility(
                    visible: isLanguageExpanded,
                    child: InkWell(
                      onTap: () {
                        settingsProvider
                            .setSelectedLanguage(LanguageTypes.arabic);
                        settingsProvider.changeLanguage(locale,localeProvider);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        margin: const EdgeInsets.only(top: 24.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                                    locale.translate("arabic") ?? "Arabic")),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Visibility(
                                  visible:
                                      !settingsProvider.isEnglishSelected(),
                                  child: const Icon(Icons.done)),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void handleLanguageExpanding() {
    setState(() {
      isLanguageExpanded = !isLanguageExpanded;
    });
  }
}
