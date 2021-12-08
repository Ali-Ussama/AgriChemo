import 'package:flutter/material.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/clientsAndSuppliers/clients_page.dart';
import 'package:tarek_agro/view/clientsAndSuppliers/suppliers/suppliers_page.dart';

class ClientsAndSuppliersPage extends StatefulWidget {
  const ClientsAndSuppliersPage({Key? key}) : super(key: key);

  @override
  State<ClientsAndSuppliersPage> createState() =>
      _ClientsAndSuppliersPageState();
}

class _ClientsAndSuppliersPageState extends State<ClientsAndSuppliersPage> {
  bool isClientSelected = true;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16.0,right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if(!isClientSelected) {
                              isClientSelected = !isClientSelected;
                            }
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          color:
                          isClientSelected ? ColorsUtils.secondary : Colors.white,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(locale.translate('clients') ?? '',
                                    style: TextStyle(
                                        color: isClientSelected
                                            ? Colors.white
                                            : Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            setState(() {
                              if(isClientSelected) {
                                isClientSelected = !isClientSelected;
                              }                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            color: !isClientSelected
                                ? ColorsUtils.secondary
                                : Colors.white,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(locale.translate('suppliers') ?? '',
                                      style: TextStyle(
                                          color: !isClientSelected
                                              ? Colors.white
                                              : Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ))),
                ],
              ),
            ),
            Visibility(
              visible: isClientSelected,
              child: Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: const ClientsPage(),
                ),
              ),
            ),
            Visibility(
              visible: !isClientSelected,
              child: Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  child: const SuppliersPage(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
