import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarek_agro/data/models/supplier.dart';
import 'package:tarek_agro/utils/constants.dart';

class SuppliersRepo {

  static Stream<QuerySnapshot> getSuppliers() => FirebaseFirestore.instance
      .collection(Constants.suppliersCollection)
      .snapshots(includeMetadataChanges: true);

  static void addNewSupplier(Supplier supplier) {
    FirebaseFirestore.instance
        .collection(Constants.suppliersCollection)
        .add(supplier.toJson())
        .then((value) {
      supplier.setId = value.id;
      value.update(supplier.toJson());
    });
  }

  static void updateSupplier(Supplier supplier) {
    FirebaseFirestore.instance
        .collection(Constants.suppliersCollection)
        .doc(supplier.id)
        .update(supplier.toJson());
  }
}
