import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarek_agro/data/models/client.dart';
import 'package:tarek_agro/utils/constants.dart';

class ClientsRepo {
  static Stream<QuerySnapshot> getClients() => FirebaseFirestore.instance
      .collection(Constants.clientsCollection)
      .snapshots(includeMetadataChanges: true);

  static void addNewClient(Client client) {
    FirebaseFirestore.instance
        .collection(Constants.clientsCollection)
        .add(client.toJson())
        .then((value) {
      client.setId = value.id;
      value.update(client.toJson());
    });
  }

  static void updateClient(Client client) {
    FirebaseFirestore.instance
        .collection(Constants.clientsCollection)
        .doc(client.id)
        .update(client.toJson());
  }
}
