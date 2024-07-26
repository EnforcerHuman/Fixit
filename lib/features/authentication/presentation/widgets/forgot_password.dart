import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // Handle forgot password
        },
        child: const Text('Forgot Password?').animate().fade().scale(),
      ),
    );
  }
}
