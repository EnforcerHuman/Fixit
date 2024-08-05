import 'package:flutter/material.dart';

class BioSection extends StatelessWidget {
  final String bio;

  const BioSection({Key? key, required this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(bio, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
