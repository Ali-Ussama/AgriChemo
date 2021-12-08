import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarek_agro/data/models/unit.dart';
import 'package:tarek_agro/utils/constants.dart';

class UnitsRepo {

  static Stream<QuerySnapshot> getUnits() {
    return FirebaseFirestore.instance.collection(Constants.unitsCollection).snapshots(includeMetadataChanges: true);
  }

  static void addUnit(Unit unit) async {
    await FirebaseFirestore.instance
        .collection(Constants.unitsCollection)
        .add(unit.toJson())
        .then((value) {
      unit.setId(value.id);
      value.update(unit.toJson());
    });
  }
}
