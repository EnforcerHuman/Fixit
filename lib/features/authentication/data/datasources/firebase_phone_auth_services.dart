import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/DB/db_functions.dart';
import 'package:fixit/controllers/user_controller.dart';
import 'package:fixit/features/authentication/data/model/user_model.dart';
import 'package:fixit/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

String verId = '';

class PhoneAuthentication {
  DbFunction db = DbFunction();
  createUser usercreation = createUser();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Logic to send OTP
  // Future<void> sendOTPcode(
  //     String phone, Function(String) oncodesent, context) async {
  //   await _auth.verifyPhoneNumber(
  //     timeout: Duration(seconds: 40),
  //     phoneNumber: "+91$phone",
  //     verificationCompleted: (credential) {
  //       print('Verification completed automatically');
  //     },
  //     verificationFailed: (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Verification failed: ${e.message}')),
  //       );
  //       print(e.message);
  //     },
  //     codeSent: (verificationId, responseToken) {
  //       oncodesent(verificationId);
  //       verId = verificationId;
  //       print(verId);
  //     },
  //     codeAutoRetrievalTimeout: (verificationId) {
  //       print('Auto retrieval timeout: $verificationId');
  //     },
  //   );

  //   print('OTP sent');
  // }

  Future<String> sendOTP(String phone) async {
    Completer<String> completer = Completer();
    print('Sending OTP started..........');
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91$phone	",
      timeout: Duration(seconds: 40),
      verificationCompleted: (credential) {
        print('Verification completed automatically');
      },
      verificationFailed: (e) {
        print('Verification failed: ${e.message}');
      },
      codeSent: (verificationId, responseToken) {
        completer.complete(verificationId);
        print('Verification ID from auth remore data source: $verificationId');
        // Handle the verification ID as needed
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('Auto retrieval timeout: $verificationId');
      },
    );
    print('returned id : $completer');
    return completer.future;
  }

  Future<UserCredential> verifyOTP(
      String otp, String verificationId, String email, String password) async {
    print(email);
    try {
      print('Attempting to verify OTP...');
      PhoneAuthCredential phoneCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, // Use the actual verificationId
        smsCode: otp, // Use the actual OTP entered by the user
      );
      print('Phone credential created');

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(phoneCredential);
      print(
          'Phone authentication successful. User ID: ${userCredential.user?.uid}');

      await linkEmailPassword(email, password);
      print('Email and password linked successfully');

      print('OTP verification and account linking completed successfully');
      return userCredential;
    } catch (e) {
      print('Authentication failed. Error: $e');
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
    UserCredential? userCredential;
    try {
      // Attempt to sign in with email and password
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Map<String, dynamic>? user =
      //     await db.getUserDetailsById(userCredential.user!.uid);
      // if (user!['name'] == 'Ananya') {
      //   print('YOur LOGIC IS CORRECT');
      // }
      // If successful, navigate to the home screen
      print('User logged in successfully');
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }
      print(errorMessage);

      rethrow;
    } catch (e) {
      print('Unexpected error: $e');

      rethrow;
    }
    return userCredential;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } catch (e) {
      print('Error sending password reset email: $e');
      // Handle specific errors here
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'user-not-found':
            print('No user found for that email.');
            break;
          case 'invalid-email':
            print('The email address is badly formatted.');
            break;
          default:
            print('An unknown error occurred.');
        }
      }
    }
  }
}
