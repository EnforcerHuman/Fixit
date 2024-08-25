import 'package:fixit/features/service_provider/presentation/widgets/skill_chip.dart';
import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: [
            SkillChip(label: 'Sink'),
            SkillChip(label: 'Shower'),
            SkillChip(label: 'Boiler'),
            SkillChip(label: 'Toilet'),
          ],
        ),
      ],
    );
  }
}
