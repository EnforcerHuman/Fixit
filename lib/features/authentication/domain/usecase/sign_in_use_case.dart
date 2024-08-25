import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_phone_auth_services.dart';
import 'package:fixit/features/authentication/data/datasources/firestore_data_services.dart';

class SignInUseCase {
  PhoneAuthentication firebaseauth = PhoneAuthentication();
  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseauth.login(email, password);

      return userCredential;
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  Future<bool> handleSignInSuccesss(UserCredential userCredential) async {
    FirestoreDataServices firestoreDataServices = FirestoreDataServices();
    Map<String, dynamic>? userDetails = await firestoreDataServices
        .getUserDetailsById(userCredential.user!.uid);
    // AuthLocalDataService.setUserName(userDetails?['id']);
    if (userDetails?['isServiceProvider'] == false) {
      AuthLocalDataService.setLoginStatus(true);
      AuthLocalDataService.setUserKey(userDetails?['id']);
      AuthLocalDataService.setUserName(userDetails?['name']);
      return true;
    } else {
      return false;
    }
    // return userDetails?['isServiceProvider'] ?? false;
  }
}
