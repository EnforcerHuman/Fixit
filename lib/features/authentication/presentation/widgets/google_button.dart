import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Image.asset('assets/img/Google_logo.png'),
      label: const Text('Google'),
    );
  }
}
