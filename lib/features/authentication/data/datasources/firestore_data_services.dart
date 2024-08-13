import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataServices {
  //

  // Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
  //   try {
  //     print("Fetching user details for userId: $userId");

  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('users');

  //     print("Querying users collection...");
  //     QuerySnapshot querySnapshot =
  //         await users.where('userId', isEqualTo: userId).limit(1).get();

  //     print("Query complete. Documents found: ${querySnapshot.docs.length}");

  //     if (querySnapshot.docs.isNotEmpty) {
  //       var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;
  //       print("User data found: $userData");
  //       return userData;
  //     } else {
  //       print("No user found with userId: $userId");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Error fetching user details: $e");
  //     return null;
  //   }
  // }
  Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Fetch the user details using the userId
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Assuming there is only one document with the given userId
      DocumentSnapshot userDoc = querySnapshot.docs.first;
      return userDoc.data() as Map<String, dynamic>;
    } else {
      return null; // No user found with the given userId
    }
  }
}
