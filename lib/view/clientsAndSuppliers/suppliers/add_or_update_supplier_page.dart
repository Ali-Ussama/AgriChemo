
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/supplier.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/clients_and_suppliers/suppliers_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';

class AddOrUpdateSupplierPage extends StatefulWidget{
  Supplier? supplier;
  
  AddOrUpdateSupplierPage({Key? key, this.supplier}) : super(key: key);
  @override
  State<AddOrUpdateSupplierPage> createState() => _AddOrUpdateSupplierPageState();
}

class _AddOrUpdateSupplierPageState extends State<AddOrUpdateSupplierPage> {

  @override
  void initState() {
    var suppliersProvider = Provider.of<SuppliersProvider>(context, listen: false);
    suppliersProvider.supplier = widget.supplier;
    suppliersProvider.fillFieldsWithSuppliersInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var suppliersProvider = Provider.of<SuppliersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(suppliersProvider.supplier != null
            ? locale.translate('update_supplier') ?? ""
            : locale.translate('add_new_supplier') ?? ''),
        titleTextStyle: const TextStyle(color: Colors.black,fontSize: 20.0),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            suppliersProvider.destroy();
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Form(
                      key: suppliersProvider.formKey,
                      child: Column(
                        children: [
                          Container(
                            margin:
                            const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: suppliersProvider.nameController,
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
                                    controller: suppliersProvider.phoneController,
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
                                    controller: suppliersProvider.addressController,
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
                                    suppliersProvider.paidAmountController,
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
                                    controller: suppliersProvider.remainingController,
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
                                    controller: suppliersProvider.inDebtController,
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
                        child: Text(suppliersProvider.supplier != null
                            ? locale.translate('update') ?? ''
                            : locale.translate('add') ?? ''),
                        style: ElevatedButton.styleFrom(
                            primary: ColorsUtils.secondary,
                            textStyle: const TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                        onPressed: () {
                          addNewSupplier(context, suppliersProvider);
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

  void addNewSupplier(BuildContext context, SuppliersProvider suppliersProvider) {
    if (suppliersProvider.isAllValid()) {
      suppliersProvider.addOrUpdateSupplier();
      suppliersProvider.destroy();
      Navigator.pop(context);
    }
  }
}