import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/services/data/model/services_model.dart';

class ServiceRemoteRepository {
  Stream<List<ServicesModel>> getServices() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection('Services').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              // ignore: unnecessary_cast
              ServicesModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<List<ServicesModel>> searchService(String query) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Services')
          .where('name', isGreaterThanOrEqualTo: query)
          // ignore: prefer_interpolation_to_compose_strings
          .where('name', isLessThan: query + 'z')
          .get();

      List<ServicesModel> results = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return ServicesModel.fromMap(data, doc.id);
      }).toList();

      return results;
    } catch (e) {
      return [];
    }
  }
}
