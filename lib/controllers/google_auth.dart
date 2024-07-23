// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:google_sign_in/google_sign_in.dart';

// // class GoogleAuth {
// //   Future<void> signInWithGoogle() async {
// //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// //     if (googleUser != null) {
// //       final GoogleSignInAuthentication googleAuth =
// //           await googleUser.authentication;
// //       final AuthCredential credential = GoogleAuthProvider.credential(
// //         accessToken: googleAuth.accessToken,
// //         idToken: googleAuth.idToken,
// //       );
// //       await FirebaseAuth.instance.signInWithCredential(credential);
// //     }
// //   }
// // }

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleAuth {
//   Future<void> signUpWithGoogle(BuildContext context) async {
//     final FirebaseAuth _auth = FirebaseAuth.instance;

//     try {
//       // Trigger the Google sign-in flow.
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser != null) {
//         // Obtain the auth details from the Google sign-in.
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         // Create a new credential using the Google tokens.
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         // Check if the user already exists with Firebase.
//         final userCredential = await _auth.signInWithCredential(credential);
//         final user = userCredential.user;

//         if (user != null) {
//           // User already exists, do something like navigate to next page.
//           print('User already exists: ${user.displayName}');
//           // Navigate to the next page or perform any action needed for existing users.
//         } else {
//           // User does not exist, create a new account.
//           final newUserCredential = await _auth.createUserWithEmailAndPassword(
//             email: googleUser.email,
//             password:
//                 'random_password', // You can generate a random password or handle this differently.
//           );

//           final newUser = newUserCredential.user;
//           if (newUser != null) {
//             // New user created, do something like navigate to next page.
//             print('New user created: ${newUser.displayName}');
//             // Navigate to the next page or perform any action needed for new users.
//           }
//         }
//       } else {
//         // Handle case where user cancels sign-in.
//         print('User cancelled sign-in.');
//         // Optionally show a message to the user that sign-in was cancelled.
//       }
//     } catch (e) {
//       // Handle other errors.
//       print('Error signing up with Google: $e');
//       // Display an error message or handle the error as needed.
//     }
//   }

//   Future<void> loginWithGoogle(BuildContext context) async {
//     try {
//       // Trigger the Google sign-in flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       if (googleUser != null) {
//         // Obtain the auth details from the Google sign-in
//         final GoogleSignInAuthentication googleAuth =
//             await googleUser.authentication;

//         // Create a new credential
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );

//         try {
//           // Check if the user exists without signing in
//           final signInMethods = await FirebaseAuth.instance
//               // ignore: deprecated_member_use
//               .fetchSignInMethodsForEmail(googleUser.email);

//           if (signInMethods.isNotEmpty) {
//             // User exists, proceed with sign in
//             final UserCredential userCredential =
//                 await FirebaseAuth.instance.signInWithCredential(credential);

//             print('User logged in: ${userCredential.user?.displayName}');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Logged in successfully'),
//                 duration: Duration(seconds: 3),
//               ),
//             );
//             // You can add navigation logic here
//           } else {
//             // User doesn't exist, show SnackBar without creating a new user
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('User does not exist. Please sign up first.'),
//                 duration: Duration(seconds: 3),
//               ),
//             );
//           }
//         } on FirebaseAuthException catch (e) {
//           print('Firebase Auth Error: ${e.message}');
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Login failed: ${e.message}'),
//               duration: Duration(seconds: 3),
//             ),
//           );
//         }
//       } else {
//         // Handle case where user cancels sign-in
//         print('User cancelled sign-in.');
//       }
//     } catch (e) {
//       print('Error logging in with Google: $e');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('An error occurred. Please try again.'),
//           duration: Duration(seconds: 3),
//         ),
//       );
//     } finally {
//       // Always sign out from Google to ensure a clean state
//       await GoogleSignIn().signOut();
//     }
//   }
//   //Login with google

//   // Future<void> loginWithGoogle(BuildContext context) async {
//   //   try {
//   //     // Trigger the Google sign-in flow
//   //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   //     if (googleUser != null) {
//   //       // Obtain the auth details from the Google sign-in
//   //       final GoogleSignInAuthentication googleAuth =
//   //           await googleUser.authentication;

//   //       // Create a new credential using the Google tokens
//   //       final AuthCredential credential = GoogleAuthProvider.credential(
//   //         accessToken: googleAuth.accessToken,
//   //         idToken: googleAuth.idToken,
//   //       );

//   //       try {
//   //         // Attempt to sign in with the credential
//   //         final UserCredential userCredential =
//   //             await FirebaseAuth.instance.signInWithCredential(credential);

//   //         // Check if the user is new
//   //         if (userCredential.additionalUserInfo?.isNewUser ?? false) {
//   //           // User doesn't exist, show SnackBar
//   //           ScaffoldMessenger.of(context).showSnackBar(
//   //             SnackBar(
//   //               content: Text('User does not exist. Please sign up first.'),
//   //               duration: Duration(seconds: 3),
//   //             ),
//   //           );
//   //           // Sign out the user since they don't have an account
//   //           await FirebaseAuth.instance.signOut();
//   //           await GoogleSignIn().signOut();
//   //         } else {
//   //           // User exists, do something like navigate to next page
//   //           print('User logged in: ${userCredential.user?.displayName}');
//   //           ScaffoldMessenger.of(context).showSnackBar(
//   //             SnackBar(
//   //               content: Text('Logged in'),
//   //               duration: Duration(seconds: 3),
//   //             ),
//   //           );
//   //           // You can add navigation logic here
//   //         }
//   //       } on FirebaseAuthException catch (e) {
//   //         // Handle Firebase Auth specific errors
//   //         print('Firebase Auth Error: ${e.message}');
//   //         ScaffoldMessenger.of(context).showSnackBar(
//   //           SnackBar(
//   //             content: Text('Login failed: ${e.message}'),
//   //             duration: Duration(seconds: 3),
//   //           ),
//   //         );
//   //       }
//   //     } else {
//   //       // Handle case where user cancels sign-in
//   //       print('User cancelled sign-in.');
//   //     }
//   //   } catch (e) {
//   //     // Handle other errors
//   //     print('Error logging in with Google: $e');
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text('An error occurred. Please try again.'),
//   //         duration: Duration(seconds: 3),
//   //       ),
//   //     );
//   //   }
//   // }
// }
