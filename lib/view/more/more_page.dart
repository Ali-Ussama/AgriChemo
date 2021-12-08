import 'package:flutter/material.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/view/more/settings_page.dart';
import 'package:tarek_agro/view/more/units_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(
                bottom: 48.0, top: 56.0, left: 24.0, right: 24.0),
            child: Text(
              locale.translate('more') ?? "More",
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: TextButton(
                  onPressed: () {
                    navigateToSettingsPage(context);
                  },
                  child: Text(locale.translate("settings") ?? "Settings"),
                  style: TextButton.styleFrom(
                      primary: Colors.black54,
                      textStyle: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: TextButton(
                  onPressed: () {
                    navigateToUnitsPage(context);
                  },
                  child: Text(locale.translate("units") ?? "Units"),
                  style: TextButton.styleFrom(
                      primary: Colors.black54,
                      textStyle: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void navigateToSettingsPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }

  void navigateToUnitsPage(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UnitsPage()));
  }
}
