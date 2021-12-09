/// id : ""
/// name : ""
/// exp_date : ""
/// supplier_id : ""
/// units : [{"unit_id":"","isMainUnit":true,"qty":10,"price":20.0,"qty_to_main":1,"price_to_main":20.0}]

class Product {
  Product({
    String? id,
    String? name,
    String? expDate,
    String? supplierId,
    String? unitId,
    int? quantity,
    double? price,
  }) {
    _id = id;
    _name = name;
    _expDate = expDate;
    _supplierId = supplierId;
    _unitId = unitId;
    _quantity = quantity;
    _price = price;
  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _expDate = json['exp_date'];
    _supplierId = json['supplier_id'];
    _unitId = json['unit_id'];
    _quantity = json['quantity'];
    _price = json['price'];
  }

  String? _id;
  String? _name;
  String? _expDate;
  String? _supplierId;
  String? _unitId;
  int? _quantity;
  double? _price;

  String? get id => _id;

  String? get name => _name;

  String? get expDate => _expDate;

  String? get supplierId => _supplierId;

  String? get unitId => _unitId;

  int? get quantity => _quantity;

  double? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['exp_date'] = _expDate;
    map['supplier_id'] = _supplierId;
    map['unit_id'] = _unitId;
    map['quantity'] = _quantity;
    map['price'] = _price;

    return map;
  }

  set setId(String value) {
    _id = value;
  }

  set setName(String value) {
    _name = value;
  }

  set setExpDate(String value) {
    _expDate = value;
  }

  set setSupplierId(String value) {
    _supplierId = value;
  }

  set setQuantity(int value) {
    _quantity = value;
  }

  set setPrice(double value) {
    _price = value;
  }

  set setUnitId(String value) {
    _unitId = value;
  }
}
