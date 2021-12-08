import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/client.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/clients_and_suppliers/clients_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';

class AddOrUpdateClientPage extends StatefulWidget {
  Client? client;

  AddOrUpdateClientPage({Key? key, this.client}) : super(key: key);

  @override
  State<AddOrUpdateClientPage> createState() => _AddOrUpdateClientPageState();
}

class _AddOrUpdateClientPageState extends State<AddOrUpdateClientPage> {
  @override
  void initState() {
    var clientsProvider = Provider.of<ClientsProvider>(context, listen: false);
    clientsProvider.client = widget.client;
    clientsProvider.fillFieldsWithClientsInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var clientsProvider = Provider.of<ClientsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(clientsProvider.client != null
            ? locale.translate('update_client') ?? ""
            : locale.translate('add_new_client') ?? ''),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 20.0),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                  key: clientsProvider.formKey,
                  child: Column(
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: clientsProvider.nameController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return locale.translate('name_is_required');
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText:
                                        locale.translate("name") ?? "Name",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 24.0, left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: clientsProvider.phoneController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    labelText:
                                        locale.translate("phone") ?? "Phone",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid))),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return locale
                                        .translate('phone_is_required');
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 24.0, left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: clientsProvider.addressController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return locale
                                        .translate('address_is_required');
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    labelText: locale.translate("address") ??
                                        "Address",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 24.0, left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                    clientsProvider.paidAmountController,
                                textAlign: TextAlign.start,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: true),
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    labelText:
                                        locale.translate("paid") ?? "Paid",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 24.0, left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: clientsProvider.remainingController,
                                textAlign: TextAlign.start,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: true),
                                textInputAction: TextInputAction.next,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    labelText: locale.translate("remaining") ??
                                        "Remaining",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 24.0, left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: clientsProvider.inDebtController,
                                textAlign: TextAlign.start,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true, signed: true),
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    labelText:
                                        locale.translate("in_debt") ?? "InDebt",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1,
                                            style: BorderStyle.solid))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 24.0, top: 24.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text(clientsProvider.client != null
                        ? locale.translate('update') ?? ''
                        : locale.translate('add') ?? ''),
                    style: ElevatedButton.styleFrom(
                        primary: ColorsUtils.secondary,
                        textStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      addNewClient(context, clientsProvider);
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNewClient(BuildContext context, ClientsProvider clientsProvider) {
    if (clientsProvider.isAllValid()) {
      clientsProvider.addOrUpdateClient();
      clientsProvider.destroy();
      Navigator.pop(context);
    }
  }
}
