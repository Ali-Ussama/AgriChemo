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
    _address = address;
    _paid = paid;
    _remaining = remaining;
    _inDebt = inDebt;
  }

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      address: json['address'],
      id: json['id'],
      inDebt: json['inDebt'],
      name: json['name'],
      paid: json['paid'],
      phone: json['phone'],
      remaining: json['remaining'],
    );
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
}
