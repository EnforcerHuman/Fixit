import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController namecontroller;
  const NameField({super.key, required this.namecontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: namecontroller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter your name',
        prefixIcon: Icon(Icons.person_2_outlined),
        border: OutlineInputBorder(),
      ),
    );
  }
}
