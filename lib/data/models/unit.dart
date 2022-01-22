class Unit {
  String? _id;
  String? _name;

  String? get id => _id;

  String? get name => _name;

  void setId(String? id){
    _id = id;
  }
  void setName(String? name){
    _name = name;
  }

  Unit({String? id, String? name}) {
    _id = id;
    _name = name;
  }

  Unit.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
