import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/product.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/warehouse/warehouse_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/warehouse/add_new_product_page.dart';

class WareHousePage extends StatefulWidget {
  const WareHousePage({Key? key}) : super(key: key);

  @override
  State<WareHousePage> createState() => _WareHousePageState();
}

class _WareHousePageState extends State<WareHousePage> {

  @override
  void initState() {
    super.initState();
    var warehouseProvider = Provider.of<WarehouseProvider>(context,listen: false);
    warehouseProvider.getSuppliers();
    warehouseProvider.getUnits();
  }
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var warehouseProvider = Provider.of<WarehouseProvider>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  locale.translate('warehouse') ?? '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
                top: 16.0, left: 16, right: 16, bottom: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: warehouseProvider.searchController,
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
                        warehouseProvider.searchText = value ?? '';
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
                  stream: warehouseProvider.getProducts(),
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
                    if (snapshot.data?.docs == null ||
                        snapshot.data!.docs.isEmpty) {
                      return Expanded(
                        child: Center(
                            child: Text(locale.translate('no_data') ?? '')),
                      );
                    }

                    return Expanded(
                      child: ProductsList(docs: snapshot.data?.docs),
                    );
                  }),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        navigateToAddNewItemPage(context);
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
      ),
    );
  }

  void navigateToAddNewItemPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewProductPage()));
  }
}

class ProductsList extends StatelessWidget {
  List<QueryDocumentSnapshot>? docs;

  ProductsList({Key? key, this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var warehouseProvider = Provider.of<WarehouseProvider>(context);
    return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 48.0),
        children: docs != null && docs!.isNotEmpty
            ? docs!
            .where((element) => warehouseProvider.searchText.isNotEmpty
            ? element
            .get('name')
            .toString()
            .contains(warehouseProvider.searchText) ||
            element
                .get('quantity')
                .toString()
                .contains(warehouseProvider.searchText)
            : true)
            .map((DocumentSnapshot document) {
          log(document.data().toString());
          var product =
          Product.fromJson(document.data() as Map<String, dynamic>);
          return InkWell(
            onTap: () {

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
                            SvgPicture.asset('images/ic_product.svg',width: 24.0,height: 24.0),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 16.0, right: 16.0),
                                child: Text(
                                  product.name ?? '',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0),
                                ),
                              ),
                            ),
                            Text(
                              product.price != null ? "${product.price?.toString()} ${locale.translate('egp')}" : '',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            Image.asset('images/ic_products.png',width: 24.0,height: 24.0),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 16.0, right: 16.0),
                                  child: Text(
                                    locale.translate('quantity') ?? '',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4.0, right: 4.0),
                              child: Text(
                                product.quantity?.toString() ?? '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                            Text(
                              product.unit?.name ?? '',
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16.0),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, top: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_outlined,color: Colors.black),
                            Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 8.0, right: 8.0),
                                  child: Text(
                                    locale.translate('expiry_date') ?? '',
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                  ),
                                )),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 4.0, right: 4.0),
                              child: Text(
                                product.expDate?.toString() ?? '',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        }).toList()
            : []);
  }
}
