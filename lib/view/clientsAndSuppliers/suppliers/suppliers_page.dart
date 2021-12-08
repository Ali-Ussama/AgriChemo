import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/supplier.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/clients_and_suppliers/suppliers_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/clientsAndSuppliers/suppliers/add_or_update_supplier_page.dart';

class SuppliersPage extends StatefulWidget{
  const SuppliersPage({Key? key}) : super(key: key);

  @override
  State<SuppliersPage> createState() => _SuppliersPageState();
}

class _SuppliersPageState extends State<SuppliersPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var suppliersProvider = Provider.of<SuppliersProvider>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
              top: 16.0, left: 16, right: 16, bottom: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: suppliersProvider.searchController,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                      labelText: locale.translate("search") ?? "Search",
                      labelStyle: const TextStyle(color: Colors.grey),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid))),
                  onChanged: (String? value) {
                    setState(() {
                      suppliersProvider.searchText = value ?? '';
                    });
                  },
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: suppliersProvider.getSuppliers(),
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
                      if(snapshot.data?.docs == null || snapshot.data!.docs.isEmpty){
                        return Expanded(
                          child: Center(
                              child: Text(locale.translate('no_data') ?? '')),
                        );
                      }

                      return Expanded(
                        child: SuppliersList(docs: snapshot.data?.docs),
                      );
                    }),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          navigateToAddNewSupplier(context, suppliersProvider);
                        },
                        backgroundColor: Colors.blue.shade900,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ))
      ],
    );
  }

  void navigateToAddNewSupplier(
      BuildContext context, SuppliersProvider suppliersProvider) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddOrUpdateSupplierPage()));
  }
}

class SuppliersList extends StatelessWidget {
  List<QueryDocumentSnapshot>? docs;

  SuppliersList({Key? key, this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var suppliersProvider = Provider.of<SuppliersProvider>(context);
    return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 48.0),
        children: docs != null && docs!.isNotEmpty
            ? docs!
            .where((element) => suppliersProvider.searchText.isNotEmpty
            ? element
            .get('name')
            .toString()
            .contains(suppliersProvider.searchText) ||
            element
                .get('phone')
                .toString()
                .contains(suppliersProvider.searchText)
            : true)
          .map((DocumentSnapshot document) {
          log(document.data().toString());
          var supplier =
          Supplier.fromJson(document.data() as Map<String, dynamic>);
          return InkWell(
            onTap: () {
              updateSupplier(context, suppliersProvider, supplier: supplier);
            },
            child: Card(
                margin: const EdgeInsets.only(
                    left: 16.0, right: 16.0, top: 8, bottom: 8),
                color: ColorsUtils.alphaBlue,
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            SvgPicture.asset('images/ic_person.svg'),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 24.0, right: 24.0),
                                child: Text(
                                  supplier.name ?? '',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.phone_outlined,
                                color: Colors.black),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Text(
                                    supplier.phone ?? '',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on_outlined,
                                color: Colors.black),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Text(
                                    supplier.address ?? '',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                        'images/ic_paid_dollar.svg'),
                                    Text(
                                      supplier.paid?.toString() ?? '',
                                      style: const TextStyle(
                                          color: Colors.green),
                                    ),
                                    Text(locale.translate('paid') ?? '')
                                  ],
                                )),
                            Expanded(
                                child: Column(
                                  children: [
                                    SvgPicture.asset('images/ic_dollar.svg'),
                                    Text(
                                      supplier.remaining?.toString() ?? '',
                                      style:
                                      const TextStyle(color: Colors.red),
                                    ),
                                    Text(locale.translate('remaining') ?? '')
                                  ],
                                )),
                            Expanded(
                                child: Column(
                                  children: [
                                    SvgPicture.asset('images/ic_dollar.svg'),
                                    Text(supplier.inDebt?.toString() ?? ''),
                                    Text(locale.translate('in_debt') ?? '')
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          );
        }).toList()
            : []);
  }

  void updateSupplier(BuildContext context, SuppliersProvider suppliersProvider,
      {Supplier? supplier}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddOrUpdateSupplierPage(
              supplier: supplier,
            )));
  }
}
