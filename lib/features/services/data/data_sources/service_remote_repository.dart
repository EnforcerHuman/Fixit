import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/services/data/model/services_model.dart';

class ServiceRemoteRepository {
  Stream<List<Service>> getServices() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection('Services').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              Service.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }
}
