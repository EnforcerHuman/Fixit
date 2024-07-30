import 'package:fixit/features/service_provider/data/data_sources.dart/service_provider_data_source.dart';
import 'package:flutter/material.dart';

class PopularServicesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ServiceProviderDataSource providerDataSource = ServiceProviderDataSource();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular Services',
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text('View all'),
          ),
        ],
      ),
    );
  }
}
