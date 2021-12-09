import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/data/models/supplier.dart';
import 'package:tarek_agro/repos/clientsAndSuppliers/suppliers_repo.dart';

class SuppliersProvider extends ChangeNotifier{
  Supplier? supplier;
  var searchText = "";

  var searchController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var paidAmountController = TextEditingController(text: "0.0");
  var remainingController = TextEditingController(text: "0.0");
  var inDebtController = TextEditingController(text: "0.0");

  var formKey = GlobalKey<FormState>();

  Stream<QuerySnapshot> getSuppliers() => SuppliersRepo.getSuppliers();

  void fillFieldsWithSuppliersInfo() {
    nameController.text = supplier?.name ?? '';
    phoneController.text = supplier?.phone ?? '';
    addressController.text = supplier?.address ?? '';
    paidAmountController.text = supplier?.paid?.toString() ?? '';
    remainingController.text = supplier?.remaining?.toString() ?? '';
    inDebtController.text = supplier?.inDebt?.toString() ?? '';
  }

  void addOrUpdateSupplier() {
    if (supplier != null) {
      supplier?.setName = nameController.text;
      supplier?.setPhone = phoneController.text;
      supplier?.setAddress = addressController.text;
      supplier?.setPaid = getPaidAmount();
      supplier?.setRemaining = getRemainingAmount();
      supplier?.setInDebt = getInDebtAmount();
      SuppliersRepo.updateSupplier(supplier!);
    } else {
      SuppliersRepo.addNewSupplier(Supplier(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          paid: getPaidAmount(),
          remaining: getRemainingAmount(),
          inDebt: getInDebtAmount()));
    }
  }

  bool isAllValid() {
    var isValid = true;

    if (!formKey.currentState!.validate()) isValid = false;

    return isValid;
  }

  double getPaidAmount() {
    if (paidAmountController.text.isNotEmpty) {
      return double.parse(paidAmountController.text);
    }
    return 0.0;
  }

  double getRemainingAmount() {
    if (remainingController.text.isNotEmpty) {
      return double.parse(remainingController.text);
    }
    return 0.0;
  }

  double getInDebtAmount() {
    if (inDebtController.text.isNotEmpty) {
      return double.parse(inDebtController.text);
    }
    return 0.0;
  }

  void destroy() {
    supplier = null;
    searchText = '';
    searchController.text = '';
    nameController.text = '';
    phoneController.text = '';
    addressController.text = '';
    paidAmountController.text = '';
    remainingController.text = '';
    inDebtController.text = '';
  }
}