import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarek_agro/data/models/product.dart';
import 'package:tarek_agro/utils/constants.dart';

class ProductsRepo {


  static Stream<QuerySnapshot> getProducts(){
    return FirebaseFirestore.instance.collection(Constants.productsCollection).snapshots(includeMetadataChanges: true);
  }

  static void addNewProduct(Product product) {
    FirebaseFirestore.instance
        .collection(Constants.productsCollection)
        .add(product.toJson())
        .then((value) {
      product.setId = value.id;
      value.update(product.toJson());
    });
  }

  static void updateProduct(Product product) {
    FirebaseFirestore.instance
        .collection(Constants.productsCollection)
        .doc(product.id)
        .update(product.toJson());
  }
}
