import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceProviderDataSource {
  Stream<List<Map<String, dynamic>>> getServiceProvidersStream() {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    return firebaseFirestore.collection('ServiceProviders').snapshots().map(
      (snapshot) {
        List<Map<String, dynamic>> providers = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return providers;
      },
    );
  }
}
