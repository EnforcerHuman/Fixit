import 'package:flutter/material.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController phonecontroller;
  const PhoneNumberField({super.key, required this.phonecontroller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: phonecontroller,
      validator: (value) {
        if (value == null || value.isEmpty && value.length < 10) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter your phone',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(),
      ),
    );
  }
}
