part of 'sign_up_bloc.dart';

sealed class SignUpEvent {}

class SendOTPEvent extends SignUpEvent {
  final String phone;
  final String email;
  final String password;
  SendOTPEvent(this.phone, this.email, this.password);
}

class VerifyOTPEvent extends SignUpEvent {
  final String otp;
  final String verificationId;
  final String email;
  final String password;

  VerifyOTPEvent(this.otp, this.verificationId, this.email, this.password);
}

class LinkEmailPasswordEvent extends SignUpEvent {
  final String email;
  final String password;

  LinkEmailPasswordEvent(this.email, this.password);
}

class GoogleVeification extends SignUpEvent {}
