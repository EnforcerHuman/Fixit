import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/features/authentication/data/datasources/auth_local%20_data_service.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_phone_auth_services.dart';
import 'package:fixit/features/authentication/data/datasources/firestore_data_services.dart';

class SignInUseCase {
  PhoneAuthentication firebaseauth = PhoneAuthentication();
  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseauth.login(email, password);

      print(userCredential.user?.uid);
      return userCredential;
    } catch (e) {
      throw Exception('Error signing in: $e');
    }
  }

  Future<bool> handleSignInSuccesss(UserCredential userCredential) async {
    FirestoreDataServices firestoreDataServices = FirestoreDataServices();
    Map<String, dynamic>? userDetails = await firestoreDataServices
        .getUserDetailsById(userCredential.user!.uid);
    print('**88888888888888888888888');
    print(userCredential.user?.uid);
    // AuthLocalDataService.setUserName(userDetails?['id']);
    if (userDetails?['isServiceProvider'] == true) {
      AuthLocalDataService.setLoginStatus(true);
      AuthLocalDataService.setUserKey(userDetails?['id']);
    }
    return userDetails?['isServiceProvider'] ?? false;
  }
}
