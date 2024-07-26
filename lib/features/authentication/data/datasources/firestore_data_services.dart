import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataServices {
  Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
    try {
      // Get a reference to the users collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Get the document with the specified user ID
      DocumentSnapshot documentSnapshot = await users.doc(userId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
