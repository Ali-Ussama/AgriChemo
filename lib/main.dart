import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/locale/localization_provider.dart';
import 'package:tarek_agro/singleton/settings_session.dart';
import 'package:tarek_agro/utils/colors_utils.dart';

import 'locale/app_localization.dart';

void main() {
  runApp(MultiProvider(providers: [], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    var localeProvider = Provider.of<LocalProvider>(context, listen: false);
    localeProvider.fetchLocale();
  }

  @override
  Widget build(BuildContext context) {
    var localeProvider = Provider.of<LocalProvider>(context);
    DataSettingsSession.instance().loadLanguage();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: ColorsUtils.primary, // navigation bar color
      statusBarColor: ColorsUtils.primary, //
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark, // status bar color
    ));

    return MaterialApp(
      locale: localeProvider.appLocal,
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', ''),
      ],
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: ColorsUtils.primary,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: ColorsUtils.secondary)),
      home: Container(),
    );
  }
}
