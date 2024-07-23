import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_google_aauth_services.dart';
import 'package:fixit/features/authentication/data/datasources/firebase_phone_auth_services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    GoogleAuth gauth = GoogleAuth();
    PhoneAuthentication auth = PhoneAuthentication();

    on<SignInEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SignInUser>((event, emit) async {
      emit(SignInProcessing());
      try {
        UserCredential userCredential =
            await auth.login(event.email, event.password);
        await Future.delayed(Duration(seconds: 5));
        emit(SignInSuccess(userCredential));
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        } else {
          errorMessage = 'An error occurred: ${e.message}';
        }
        emit(SignInError(errorMessage));
      } catch (e) {
        await Future.delayed(Duration(seconds: 5));
        emit(SignInError(e.toString()));
      }
    });
    on<SignInWithGoogle>((event, emit) async {
      emit(GoogleSignInProcessing());
      try {
        await gauth.loginWithGoogle();
        emit(GoogleSignInSucess());
      } catch (e) {
        emit(GoogleSignInError(e.toString()));
      }
    });
  }
}
