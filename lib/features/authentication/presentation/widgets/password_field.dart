import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController passwordcontroller;
  const PasswordField({super.key, required this.passwordcontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordcontroller,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty || value.length < 6) {
          return 'Please enter a valid password';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter your password',
        prefixIcon: Icon(Icons.lock),
        suffixIcon: Icon(Icons.visibility_off),
        border: OutlineInputBorder(),
      ),
    );
  }
}
