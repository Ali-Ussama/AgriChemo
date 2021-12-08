import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/repos/units/units_repository.dart';

class UnitsProvider extends ChangeNotifier {
  Stream<QuerySnapshot> getUnits() {
    return UnitsRepo.getUnits();
  }

  Unit? getUnitFromJson(Map<String, dynamic>? data) => data != null ? Unit.fromJson(data) : null;

  void addNewUnit(String unitName){
    UnitsRepo.addUnit(Unit(id: '',name: unitName));
  }

  void updateUnit(Unit unit){
    UnitsRepo.updateUnit(unit);
  }
}
