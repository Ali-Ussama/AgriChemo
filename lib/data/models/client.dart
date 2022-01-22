class Client {
  String? _id;
  String? _name;
  String? _phone;
  String? _address;
  double? _paid;
  double? _remaining;
  double? _inDebt;

  String? get id => _id;

  String? get name => _name;

  String? get address => _address;

  String? get phone => _phone;

  double? get paid => _paid;

  double? get remaining => _remaining;

  double? get inDebt => _inDebt;

  Client(
      {String? id,
      String? name,
      String? phone,
      String? address,
      double? paid = 0.0,
      double? remaining = 0.0,
      double? inDebt = 0.0}) {
    _id = id;
    _phone = phone;
    _name = name;
    _address = address;
    _paid = paid;
    _remaining = remaining;
    _inDebt = inDebt;
  }

  Client.fromJson(Map<String, dynamic> json) {
      _address = json['address'];
      _id = json['id'];
      _inDebt= json['inDebt'] != null ? double.parse(json['inDebt'].toString()) : null;
      _name= json['name'];
      _paid= json['paid'] != null ? double.parse(json['paid'].toString()) : null;
      _phone= json['phone'];
      _remaining= json['remaining'] != null ? double.parse(json['remaining'].toString()) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['id'] = id;
    data['inDebt'] = inDebt;
    data['name'] = name;
    data['paid'] = paid;
    data['phone'] = phone;
    data['remaining'] = remaining;
    return data;
  }


  set setId(String? id){
    _id = id;
  }

  set setName(String? value) {
    _name = value;
  }

  set setPhone(String? value) {
    _phone = value;
  }

  set setAddress(String? value) {
    _address = value;
  }

  set setPaid(double? value) {
    _paid = value;
  }

  set setRemaining(double? value) {
    _remaining = value;
  }

  set setInDebt(double? value) {
    _inDebt = value;
  }
}
