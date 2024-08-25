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
            // ignore: unnecessary_cast
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
        // ignore: prefer_interpolation_to_compose_strings
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

  Stream<int> getProviderTotalBookings(String id) {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    try {
      return firebaseFirestore
          .collection('Bookings')
          .where('status', isEqualTo: 'Completed')
          .where('serviceProviderId', isEqualTo: id)
          .snapshots()
          .map((querySnapshot) {
        return querySnapshot.docs.length;
      });
    } catch (e) {
      // Log the error here
      return Stream.value(0);
    }
  }
}
