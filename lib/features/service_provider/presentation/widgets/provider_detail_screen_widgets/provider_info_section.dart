import 'package:flutter/material.dart';

class ProviderInfoSection extends StatelessWidget {
  final Map<String, dynamic> providerDetails;

  const ProviderInfoSection({Key? key, required this.providerDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          providerDetails['name'],
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          providerDetails['serviceArea'],
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
