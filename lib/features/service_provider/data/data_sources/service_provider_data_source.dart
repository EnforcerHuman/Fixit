import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderDataSource {
  Stream<List<Map<String, dynamic>>> getServiceProvidersStream() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection('ServiceProviders')
        .where('isVerified', isEqualTo: true) // Filter for verified providers
        .snapshots()
        .map(
      (snapshot) {
        List<Map<String, dynamic>> providers = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return providers;
      },
    );
  }

  Stream<Map<String, dynamic>> getSingleProviderDetails(String id) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection('ServiceProviders')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      Map<String, dynamic> providerDetails =
          snapshot.data() as Map<String, dynamic>;
      return providerDetails;
    });
  }

  Stream<List<Map<String, dynamic>>> getProviderByProfession(String query) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore
        .collection('ServiceProviders')
        .where('serviceArea', isGreaterThanOrEqualTo: query)
        .where('serviceArea', isLessThan: query + 'z')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
