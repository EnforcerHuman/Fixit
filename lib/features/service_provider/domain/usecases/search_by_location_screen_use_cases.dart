import 'package:fixit/features/service_provider/presentation/screen/current_location_providers.dart';
import 'package:flutter/material.dart';

class SearchByLocationScreenUseCases {
  void onCheckAvailability(
      double userLongitude, BuildContext context, double userLatitude) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => CurrentLocationProviders(
            latitude: userLatitude, longitude: userLongitude!)));
  }
}
