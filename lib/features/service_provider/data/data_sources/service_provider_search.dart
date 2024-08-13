import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderSearchDataSource {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> searchServiceProviders(
      String query) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('ServiceProviders')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();

      List<Map<String, dynamic>> results = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      return results;
    } catch (e) {
      print("Error performing search: $e");
      return [];
    }
  }
}
