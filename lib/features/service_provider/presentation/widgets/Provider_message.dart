import 'package:flutter/material.dart';

class ProviderMessage extends StatelessWidget {
  final String message;
  const ProviderMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message),
    );
  }
}
