
import 'package:flutter/material.dart';
import 'package:tarek_agro/locale/app_localization.dart';

class HomePage extends StatelessWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalization locale = AppLocalization.of(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Row(mainAxisAlignment:MainAxisAlignment.center,children: [Text(locale.translate("home") ?? "")],),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: Column(
        children: [],
      ),
    ));
  }

}