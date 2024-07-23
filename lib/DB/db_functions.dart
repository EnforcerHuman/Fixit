import 'package:cloud_firestore/cloud_firestore.dart';

class DbFunction {
  Future<void> storeUserData(
      String userId, String email, String phoneNumber) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'name': userId,
      'email': phoneNumber,
      'phone': phoneNumber
      // Add any other user data here
    });
  }

  Future<void> retrieveAndPrintUsersData() async {
    try {
      // Get a reference to the users collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Get all documents in the collection
      QuerySnapshot querySnapshot = await users.get();

      // Check if there are any documents
      if (querySnapshot.docs.isEmpty) {
        print('No users found in the collection.');
        return;
      }

      // Iterate through the documents and print the data
      for (var doc in querySnapshot.docs) {
        // Get the data as a Map
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Print the document ID and data
        print('User ID: ${doc.id}');
        data.forEach((key, value) {
          print('  $key: $value');
        });
        print('-------------------'); // Separator between users
      }

      print('Total users: ${querySnapshot.docs.length}');
    } catch (e) {
      print('Error retrieving user data: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserDetailsById(String userId) async {
    try {
      // Get a reference to the users collection
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Get the document with the specified user ID
      DocumentSnapshot documentSnapshot = await users.doc(userId).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Cast the data to Map<String, dynamic> and return it
        print(documentSnapshot.data() as Map<String, dynamic>);
        return documentSnapshot.data() as Map<String, dynamic>;
      } else {
        print('No user found with ID: $userId');
        return null;
      }
    } catch (e) {
      print('Error retrieving user data: $e');
      return null;
    }
  }
}