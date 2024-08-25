import 'package:firebase_auth/firebase_auth.dart';

class CreateUser {
  Future<void> createuser(String email, String password) async {
    try {
      // UserCredential usercredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      //Handle exception
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in -use') {}
    } catch (e) {
      //
    }
  }
}


// import 'dart:math';

// final random = Random.secure();
// final uniqueId = '${DateTime.now().millisecondsSinceEpoch}${random.nextInt(1000000)}';