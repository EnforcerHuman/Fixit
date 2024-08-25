import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fixit/firebase_options.dart';

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings.persistenceEnabled;
}

Future<void> createUserDocument(
    String userId, String email, String phoneNumber) async {
  try {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'phoneNumber': phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
    });
  } catch (e) {
    //
  }
}

Future<void> retrieveAndPrintUsersData() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    if (querySnapshot.docs.isEmpty) {
      return;
    }
  } catch (e) {
    //
  }
}
