import 'package:fixit/features/service_provider/presentation/widgets/provider_info_item.dart';
import 'package:flutter/material.dart';

class ProviderStatsSection extends StatelessWidget {
  final Map<String, dynamic> providerDetails;

  const ProviderStatsSection({Key? key, required this.providerDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ProviderInfoItem(icon: Icons.star, value: '4.8', label: 'Rating'),
        const ProviderInfoItem(
            icon: Icons.check_circle_outline,
            value: '56 Orders',
            label: 'Completed'),
        ProviderInfoItem(
            icon: Icons.access_time,
            value: providerDetails['experience'],
            label: 'Experience'),
      ],
    );
  }
}
