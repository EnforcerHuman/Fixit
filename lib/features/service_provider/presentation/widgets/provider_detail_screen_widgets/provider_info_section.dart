import 'package:flutter/material.dart';

class ProviderInfoSection extends StatelessWidget {
  final Map<String, dynamic> providerDetails;

  const ProviderInfoSection({super.key, required this.providerDetails});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
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
      ),
    );
  }
}
