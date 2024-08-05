import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit/features/services/data/model/services_model.dart';

class ServiceRemoteRepository {
  Stream<List<ServicesModel>> getServices() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection('Services').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              ServicesModel.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    });
  }

  Future<List<ServicesModel>> searchService(String query) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      print("Searching for: '$query'");

      QuerySnapshot querySnapshot = await firestore
          .collection('Services')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();

      print("Query completed. Documents found: ${querySnapshot.docs.length}");

      List<ServicesModel> results = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        print("Document: ${doc.id}, Data: $data");
        return ServicesModel.fromMap(data, doc.id);
      }).toList();

      return results;
    } catch (e) {
      print("Error performing search: $e");
      return [];
    }
  }
}
