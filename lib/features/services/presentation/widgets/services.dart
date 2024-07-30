import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final Service service;

  ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    List<Service> services = [
      Service(name: 'Plumbing', image: 'assets/img/Fixit_logo.png'),
      Service(name: 'Electric work', image: 'assets/img/Fixit_logo.png'),
      Service(name: 'Solar', image: 'assets/img/Fixit_logo.png'),
      // Add more services as needed
    ];
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              service.image,
              height: 60,
            ),
            const SizedBox(height: 8),
            Text(
              service.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Service {
  final String name;
  final String image;

  Service({required this.name, required this.image});
}
