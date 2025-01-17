import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String service;
  final double amount;
  final String bookingDate;
  final String partnerName;
  final VoidCallback onButtonPressed;
  const BookingCard({
    super.key,
    required this.service,
    required this.amount,
    required this.bookingDate,
    required this.partnerName,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isSmallScreen = width < 600;
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16.0 : 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.plumbing, size: isSmallScreen ? 24 : 32),
                      const SizedBox(width: 8),
                      Text(
                        service,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isSmallScreen ? 12 : 16),
                  _buildInfoRow(
                      'Amount per hour', '₹${amount.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  _buildInfoRow('Booking date', bookingDate),
                  const SizedBox(height: 8),
                  _buildInfoRow('Provider name', partnerName, isBlue: true),
                  SizedBox(height: isSmallScreen ? 16 : 24),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     TextButton(
                  //         onPressed: onButtonPressed,
                  //         child: const Text(
                  //           "cancel booking request",
                  //           selectionColor: Colors.red,
                  //         )),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBlue = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isBlue ? Colors.blue : null,
          ),
        ),
      ],
    );
  }
}
