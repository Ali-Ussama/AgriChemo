import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/data/models/client.dart';
import 'package:tarek_agro/repos/clientsAndSuppliers/clients_repo.dart';

class ClientsProvider extends ChangeNotifier {
  Client? client;
  var searchText = "";

  var searchController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var paidAmountController = TextEditingController(text: "0.0");
  var remainingController = TextEditingController(text: "0.0");
  var inDebtController = TextEditingController(text: "0.0");

  var formKey = GlobalKey<FormState>();

  Stream<QuerySnapshot> getClients() => ClientsRepo.getClients();

  void fillFieldsWithClientsInfo() {
    nameController.text = client?.name ?? '';
    phoneController.text = client?.phone ?? '';
    addressController.text = client?.address ?? '';
    paidAmountController.text = client?.paid?.toString() ?? '';
    remainingController.text = client?.remaining?.toString() ?? '';
    inDebtController.text = client?.inDebt?.toString() ?? '';
  }

  void addOrUpdateClient() {
    if (client != null) {
      client?.setName = nameController.text;
      client?.setPhone = phoneController.text;
      client?.setAddress = addressController.text;
      client?.setPaid = getPaidAmount();
      client?.setRemaining = getRemainingAmount();
      client?.setInDebt = getInDebtAmount();
      ClientsRepo.updateClient(client!);
    } else {
      ClientsRepo.addNewClient(Client(
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
    client = null;
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
