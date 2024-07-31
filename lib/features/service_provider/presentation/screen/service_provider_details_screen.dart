import 'package:flutter/material.dart';

class ServiceProviderProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    'https://c7.alamy.com/comp/J8JE7P/woman-lady-female-standing-plumber-plumbing-workers-laborer-worker-J8JE7P.jpg',
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emily Jani',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Plumber',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber),
                        Text('4.8'),
                        SizedBox(width: 16),
                        Text('56 Orders'),
                        SizedBox(width: 16),
                        Text('4 Years'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Skills',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.kitchen, size: 40),
                    Text('Sink'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.shower, size: 40),
                    Text('Shower'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.healing, size: 40),
                    Text('Boiler'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.wc, size: 40),
                    Text('Toilet'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your booking functionality here
                },
                child: Text('Book'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Bio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "I'm Emily Jani, a dedicated plumbing professional with a passion for delivering top-notch service to ensure your home's plumbing runs smoothly. With nine years of hands-on experience.",
            ),
          ],
        ),
      ),
    );
  }
}
