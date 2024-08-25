import 'package:flutter/material.dart';

class CustomServiceCard extends StatelessWidget {
  final String serviceType;
  final String price;

  const CustomServiceCard({
    super.key,
    required this.serviceType,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  serviceType,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                // Uncomment and use the image if needed
                // Image.asset('assets/wiring_icon.png', width: 40, height: 40),
              ],
            ),
            const SizedBox(height: 10),
            _buildInfoRow('Type', serviceType),
            _buildInfoRow('Price', '$price/hour'),
            _buildInfoRow('Material', 'Not Included'),
            _buildInfoRow('Traveling', 'Free'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
