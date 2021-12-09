import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:tarek_agro/data/models/supplier.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/locale/app_localization.dart';
import 'package:tarek_agro/providers/warehouse/warehouse_provider.dart';
import 'package:tarek_agro/utils/colors_utils.dart';
import 'package:tarek_agro/view/customWidgets/custom_dialogs.dart';

class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({Key? key}) : super(key: key);

  @override
  State<AddNewProductPage> createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  @override
  void initState() {
    super.initState();
    var warehouseProvider =
        Provider.of<WarehouseProvider>(context, listen: false);
    warehouseProvider.getSuppliers();
    warehouseProvider.getUnits();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var warehouseProvider = Provider.of<WarehouseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.translate('add_new_product') ?? ''),
        titleTextStyle: const TextStyle(fontSize: 20.0, color: Colors.black),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black54,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            warehouseProvider.destroyAddProduct();
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: warehouseProvider.formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 24.0, left: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: warehouseProvider.nameController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.done,
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
                                        locale.translate("product_name") ??
                                            "Product Name",
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
                      const ExpiryDate(),
                      const ChooseSupplier(),
                      const ChooseUnit(),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 24.0, left: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                warehouseProvider.quantityController,
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    labelText: locale.translate("quantity") ??
                                        "Quantity",
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
                        margin: const EdgeInsets.only(
                            top: 24.0, left: 16, right: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller:
                                warehouseProvider.priceController,
                                textAlign: TextAlign.start,
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                textInputAction: TextInputAction.done,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                decoration: InputDecoration(
                                    labelText: locale.translate("price") ??
                                        "Price",
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
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 16.0, right: 16.0, bottom: 24.0, top: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Text(locale.translate('add') ?? ''),
                      style: ElevatedButton.styleFrom(
                          primary: ColorsUtils.secondary,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        addNewProduct(context, warehouseProvider);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addNewProduct(
      BuildContext context, WarehouseProvider warehouseProvider) {
    var locale = AppLocalization.of(context);
    if (warehouseProvider.isValidInputs()) {
      if (warehouseProvider.isValidExpiryDate()) {
        if (warehouseProvider.isValidSupplier()) {
          if (warehouseProvider.isValidUnit()) {
            warehouseProvider.addProduct();
            warehouseProvider.destroyAddProduct();
            Navigator.pop(context);
          } else {
            showAlertDialog(context,
                message: locale.translate('unit_required') ?? '');
          }
        } else {
          showAlertDialog(context,
              message: locale.translate('supplier_required') ?? '');
        }
      } else {
        showAlertDialog(context,
            message: locale.translate('expiry_date_required') ?? '');
      }
    }
  }
}

class ChooseSupplier extends StatefulWidget {
  const ChooseSupplier({Key? key}) : super(key: key);

  @override
  State<ChooseSupplier> createState() => _ChooseSupplierState();
}

class _ChooseSupplierState extends State<ChooseSupplier> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var warehouseProvider = Provider.of<WarehouseProvider>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
            margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, width: 1, style: BorderStyle.solid),
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      locale.translate('supplier') ?? '',
                      style: const TextStyle(
                          color: Colors.black, fontSize: 12.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        items: warehouseProvider.suppliers
                            .map((Supplier supplier) {
                          return DropdownMenuItem(
                            value: supplier,
                            child: Text(supplier.name ?? ''),
                          );
                        }).toList(),
                        onChanged: (Supplier? newSupplier) {
                          if (newSupplier != null) {
                            setState(() {
                              warehouseProvider.setSupplier = newSupplier;
                            });
                          }
                        },
                        value: warehouseProvider.supplier,
                        isExpanded: true,
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ExpiryDate extends StatefulWidget {
  const ExpiryDate({Key? key}) : super(key: key);

  @override
  State<ExpiryDate> createState() => _ExpiryDateState();
}

class _ExpiryDateState extends State<ExpiryDate> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var warehouseProvider = Provider.of<WarehouseProvider>(context);
    return Container(
      margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
              color: Colors.grey, width: 1, style: BorderStyle.solid)),
      child: Row(
        children: [
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(
                    locale.translate('expiry_date') ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0),
                  )),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text(
                      warehouseProvider.getFormattedExpiryDate(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0),
                    )),
                  ],
                ),
              )
            ],
          )),
          IconButton(
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  locale:
                      locale.isArabicLanguage() ? LocaleType.ar : LocaleType.en,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  onConfirm: (date) {
                    setState(() {
                      warehouseProvider.setExpiryDate = date;
                    });
                  },
                );
              },
              icon: const Icon(
                Icons.date_range_outlined,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}

class ChooseUnit extends StatefulWidget {
  const ChooseUnit({Key? key}) : super(key: key);

  @override
  State<ChooseUnit> createState() => _ChooseUnitState();
}

class _ChooseUnitState extends State<ChooseUnit> {
  @override
  Widget build(BuildContext context) {
    var locale = AppLocalization.of(context);
    var warehouseProvider = Provider.of<WarehouseProvider>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
            margin: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, width: 1, style: BorderStyle.solid),
                borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      locale.translate('main_unit') ?? '',
                      style: const TextStyle(
                          color: Colors.black, fontSize: 12.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                        items: warehouseProvider.units.map((Unit unit) {
                          return DropdownMenuItem(
                            value: unit,
                            child: Text(unit.name ?? ''),
                          );
                        }).toList(),
                        onChanged: (Unit? newUnit) {
                          if (newUnit != null) {
                            setState(() {
                              warehouseProvider.setUnit = newUnit;
                            });
                          }
                        },
                        value: warehouseProvider.unit,
                        isExpanded: true,
                      )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
