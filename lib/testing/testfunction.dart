import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/firebase_options.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.settings.persistenceEnabled;
  print("Firebase and Firestore initialized");
}

Future<void> createUserDocument(
    String userId, String email, String phoneNumber) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('User document created successfully');
  } catch (e) {
    print('Error creating user document: $e');
  }
}

Future<void> retrieveAndPrintUsersData() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    if (querySnapshot.docs.isEmpty) {
      print('No users found in the collection.');
      return;
    }

    for (var doc in querySnapshot.docs) {
      print('User ID: ${doc.id}');
      print('User Data: ${doc.data()}');
    }
  } catch (e) {
    print('Error retrieving user data: $e');
  }
}
