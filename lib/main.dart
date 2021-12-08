import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/firebase/firebase_crashlytics.dart';
import 'package:tarek_agro/locale/localization_provider.dart';
import 'package:tarek_agro/providers/authenticate/authentication_provider.dart';
import 'package:tarek_agro/providers/clients_and_suppliers/clients_provider.dart';
import 'package:tarek_agro/providers/clients_and_suppliers/suppliers_provider.dart';
import 'package:tarek_agro/providers/settings/settings_provider.dart';
import 'package:tarek_agro/providers/units_provider.dart';
import 'package:tarek_agro/singleton/settings_session.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/home/home_page.dart';
import 'package:tarek_agro/view/login/login_page.dart';

import 'locale/app_localization.dart';

void main() async{
  await FirebaseCrashes.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      lazy: false,
    ),
    ChangeNotifierProvider(
      create: (context) => LocalProvider(),
      lazy: false,
    ),
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      lazy: false,
    ),
    ChangeNotifierProvider(
      create: (context) => UnitsProvider(),
      lazy: false,
    ),
    ChangeNotifierProvider(
      create: (context) => ClientsProvider(),
      lazy: false,
    ),
    ChangeNotifierProvider(
      create: (context) => SuppliersProvider(),
      lazy: false,
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isUserLoggedIn = false;

  @override
  void initState() {
    super.initState();
    try{
      FirebaseCrashes.initialize();
    }on Exception catch (e){
      print(e);
    }
    var localeProvider = Provider.of<LocalProvider>(context, listen: false);
    localeProvider.fetchLocale();
    var loginProvider = Provider.of<AuthenticationProvider>(context,listen: false);
    isUserLoggedIn = loginProvider.isUserLoggedInBefore();
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
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: ColorsUtils.secondary),
        indicatorColor: ColorsUtils.secondary,
        backgroundColor: Colors.white,
        disabledColor: ColorsUtils.secondaryAlpha
      ),
      home: isUserLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
