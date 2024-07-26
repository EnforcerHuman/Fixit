import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailcontroller;
  const EmailField({super.key, required this.emailcontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailcontroller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
    );
  }
}
