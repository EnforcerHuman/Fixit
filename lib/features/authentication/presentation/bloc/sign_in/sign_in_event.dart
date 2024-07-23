part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SignInUser extends SignInEvent {
  final String email;
  final String password;

  SignInUser(this.email, this.password);
}

class StoreStatus extends SignInEvent {}

class SignInWithGoogle extends SignInEvent {}
