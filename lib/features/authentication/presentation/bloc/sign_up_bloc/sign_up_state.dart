part of 'sign_up_bloc.dart';

abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class OTPSentState extends SignUpState {
  final String verificationId;
  final String email;
  final String password;
  final String id;

  OTPSentState(this.verificationId, this.password, this.id, this.email);
}

class OtpSendingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final UserCredential userCredential;
  SignUpSuccessState(this.userCredential);
}

class EmailPasswordLinkedState extends SignUpState {}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState(this.error);
}

class OtpVerifyingState extends SignUpState {}

class GoogleSignUpLoading extends SignUpState {}

class GoogleSignUpFailed extends SignUpState {
  final String errorMessage;

  GoogleSignUpFailed(this.errorMessage);
}

class GoogleSignUpSuccess extends SignUpState {
  final User? user;

  GoogleSignUpSuccess(this.user);
}
