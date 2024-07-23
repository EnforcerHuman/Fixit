import 'package:flutter/material.dart';

class OtpField extends StatelessWidget {
  final TextEditingController textcontroller;
  const OtpField({super.key, required this.textcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        height: 70,
        child: TextField(
          controller: textcontroller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
