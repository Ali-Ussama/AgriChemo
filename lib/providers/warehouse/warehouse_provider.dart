
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/data/models/product.dart';
import 'package:tarek_agro/data/models/supplier.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/repos/clientsAndSuppliers/suppliers_repo.dart';
import 'package:tarek_agro/repos/products/products_repo.dart';
import 'package:tarek_agro/repos/units/units_repository.dart';
import 'package:tarek_agro/utils/date_util.dart';

class WarehouseProvider extends ChangeNotifier{

  var searchText = "";

  var searchController = TextEditingController();
  var nameController = TextEditingController();
  var quantityController = TextEditingController();
  var priceController = TextEditingController();

  DateTime? _expiryDate;

  Supplier? _supplier;

  Unit? _unit;

  List<Supplier> suppliers = [];

  List<Unit> units = [];

  DateTime? get expiryDate => _expiryDate;

  set setExpiryDate(DateTime value) {
    _expiryDate = value;
  }

  Supplier? get supplier => _supplier;

  Unit? get unit => _unit;

  set setSupplier(Supplier value) {
    _supplier = value;
  }

  set setUnit(Unit value) {
    _unit = value;
  }
  var formKey = GlobalKey<FormState>();

  Stream<QuerySnapshot> getProducts() => ProductsRepo.getProducts();

  void getSuppliers(){
    SuppliersRepo.getSuppliers().listen((snapshot) {

      if(snapshot.docs.isNotEmpty){
        suppliers = [];
        for (var document in snapshot.docs) {
          var supplier = Supplier.fromJson(document.data() as Map<String, dynamic>);
          suppliers.add(supplier);
        }
      }
      notifyListeners();
    });
  }

  void getUnits(){
    UnitsRepo.getUnits().listen((snapshot) {

      if(snapshot.docs.isNotEmpty){
        units = [];
        for (var document in snapshot.docs) {
          var unit = Unit.fromJson(document.data() as Map<String, dynamic>);
          units.add(unit);
        }
      }
      notifyListeners();
    });
  }

  void addProduct(){
    ProductsRepo.addNewProduct(Product(
      name: nameController.text,
      expDate: DateUtil.formatDate(DateUtil.SlashShortDateFormat, _expiryDate!),
      supplierId: _supplier?.id,
      unitId: _unit?.id,
      quantity: quantityController.text.isNotEmpty ? int.parse(quantityController.text) : 0,
      price: priceController.text.isNotEmpty ? double.parse(priceController.text) : 0.0
    ));
  }

  void destroyAddProduct() {
    nameController.text = '';
    quantityController.text = '';
    priceController.text = '';
    _expiryDate = null;
    _supplier = null;
    _unit = null;
  }

  void destroy() {
    searchText = '';
    searchController.text = '';
    suppliers = [];
    units = [];
  }
  String getFormattedExpiryDate() {
    if(_expiryDate != null){
      return DateUtil.formatDate(DateUtil.SlashShortDateFormat, _expiryDate!);
    }
    return '';
  }

  bool isValidInputs() {
    var isValid = true;

    if(!formKey.currentState!.validate()) isValid = false;


    return isValid;
  }

  bool isValidExpiryDate() => _expiryDate != null;

  bool isValidSupplier() => _supplier != null;

  bool isValidUnit() => _unit != null;

  String getUnitName(String? unitId) {
    if(units.isNotEmpty && unitId != null){
      return (units.firstWhere((element) => unitId == element.id)).name ?? '';
    }
    return '';
  }

}