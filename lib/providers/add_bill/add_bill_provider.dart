
import 'package:flutter/material.dart';
import 'package:tarek_agro/data/models/client.dart';
import 'package:tarek_agro/data/models/product.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/repos/clientsAndSuppliers/clients_repo.dart';
import 'package:tarek_agro/repos/products/products_repo.dart';
import 'package:tarek_agro/repos/units/units_repository.dart';

class AddSalesBillProvider extends ChangeNotifier {
  bool isCollectingMoneyVisible = false;

  var collectMoneyFormKey = GlobalKey<FormState>();

  var amountController = TextEditingController();

  Client? _client;

  Client? get client => _client;

  set setClient(Client value) {
    _client = value;
  }

  void setCollectingMoneyVisibility() {
    isCollectingMoneyVisible = !isCollectingMoneyVisible;
    amountController.text = '';
    notifyListeners();
  }

  void destroyClient() {
    _client = null;
    isCollectingMoneyVisible = false;
    amountController.text = '';
  }

  void saveCollectingMoney() {
    var paidAmount = double.parse(amountController.text);
    var remaining = _client!.remaining!;
    var inDebt = _client!.inDebt!;

    if (remaining <= 0 || paidAmount > remaining) {
      _client?.setRemaining = 0.0;
      _client?.setInDebt = inDebt + (paidAmount - remaining);
    } else {
      _client?.setRemaining = remaining - paidAmount;
    }
    ClientsRepo.collectMoney(_client!);
  }

  bool isCollectMoneyInputsValid() =>
      collectMoneyFormKey.currentState!.validate();

  ///---------------- Add Products ---------------------------

  List<Unit> allUnits = [];

  List<Product> allProducts = [];

  List<Product> addedProducts = [];

  List<TextEditingController?> amountControllers = [];

  List<TextEditingController?> priceControllers = [];

  var productSearchController = TextEditingController();

  var productsFormKey = GlobalKey<FormState>();

  void getUnits() {
    UnitsRepo.getUnits().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        allUnits = [];
        for (var document in snapshot.docs) {
          if (document.data() != null) {
            var unit = Unit.fromJson(document.data() as Map<String, dynamic>);
            allUnits.add(unit);
          }
        }
      }
      notifyListeners();
    });
  }

  void getProducts() {
    ProductsRepo.getProducts().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        allProducts = [];
        for (var document in snapshot.docs) {
          if (document.data() != null) {
            var product =
                Product.fromJson(document.data() as Map<String, dynamic>?);
            allProducts.add(product);
          }
        }
      }
      notifyListeners();
    });
  }

  void addProductToList(Product? product) {
    if (product != null) {
      addedProducts.add(Product(
        id: product.id,
        name: product.name,
        expDate: product.expDate,
        supplierId: product.supplierId,
        units: product.unit,
        price: product.price
      ));
    }
    notifyListeners();
  }

  bool isListContainsThisProduct(Product selection) {
    if (addedProducts.isNotEmpty) {
      for (var product in addedProducts) {
        if (product.id == selection.id) {
          return true;
        }
      }
    }
    return false;
  }

  Unit? getUnitById(Unit? unit) {
    return allUnits.firstWhere((element) => unit?.id == element.id);
  }

  void setSelectedProductUnit(Product? product, Unit? newUnit) {
    if (product != null && newUnit != null) {
      for (var mProduct in addedProducts) {
        if (product.id == mProduct.id) {
          mProduct.setUnit = newUnit;
        }
      }
      notifyListeners();
    }
  }

  double getTotalBillPrice() {
    var total = 0.0;
    if (addedProducts.isNotEmpty) {
      for (var index = 0; index < addedProducts.length; index++) {
        var quantity = amountControllers[index]?.text != null &&
                amountControllers[index]!.text.isNotEmpty
            ? int.parse(amountControllers[index]!.text)
            : 0;
        var price = priceControllers[index]?.text != null &&
                priceControllers[index]!.text.isNotEmpty
            ? double.parse(priceControllers[index]!.text)
            : 0;
        total += price * quantity;
      }
    }
    return total;
  }

  bool isValidQuantity(String productId,String quantity){
    var isValid = false;
    for (var originalProduct in allProducts) {
      if(productId == originalProduct.id){
        isValid = originalProduct.quantity != null && originalProduct.quantity! >= int.parse(quantity);
      }
    }
    return isValid;
  }

  void setProductQuantity(Product product, String newQuantity) {
    product.setQuantity = int.parse(newQuantity);
    notifyListeners();
  }

  void setProductPrice(Product product, String newPrice) {
    product.setPrice = double.parse(newPrice);
    notifyListeners();
  }

  void initializeNewAddProductControllers(Product product, int index) {
    if (amountControllers.length <= index ){
      amountControllers.add(TextEditingController(text: "${product.price != null ? 1 : ''}"));
    }
    if (priceControllers.length <= index ){
      priceControllers.add(TextEditingController(text: "${product.price != null && product.price! > 0 ? product.price : ''}"));
    }
  }

  void destroyAddProducts() {
    productSearchController.text = '';
    allProducts = [];
    allUnits = [];
    addedProducts = [];
    amountControllers = [];
    priceControllers = [];
  }

  bool isAllValid() {
    var isValid = true;
    if(productsFormKey.currentState != null && !productsFormKey.currentState!.validate()) isValid = false;
    if(!isValidAddedProducts()) isValid = false;
    return isValid;
  }

  bool isValidAddedProducts() => addedProducts.isNotEmpty;

  void deleteAddedProduct(Product product, int index) {
    amountControllers.removeAt(index);
    priceControllers.removeAt(index);
    addedProducts.remove(product);
    notifyListeners();
  }

  void destroyReviewPageData() {}

}
