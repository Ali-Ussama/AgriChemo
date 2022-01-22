import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/units_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/customWidgets/custom_dialogs.dart';

class UnitsPage extends StatefulWidget {
  const UnitsPage({Key? key}) : super(key: key);

  @override
  State<UnitsPage> createState() => _UnitsPageState();
}

class _UnitsPageState extends State<UnitsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var unitProvider = Provider.of<UnitsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.translate('units') ?? "Units",
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
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: unitProvider.getUnits(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                          child: Text("خطأ\n ${snapshot.error?.toString()}")),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }

                  return Expanded(child: UnitsList(docs: snapshot.data?.docs));
                }),
            Stack(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 48.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          showAddOrEditDialog(context, unitProvider);
                        },
                        backgroundColor: Colors.blue.shade900,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UnitsList extends StatelessWidget {
  List<QueryDocumentSnapshot>? docs;

  UnitsList({Key? key, this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unitProvider = Provider.of<UnitsProvider>(context);
    return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: docs != null && docs!.isNotEmpty
            ? docs!.map((DocumentSnapshot document) {
                log('${document.data()}');
                var unit = unitProvider
                    .getUnitFromJson(document.data() as Map<String, dynamic>?);
                return Card(
                  margin: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
                  color: ColorsUtils.alphaBlue,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                top: 16.0,
                                bottom: 16.0),
                            child: Text(
                              unit?.name ?? '',
                              style: const TextStyle(fontSize: 16.0),
                              textAlign: TextAlign.start,
                            )),
                      ),
                      IconButton(
                          onPressed: () {
                            showAddOrEditDialog(context, unitProvider,
                                unit: unit);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.black,
                          ))
                    ],
                  ),
                );
              }).toList()
            : []);
  }
}

void showAddOrEditDialog(BuildContext context, UnitsProvider unitsProvider,
    {Unit? unit}) async {
  var result =
      await showAddEditUnit(context, unitName: unit?.name) as List<String>?;
  if (result != null && result.isNotEmpty) {
    if (unit == null) {
      unitsProvider.addNewUnit(result[0]);
    } else {
      unit.setName(result[0]);
      unitsProvider.updateUnit(unit);
    }
  }
}
