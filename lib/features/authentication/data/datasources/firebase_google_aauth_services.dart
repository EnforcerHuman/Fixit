import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  Future<User?> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Check if the user already exists in Firestore
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: googleUser.email)
          .get();

      if (userDoc.docs.isNotEmpty) {
        // User already exists
        print('User already exists');
        return null;
      }

      // If user doesn't exist, proceed with sign up
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User? user = userCredential.user;

      if (user != null) {
        // Create new user document in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('New user created and stored in Firestore');
      }

      return user;
    } catch (e) {
      print('Error during Google sign up: $e');
      return null;
    }
  }
  //Login with google

  Future<void> loginWithGoogle() async {
    try {
      // Trigger the Google sign-in flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        // Obtain the auth details from the Google sign-in
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential using the Google tokens
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        try {
          // Attempt to sign in with the credential
          final UserCredential userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);

          // Check if the user is new
          if (userCredential.additionalUserInfo?.isNewUser ?? false) {
            // User doesn't exist, show SnackBar
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('User does not exist. Please sign up first.'),
            //     duration: Duration(seconds: 3),
            //   ),
            // );
            // Sign out the user since they don't have an account
            await FirebaseAuth.instance.signOut();
            await GoogleSignIn().signOut();
          } else {
            // User exists, do something like navigate to next page
            print('User logged in: ${userCredential.user?.displayName}');
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Logged in'),
            //     duration: Duration(seconds: 3),
            //   ),
            // );
            // You can add navigation logic here
          }
        } on FirebaseAuthException catch (e) {
          // Handle Firebase Auth specific errors
          print('Firebase Auth Error: ${e.message}');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('Login failed: ${e.message}'),
          //     duration: Duration(seconds: 3),
          //   ),
          // );
        }
      } else {
        // Handle case where user cancels sign-in
        print('User cancelled sign-in.');
      }
    } catch (e) {
      // Handle other errors
      print('Error logging in with Google: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('An error occurred. Please try again.'),
      //     duration: Duration(seconds: 3),
      //   ),
      // );
    }
  }
}
