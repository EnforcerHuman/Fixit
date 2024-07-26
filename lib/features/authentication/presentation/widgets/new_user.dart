import 'package:flutter/material.dart';

class NewUser extends StatelessWidget {
  final VoidCallback onTap;
  const NewUser({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('New to fixit?'),
        TextButton(
          onPressed: onTap,
          child: const Text('Sign up now'),
        ),
      ],
    );
  }
}
