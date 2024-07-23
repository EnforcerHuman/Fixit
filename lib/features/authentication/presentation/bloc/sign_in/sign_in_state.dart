part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

class SignInProcessing extends SignInState {}

class SignInSuccess extends SignInState {
  UserCredential userCredential;
  SignInSuccess(this.userCredential);
}

class SignInError extends SignInState {
  final String error;

  SignInError(this.error);
}

class GoogleSignInSucess extends SignInState {}

class GoogleSignInError extends SignInState {
  final String error;

  GoogleSignInError(this.error);
}

class GoogleSignInProcessing extends SignInState {}
