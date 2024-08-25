import 'package:fixit/features/home/presentation/screens/home_screen.dart';
import 'package:fixit/features/main_navigation/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';

abstract class HandleAuthResultUseCase {
  void onSignInSuccess(BuildContext context);
  void onSignInError(BuildContext context, String error);
  void onGoogleSignInSuccess(BuildContext context);
  void onGoogleSignInError(BuildContext context, String error);
}

class HandleAuthResultUseCaseImpl implements HandleAuthResultUseCase {
  @override
  void onSignInSuccess(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => const MainScreen()),
      (route) => false,
    );
  }

  @override
  void onSignInError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }

  @override
  void onGoogleSignInSuccess(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (ctx) => HomeScreen()),
      (route) => false,
    );
  }

  @override
  void onGoogleSignInError(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  }
}
