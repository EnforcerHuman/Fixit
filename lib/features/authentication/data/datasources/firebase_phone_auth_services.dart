import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/controllers/user_controller.dart';
import 'package:fixit/features/authentication/data/datasources/firestore_data_services.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';

String verId = '';

class PhoneAuthentication {
  CreateUser usercreation = CreateUser();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirestoreDataServices firestoreDataServices = FirestoreDataServices();

  Future<String> sendOTP(String phone) async {
    Completer<String> completer = Completer();
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phone	",
      timeout: const Duration(seconds: 40),
      verificationCompleted: (credential) {},
      verificationFailed: (e) {},
      codeSent: (verificationId, responseToken) {
        completer.complete(verificationId);
        // Handle the verification ID as needed
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    return completer.future;
  }

  Future<UserCredential> verifyOTP(
      String otp, String verificationId, String email, String password) async {
    try {
      PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, // Use the actual verificationId
        smsCode: otp, // Use the actual OTP entered by the user
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneCredential);

      await linkEmailPassword(email, password);

      return userCredential;
    } catch (e) {
      throw Exception('Error verifying OTP: $e');
    }
  }

  // Method to link email/password to phone auth user
  Future<void> linkEmailPassword(String email, String password) async {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential emailPasswordCredential =
          EmailAuthProvider.credential(email: email, password: password);
      await user.linkWithCredential(emailPasswordCredential);
    } catch (e) {
      throw Exception('Error linking email/password: $e');
    }
  }

  Future<void> storeUserData(UserModel userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userData.id)
        .set(userData.toJson());
  }

  Future<UserCredential> login(String email, String password) async {
    try {
      // Attempt to sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseAuthErrorMessage(e);
      throw errorMessage; // Throw a string instead of rethrowing the exception
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  String _getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle specific errors here
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            break;
          case 'invalid-email':
            break;
          default:
        }
      }
    }
  }
}
