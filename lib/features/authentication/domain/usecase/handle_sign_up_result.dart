import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixit/features/authentication/presentation/bloc/User/user_bloc.dart';
import 'package:fixit/features/authentication/presentation/screens/otp_screen.dart';
import 'package:fixit/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HandleSignUpResultCase {
  void onGoogleSignUpSuccess(BuildContext context, User user) {
    context.read<UserBloc>().add(UpdateUserId(user.uid));
    context.read<UserBloc>().add(UpdateEmail(user.email ?? ''));
    context.read<UserBloc>().add(UpdateName(user.displayName ?? ''));
    context.read<UserBloc>().add(UpdatePhone(user.phoneNumber ?? ''));
    context.read<UserBloc>().add(SubmitUserDate());
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
        (route) => false);
  }

  void onGoogleSignUpFailed(context, String errorMessage) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(errorMessage)));
  }

  void onOtpSent(BuildContext context, String verificationId, String email,
      String password, String phone) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => OtpScreen(
              verificationId: verificationId,
              email: email,
              password: password,
              phone: phone,
            )));
  }
}
