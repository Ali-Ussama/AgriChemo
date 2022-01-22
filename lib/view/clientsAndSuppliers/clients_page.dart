import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/client.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/clients_and_suppliers/clients_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/clientsAndSuppliers/add_or_update_client_page.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({Key? key}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var clientsProvider = Provider.of<ClientsProvider>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
              top: 16.0, left: 16, right: 16, bottom: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: clientsProvider.searchController,
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
                      clientsProvider.searchText = value ?? '';
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
                stream: clientsProvider.getClients(),
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
                    child: ClientsList(docs: snapshot.data?.docs),
                  );
                }),
            Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 16.0),
                  child: FloatingActionButton(
                    onPressed: () {
                      navigateToAddNewClient(context, clientsProvider);
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

  void navigateToAddNewClient(
      BuildContext context, ClientsProvider clientsProvider) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddOrUpdateClientPage()));
  }
}

class ClientsList extends StatelessWidget {
  List<QueryDocumentSnapshot>? docs;

  ClientsList({Key? key, this.docs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var clientsProvider = Provider.of<ClientsProvider>(context);
    return ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 48.0),
        children: docs != null && docs!.isNotEmpty
            ? docs!
                .where((element) => clientsProvider.searchText.isNotEmpty
                    ? element
                            .get('name')
                            .toString()
                            .contains(clientsProvider.searchText) ||
                        element
                            .get('phone')
                            .toString()
                            .contains(clientsProvider.searchText)
                    : true)
                .map((DocumentSnapshot document) {
                log(document.data().toString());
                var client =
                    Client.fromJson(document.data() as Map<String, dynamic>);
                return InkWell(
                  onTap: () {
                    updateClient(context, clientsProvider, client: client);
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
                                        client.name ?? '',
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
                                      client.phone ?? '',
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
                                      client.address ?? '',
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
                                        client.paid?.toString() ?? '',
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
                                        client.remaining?.toString() ?? '',
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
                                      Text(client.inDebt?.toString() ?? ''),
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

  void updateClient(BuildContext context, ClientsProvider clientsProvider,
      {Client? client}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddOrUpdateClientPage(
                  client: client,
                )));
  }
}
